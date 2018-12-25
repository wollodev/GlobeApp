import UIKit
import GoogleMaps

class ViewController: UIViewController {

    @IBOutlet private weak var mapView: GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let coordinates = CLLocationCoordinate2D(latitude: 51.0902094, longitude: 6.585863)
        mapView.camera = GMSCameraPosition(target: coordinates, zoom: 15, bearing: 0, viewingAngle: 0)
    }
}
