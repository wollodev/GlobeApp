import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    // MARK: - Constants

    let startingCoordinate = CLLocationCoordinate2D(latitude: 53.5499242, longitude: 9.9839786)
    let zoomLevel = Float(15.0)
    let geoInfoInsertAnimationDuration = 0.2

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

    private func presentInfo(for coordinate: CLLocationCoordinate2D) {
        let geoInfoViewModel = GeoInfoViewModel(reverseGeocoder: reverseGeocoder)
        let geoInfoViewController = GeoInfoViewController(viewModel: geoInfoViewModel, coordinate: coordinate)
        geoInfoViewController.view.alpha = 0

        let insets = UIView.Insets(left: 20.0, bottom: 20.0, right: 20.0)
        self.embed(geoInfoViewController, with: insets, respectSafeArea: true)

        UIView.animate(withDuration: geoInfoInsertAnimationDuration) {
            geoInfoViewController.view.alpha = 1.0
        }

        self.overlay = geoInfoViewController
        geoInfoViewController.delegate = self
    }

}

// MARK: - GMSMapViewDelegate

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        addMaker(at: coordinate)

        guard let infoViewController = self.overlay else {
            presentInfo(for: coordinate)
            return
        }

        infoViewController.update(for: coordinate)
    }

    private func addMaker(at coordinate: CLLocationCoordinate2D) {
        mapView.clear()
        let marker = MapMarker(at: coordinate)
        marker.map = mapView
    }
}

extension MapViewController: GeoInfoViewControllerDelegate {
    func geoInfoViewControllerSelectClose(_ viewController: GeoInfoViewController) {
        UIView.animate(withDuration: geoInfoInsertAnimationDuration, animations: {
            viewController.view.alpha = 0.0
        }, completion: { _ in
            viewController.remove()
        })
        self.mapView.clear()
    }
}
