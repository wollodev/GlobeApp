import CoreLocation
import ReactiveSwift

protocol ReverseGeocoder {
    func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) -> SignalProducer<ReverseGeocoderAddress, ReverseGeocoderError>
}
