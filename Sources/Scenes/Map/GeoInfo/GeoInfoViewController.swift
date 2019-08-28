import CoreLocation
import ReactiveCocoa
import ReactiveSwift
import UIKit

protocol GeoInfoViewControllerDelegate: AnyObject {
    func geoInfoViewControllerSelectClose(_ viewController: GeoInfoViewController)
}

class GeoInfoViewController: UIViewController {
    // MARK: - Properties

    private let viewModel: GeoInfoViewModel

    weak var delegate: GeoInfoViewControllerDelegate?

    // MARK: - IBOutlets

    @IBOutlet private weak var contentContainer: UIStackView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!

    // MARK: - Init

    init(viewModel: GeoInfoViewModel, coordinate: CLLocationCoordinate2D) {
        self.viewModel = viewModel
        self.viewModel.fetchAddress(for: coordinate)
        super.init(nibName: GeoInfoViewController.className, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        resetSubviews()
        setupView()
        bindViewModel()
        update(state: viewModel.state.value)
    }

    // MARK: - Setup

    private func resetSubviews() {
        titleLabel.text = nil
        subtitleLabel.text = nil
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
        titleLabel.reactive.text <~ viewModel.streetText
        subtitleLabel.reactive.text <~ viewModel.cityAndCountryText

        viewModel
            .state
            .signal
            .observe(on: UIScheduler())
            .observeValues { [unowned self] state in
                self.update(state: state)
            }
    }

    private func update(state: GeoInfoViewModel.State) {
        switch state {
        case .loaded:
            subtitleLabel.isHidden = false
            (view as? ProgressDisplayable)?.stopProgress()
        case .failed:
            subtitleLabel.isHidden = true
            (view as? ProgressDisplayable)?.stopProgress()
        case .inProgress:
            subtitleLabel.isHidden = false
            (view as? ProgressDisplayable)?.startProgress()
        }
    }

    // MARK: - External Methods

    func update(for coordinates: CLLocationCoordinate2D) {
        self.viewModel.fetchAddress(for: coordinates)
    }

    // MARK: - IBActions

    @IBAction private func didPressCloseButton(_ sender: UIButton) {
        delegate?.geoInfoViewControllerSelectClose(self)
    }
}
