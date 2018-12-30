import UIKit
import GoogleMaps

// swiftlint:disable line_length
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        setupExternalServices()
        setupRootViewController()

        return true
    }
}

private extension AppDelegate {
    private func setupRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let mapViewController = MapViewController()
        window?.rootViewController = mapViewController
        window?.makeKeyAndVisible()
    }

    private func setupExternalServices() {
        GMSServices.provideAPIKey(ApiKeys.googleMaps.key)
    }
}
