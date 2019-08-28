import CoreLocation
import ReactiveSwift

class GoogleMapsReverseGeocoder: ReverseGeocoder {
    func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) ->
        SignalProducer<ReverseGeocoderAddress, ReverseGeocoderError> {
            let baseUrl = "https://maps.googleapis.com/maps/api/geocode/json"
            var urlComponents = URLComponents(string: baseUrl)
            let coordinateQuery = URLQueryItem(name: "latlng", value: "\(coordinate.latitude),\(coordinate.longitude)")
            let locationTypeQuery = URLQueryItem(name: "location_type", value: "ROOFTOP")
            let resultTypeQuery = URLQueryItem(name: "result_type", value: "street_address")
            let keyQuery = URLQueryItem(name: "key", value: ApiKeys.googleMaps.key)
            urlComponents?.queryItems = [coordinateQuery, locationTypeQuery, resultTypeQuery, keyQuery]

            guard let url = urlComponents?.url else {
                fatalError("google maps reverse geocoder url is wrong")
            }

            let session = URLSession(configuration: .default)

            return SignalProducer { observer, _ in
                let task = session.dataTask(with: url) { [weak self] data, _, error in
                    if error != nil {
                        observer.send(error: .networkError)
                    }
                    self?.processResult(data: data, observer: observer)
                }
                task.resume()
            }
    }

    private func processResult(data: Data?, observer: Signal<ReverseGeocoderAddress, ReverseGeocoderError>.Observer) {
        guard let data = data else {
            observer.send(error: .noResult)
            return
        }

        do {
            let address = try JSONDecoder().decode(ReverseGeocoderAddress.self, from: data)
            observer.send(value: address)
            observer.sendCompleted()
        } catch ReverseGeocoderError.noResult {
            observer.send(error: .noResult)
        } catch {
            observer.send(error: .parsingError)
        }
    }
}
