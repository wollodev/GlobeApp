import CoreLocation
import ReactiveSwift

class GeoInfoViewModel {

    enum State {
        case inProgress
        case loaded
        case failed
    }

    // MARK: - Properties

    let state = MutableProperty<State>(.inProgress)
    let streetText = MutableProperty<String?>(nil)
    let cityAndCountryText = MutableProperty<String?>(nil)

    // MARK: - Private Properties

    private let reverseGeocoder: ReverseGeocoder
    private let (lifetime, token) = Lifetime.make()

    // MARK: - Init

    init(reverseGeocoder: ReverseGeocoder) {
        self.reverseGeocoder = reverseGeocoder
    }

    // MARK: - Fetch Address

    func fetchAddress(for coordinate: CLLocationCoordinate2D) {
        startInProgress()
        reverseGeocoder
            .reverseGeocodeCoordinate(coordinate)
            .take(during: lifetime)
            .startWithResult { [weak self] result in
                switch result {
                case .success(let address):
                    self?.update(with: address)
                case .failure(let error):
                    self?.update(with: error)
                }
        }
    }

    private func startInProgress() {
        state.swap(.inProgress)
        streetText.swap(nil)
        cityAndCountryText.swap(nil)
    }

    private func update(with error: ReverseGeocoderError) {
        state.swap(.failed)
        switch error {
        case .networkError, .parsingError:
            streetText.swap("🥴 *sigh* error.")
        case .noResult:
            streetText.swap("🙄 I found nothing, nada.")
        }
        cityAndCountryText.swap(nil)
    }

    private func update(with address: ReverseGeocoderAddress) {
        state.swap(.loaded)
        streetText.swap(address.street)
        cityAndCountryText.swap("\(address.postalCode) \(address.city), \(address.country)")
    }
}
