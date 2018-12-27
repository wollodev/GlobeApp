import ReactiveSwift

class GeoInfoViewModel {

    // MARK: - Properties

    let streetName = MutableProperty<String?>(nil)
    let postalCode = MutableProperty<String?>(nil)
    let cityName = MutableProperty<String?>(nil)
    let countryName = MutableProperty<String?>(nil)

    // MARK: - Private Properties

    private let reverseGeocoder: ReverseGeocoder

    // MARK: - Init

    init(reverseGeocoder: ReverseGeocoder) {
        self.reverseGeocoder = reverseGeocoder
    }

}
