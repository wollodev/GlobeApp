import UIKit
import GoogleMaps

// swiftlint:disable line_length
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        GMSServices.provideAPIKey(ApiKeys.googleMaps.key)

        window = UIWindow(frame: UIScreen.main.bounds)
        let mapViewController = MapViewController()
        window?.rootViewController = mapViewController
        window?.makeKeyAndVisible()
        return true
    }
}
