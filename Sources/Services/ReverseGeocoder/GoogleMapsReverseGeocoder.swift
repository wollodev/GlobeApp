import CoreLocation
import ReactiveSwift

class GoogleMapsReverseGeocoder: ReverseGeocoder {

    func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) ->
        SignalProducer<ReverseGeocoderAddress, ReverseGeocoderError> {

            let url = URL(string: "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(coordinate.latitude),\(coordinate.longitude)&location_type=ROOFTOP&result_type=street_address&key=\(ApiKeys.googleMaps.key)")!
            print(url)
            let request = URLRequest(url: url)
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)

            return SignalProducer { (observer, _) in
                let task = session.dataTask(with: request) { [weak self] (data, _, error) in
                    if error != nil {
                        observer.send(error: .networkError)
                    }
                    self?.handle(data: data, observer: observer)
                }
                task.resume()
            }
    }

    private func handle(data: Data?, observer: Signal<ReverseGeocoderAddress, ReverseGeocoderError>.Observer) {
        guard let data = data else {
            observer.send(error: .noResult)
            return
        }

        do {
            let address = try JSONDecoder().decode(ReverseGeocoderAddress.self, from: data)
            observer.send(value: address)
            observer.sendCompleted()
        } catch {
            observer.send(error: .parsingError)
        }
    }
}
