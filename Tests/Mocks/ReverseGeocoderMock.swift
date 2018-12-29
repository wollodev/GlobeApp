@testable import Globe
import CoreLocation
import ReactiveSwift

class ReverseGeocoderMock: ReverseGeocoder {
    var returnAddress: ReverseGeocoderAddress?
    var returnError: ReverseGeocoderError?
    var callback: (() -> Void)?

    func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) -> SignalProducer<ReverseGeocoderAddress, ReverseGeocoderError> {
        let signalProducer: SignalProducer<ReverseGeocoderAddress, ReverseGeocoderError>
        if let returnAddress = returnAddress {
            signalProducer = SignalProducer(value: returnAddress)
        } else {
            signalProducer = SignalProducer(error: returnError!)
        }

        callback?()

        return signalProducer
    }
}
