import XCTest
import CoreLocation

@testable import Globe

class GeoInfoViewModelTests: XCTestCase {

    let mockReverseGeocoder = ReverseGeocoderMock()
    lazy var subject = GeoInfoViewModel(reverseGeocoder: mockReverseGeocoder)
    let testCoordinate = CLLocationCoordinate2D(latitude: 50.0, longitude: 6.0)

    override func tearDown() {
        mockReverseGeocoder.returnAddress = nil
        mockReverseGeocoder.returnError = nil
    }

    func testFetchAddressWithReturningNoResultError() {
        let noResultExpectation = expectation(description: "fetch address with error no result")

        mockReverseGeocoder.returnError = ReverseGeocoderError.noResult
        mockReverseGeocoder.callback = {
            noResultExpectation.fulfill()
        }

        XCTAssertEqual(subject.state.value, GeoInfoViewModel.State.inProgress)

        subject.fetchAddress(for: testCoordinate)

        XCTAssertEqual(subject.state.value, GeoInfoViewModel.State.failed)
        XCTAssertNil(subject.cityAndCountryText.value)
        XCTAssertEqual(subject.streetText.value, R.string.localizable.geoInfoNoResult())

        waitForExpectations(timeout: 0.1)
    }

    func testFetchAddressWithReturningNetworkError() {
        let noResultExpectation = expectation(description: "fetch address with networkError")

        mockReverseGeocoder.returnError = ReverseGeocoderError.networkError
        mockReverseGeocoder.callback = {
            noResultExpectation.fulfill()
        }

        XCTAssertEqual(subject.state.value, GeoInfoViewModel.State.inProgress)

        subject.fetchAddress(for: testCoordinate)

        XCTAssertEqual(subject.state.value, GeoInfoViewModel.State.failed)
        XCTAssertNil(subject.cityAndCountryText.value)
        XCTAssertEqual(subject.streetText.value, R.string.localizable.geoInfoError())

        waitForExpectations(timeout: 0.1)
    }

    func testFetchAddressSuccessfully() {
        let noResultExpectation = expectation(description: "fetch address successfully")

        let testAddress = ReverseGeocoderAddress(street: "teststreet 1", postalCode: "12345", city: "testcity", country: "testcountry")

        mockReverseGeocoder.returnAddress = testAddress
        mockReverseGeocoder.callback = {
            noResultExpectation.fulfill()
        }

        XCTAssertEqual(subject.state.value, GeoInfoViewModel.State.inProgress)

        subject.fetchAddress(for: testCoordinate)

        XCTAssertEqual(subject.state.value, GeoInfoViewModel.State.loaded)
        XCTAssertEqual(subject.streetText.value, "teststreet 1")
        XCTAssertEqual(subject.cityAndCountryText.value, "12345 testcity, testcountry")

        waitForExpectations(timeout: 0.1)
    }
}
