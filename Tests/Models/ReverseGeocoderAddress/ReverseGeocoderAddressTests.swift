import XCTest

@testable import Globe

class ReverseGeocoderAddressTests: XCTestCase {

    func testReverseGeocoderAddressFromJson() {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "Address", withExtension: "json") else {
            XCTFail("Missing file: Address.json")
            return
        }

        do {
            let json = try Data(contentsOf: url)
            let address = try JSONDecoder().decode(ReverseGeocoderAddress.self, from: json)
            XCTAssertEqual(address.city, "Grevenbroich")
            XCTAssertEqual(address.country, "Germany")
            XCTAssertEqual(address.postalCode, "41515")
            XCTAssertEqual(address.street, "Am Stadtpark 6")
        } catch {
            XCTFail("decoding error: \(error)")
        }
    }

    func testReverseGeocoderAddressFromJsonWithoutResult() {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "NoAddressResult", withExtension: "json") else {
            XCTFail("Missing file: NoAddressResult.json")
            return
        }

        do {
            let json = try Data(contentsOf: url)
            _ = try JSONDecoder().decode(ReverseGeocoderAddress.self, from: json)
        } catch ReverseGeocoderError.noResult {
            XCTAssert(true)
        } catch {
            XCTFail("wrong error \(error)")
        }
    }
}
