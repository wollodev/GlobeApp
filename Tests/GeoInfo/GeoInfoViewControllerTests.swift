import XCTest
import CoreLocation

@testable import Globe

class GeoInfoViewControllerTests: XCTestCase {

    let testCoordinate = CLLocationCoordinate2D(latitude: 50.0, longitude: 10.0)

    func testGeoInfoViewControllerUpdateCoordinate() {
        let initExpecation = expectation(description: "init expecation")
        let updateExpectation = expectation(description: "update coordinate expectation")

        let mockReverseGeocoder = ReverseGeocoderMock()
        mockReverseGeocoder.returnError = ReverseGeocoderError.noResult
        mockReverseGeocoder.callback = {
            initExpecation.fulfill()
        }
        let geoInfoViewModel = GeoInfoViewModel(reverseGeocoder: mockReverseGeocoder)
        let subject = GeoInfoViewController(viewModel: geoInfoViewModel, coordinate: testCoordinate)

        // will call viewDidLoad()
        _ = subject.view

        wait(for: [initExpecation], timeout: 0.1)

        mockReverseGeocoder.returnError = nil
        mockReverseGeocoder.returnAddress = ReverseGeocoderAddress(street: "A", postalCode: "B", city: "C", country: "D")
        mockReverseGeocoder.callback = {
            updateExpectation.fulfill()
        }

        subject.update(for: testCoordinate)

        wait(for: [updateExpectation], timeout: 0.1)
    }
}
