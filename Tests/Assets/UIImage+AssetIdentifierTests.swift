import XCTest
@testable import Globe

// Tests if all assets are available and initializable

class UIImageAssetIdentifierTests: XCTestCase {
    func testAssets() {
        let assets = UIImage.AssetIdentifier.allCases
        let images = assets.compactMap { UIImage(assetIdentifier: $0) }

        XCTAssertEqual(assets.count, images.count)
    }
}
