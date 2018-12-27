import UIKit
import ReactiveCocoa

class GeoInfoViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: GeoInfoViewModel

    // MARK: - Subviews

    // MARK: - Init

    init(viewModel: GeoInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIViewController Lifecycle

    override func viewDidLoad() {
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
