import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    // MARK: - Subviews

    private lazy var mapView: GMSMapView = {
        let mapView = GMSMapView(frame: .zero)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        mapView.constraint(to: view)

        let coordinates = CLLocationCoordinate2D(latitude: 51.0902094, longitude: 6.585863)
        mapView.camera = GMSCameraPosition(target: coordinates, zoom: 15, bearing: 0, viewingAngle: 0)

        mapView.delegate = self

        return mapView
    }()

    // MARK: - UIViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    private func setupViews() {
        _ = mapView
    }

    // MARK: - Methods

    private func showInfoScreen(for coordinate: CLLocationCoordinate2D) {
        let reverseGeocoder = GoogleMapsReverseGeocoder()
        let infoViewModel = GeoInfoViewModel(reverseGeocoder: reverseGeocoder)
        let info = GeoInfoViewController(viewModel: infoViewModel)
        info.view.backgroundColor = .red

        self.embed(info, with: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100))
    }

}

// MARK: - GMSMapViewDelegate

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        showInfoScreen(for: coordinate)
    }
}
