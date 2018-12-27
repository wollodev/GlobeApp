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
        state.swap(.inProgress)
        reverseGeocoder
            .reverseGeocodeCoordinate(coordinate)
            .take(during: lifetime)
            .startWithResult { [weak self] result in
            switch result {
            case .success(let address):
                self?.state.swap(.loaded)
                self?.update(with: address)
            case .failure:
                self?.state.swap(.failed)
            }
        }
    }

    private func update(with address: ReverseGeocoderAddress) {
        streetText.swap(address.street)
        cityAndCountryText.swap("\(address.postalCode) \(address.city),\(address.country)")
    }
}
