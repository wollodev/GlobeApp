import CoreLocation
import ReactiveSwift

protocol ReverseGeocoder {
    func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) -> SignalProducer<String, ReverseGeocoderError>
}
