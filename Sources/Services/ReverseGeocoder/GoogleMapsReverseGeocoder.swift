import CoreLocation
import ReactiveSwift

class GoogleMapsReverseGeocoder: ReverseGeocoder {
    func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) ->
        SignalProducer<ReverseGeocoderAddress, ReverseGeocoderError> {
            do {
                let address = try JSONDecoder().decode(ReverseGeocoderAddress.self, from: jsonData)
                return SignalProducer(value: address)
            } catch {
                return SignalProducer(error: ReverseGeocoderError.parsingError)
            }
    }
}
