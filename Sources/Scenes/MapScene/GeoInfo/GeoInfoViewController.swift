import UIKit
import CoreLocation
import ReactiveCocoa
import ReactiveSwift

class GeoInfoViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: GeoInfoViewModel

    // MARK: - IBOutlets

    @IBOutlet private weak var container: UIView!
    @IBOutlet private weak var streetLabel: UILabel!
    @IBOutlet private weak var cityAndCountryLabel: UILabel!

    // MARK: - Init

    init(viewModel: GeoInfoViewModel, coordinate: CLLocationCoordinate2D) {
        self.viewModel = viewModel
        self.viewModel.fetchAddress(for: coordinate)
        super.init(nibName: GeoInfoViewController.className, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIViewController Lifecycle

    override func viewDidLoad() {
        resetSubviews()
        setupView()
        bindViewModel()
    }

    private func resetSubviews() {
        streetLabel.text = nil
        cityAndCountryLabel.text = nil
    }

    private func setupView() {
        view.translatesAutoresizingMaskIntoConstraints = false
        makeRoundCorners()
    }

    private func makeRoundCorners() {
        view.layer.cornerRadius = 22.0
        view.layer.masksToBounds = true
    }

    private func bindViewModel() {
        streetLabel.reactive.text <~ viewModel.streetText
        cityAndCountryLabel.reactive.text <~ viewModel.cityAndCountryText
    }

    // MARK: - External Methods

    func update(for coordinates: CLLocationCoordinate2D) {
        self.viewModel.fetchAddress(for: coordinates)
    }

    // MARK: - IBActions

    @IBAction private func didPressCloseButton(_ sender: UIButton) {
        remove()
    }
}
