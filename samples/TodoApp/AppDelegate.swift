import Dispatcher_iOS
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions
		launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)

		Dispatcher.default.initTodoListStore()
		Dispatcher.default.register(middleware: LoggerMiddleware())
		Dispatcher.default.register(middleware: RecorderMiddleware(enableKeyboardControls: true))

		let vc = ViewController()
		window?.rootViewController = UINavigationController(rootViewController: vc)
		window?.makeKeyAndVisible()
		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {}

	func applicationDidEnterBackground(_ application: UIApplication) {}

	func applicationWillEnterForeground(_ application: UIApplication) {}

	func applicationDidBecomeActive(_ application: UIApplication) {}

	func applicationWillTerminate(_ application: UIApplication) {}
}
