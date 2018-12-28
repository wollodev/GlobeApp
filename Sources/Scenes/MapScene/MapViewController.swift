import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    // MARK: - Constants

    let startingCoordinate = CLLocationCoordinate2D(latitude: 51.0902094, longitude: 6.585863)
    let zoomLevel = Float(15.0)

    // MARK: - Properties

    private lazy var mapView: GMSMapView = {
        let mapView = GMSMapView(frame: .zero)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        mapView.constraint(to: view, with: .zero)

        mapView.camera = GMSCameraPosition(target: startingCoordinate, zoom: zoomLevel, bearing: 0, viewingAngle: 0)

        mapView.delegate = self

        return mapView
    }()

    private lazy var reverseGeocoder = GoogleMapsReverseGeocoder()

    private weak var overlay: GeoInfoViewController?

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
        let geoInfoViewModel = GeoInfoViewModel(reverseGeocoder: reverseGeocoder)
        let geoInfoViewController = GeoInfoViewController(viewModel: geoInfoViewModel, coordinate: coordinate)
        geoInfoViewController.view.backgroundColor = .red

        let insets = UIView.Insets(left: 20.0, bottom: 20.0, right: 20.0)
        self.embed(geoInfoViewController, with: insets, respectSafeArea: true)

        self.overlay = geoInfoViewController
    }

}

// MARK: - GMSMapViewDelegate

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        guard let infoViewController = self.overlay else {
            showInfoScreen(for: coordinate)
            return
        }

        infoViewController.update(for: coordinate)
    }
}
