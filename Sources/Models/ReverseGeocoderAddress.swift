struct ReverseGeocoderAddress: Decodable {

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

    let street: String
    let postalCode: String
    let city: String
    let country: String

    public init(from decoder: Decoder) throws {
        let superContainer = try decoder.container(keyedBy: RootKeys.self)
        var results = try superContainer.nestedUnkeyedContainer(forKey: .results)

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

let jsonData = """
{
"plus_code" : {
"compound_code" : "3HRP+38 Grevenbroich, Germany",
"global_code" : "9F383HRP+38"
},
"results" : [
{
"address_components" : [
{
"long_name" : "6",
"short_name" : "6",
"types" : [ "street_number" ]
},
{
"long_name" : "Am Stadtpark",
"short_name" : "Am Stadtpark",
"types" : [ "route" ]
},
{
"long_name" : "Grevenbroich",
"short_name" : "Grevenbroich",
"types" : [ "locality", "political" ]
},
{
"long_name" : "Rhein-Kreis Neuss",
"short_name" : "Rhein-Kreis Neuss",
"types" : [ "administrative_area_level_3", "political" ]
},
{
"long_name" : "Düsseldorf",
"short_name" : "Düsseldorf",
"types" : [ "administrative_area_level_2", "political" ]
},
{
"long_name" : "Nordrhein-Westfalen",
"short_name" : "NRW",
"types" : [ "administrative_area_level_1", "political" ]
},
{
"long_name" : "Germany",
"short_name" : "DE",
"types" : [ "country", "political" ]
},
{
"long_name" : "41515",
"short_name" : "41515",
"types" : [ "postal_code" ]
}
],
"formatted_address" : "Am Stadtpark 6, 41515 Grevenbroich, Germany",
"geometry" : {
"location" : {
"lat" : 51.09043,
"lng" : 6.586159899999999
},
"location_type" : "ROOFTOP",
"viewport" : {
"northeast" : {
"lat" : 51.09177898029149,
"lng" : 6.587508880291502
},
"southwest" : {
"lat" : 51.0890810197085,
"lng" : 6.584810919708497
}
}
},
"place_id" : "ChIJg-vD1xdMv0cRHpAn5aHSt7I",
"plus_code" : {
"compound_code" : "3HRP+5F Grevenbroich, Germany",
"global_code" : "9F383HRP+5F"
},
"types" : [ "street_address" ]
}
],
"status" : "OK"
}
""".data(using: .utf8)!
