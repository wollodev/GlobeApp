import CoreLocation
import ReactiveSwift

class GoogleMapsReverseGeocoder: ReverseGeocoder {
    func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) -> SignalProducer<String, ReverseGeocoderError> {
        return SignalProducer(value: "foo")
    }
}
