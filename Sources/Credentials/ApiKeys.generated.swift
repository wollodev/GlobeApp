#error("Add GoogleMaps Api-Key to './env-vars.sh' and delete this line")

public enum ApiKeys: String {
    case googleMaps = "generated-during-build"
    public var key: String {
        return self.rawValue
    }
}
