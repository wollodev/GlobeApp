import UIKit
import CoreLocation
import ReactiveCocoa
import ReactiveSwift

class GeoInfoViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: GeoInfoViewModel

    // MARK: - IBOutlets

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
        setupView()
        bindViewModel()
    }

    private func setupView() {
        view.translatesAutoresizingMaskIntoConstraints = false
    }

    private func bindViewModel() {
        streetLabel.reactive.text <~ viewModel.streetText
        cityAndCountryLabel.reactive.text <~ viewModel.cityAndCountryText
    }

    // MARK: - IBActions

    @IBAction private func didPressCloseButton(_ sender: UIButton) {
        remove()
    }
}
