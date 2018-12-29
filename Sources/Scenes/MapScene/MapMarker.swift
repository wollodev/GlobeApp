import GoogleMaps

class MapMarker: GMSMarker {
    init(at coordinate: CLLocationCoordinate2D) {
        super.init()

        position = coordinate
        icon = UIImage(assetIdentifier: .mapMarker)
        groundAnchor = CGPoint(x: 0.5, y: 1)
        appearAnimation = .pop

    }
}
