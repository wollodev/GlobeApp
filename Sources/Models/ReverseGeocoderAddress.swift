struct ReverseGeocoderAddress {
    let street: String
    let postalCode: String
    let city: String
    let country: String
}

extension ReverseGeocoderAddress: Decodable {
    enum RootKeys: String, CodingKey {
        case results
    }

    enum ResultKeys: String, CodingKey {
        case addressComponents = "address_components"
    }

    enum AddressComponentKeys: String, CodingKey {
        case name = "long_name"
        case types
    }

    enum AddressComponentType: String, Decodable {
        case street = "route"
        case streetNumber = "street_number"
        case city = "locality"
        case postalCode = "postal_code"
        case country = "country"
        case unknown

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let value = try container.decode(String.self)

            if let addressComponentType = AddressComponentType(rawValue: value) {
                self = addressComponentType
            } else {
                self = .unknown
            }
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        var results = try container.nestedUnkeyedContainer(forKey: .results)

        guard results.count != 0 else {
            throw ReverseGeocoderError.noResult
        }

        let addressComponents = try results.nestedContainer(keyedBy: ResultKeys.self)

        var componentContainer = try addressComponents.nestedUnkeyedContainer(forKey: .addressComponents)

        var components = [AddressComponentType: String]()

        while !componentContainer.isAtEnd {
            let object = try componentContainer.nestedContainer(keyedBy: AddressComponentKeys.self)
            let types = try object.decode([AddressComponentType].self, forKey: .types)
            let name = try object.decode(String.self, forKey: .name)

            types
                .filter { $0 != .unknown}
                .forEach { components[$0] = name }
        }

        guard let street = components[.street],
            let streetNumber = components[.streetNumber],
            let city = components[.city],
            let postalCode = components[.postalCode],
            let country = components[.country] else {
                throw ReverseGeocoderError.parsingError
        }

        self.street = "\(street) \(streetNumber)"
        self.city = city
        self.postalCode = postalCode
        self.country = country
    }
}
