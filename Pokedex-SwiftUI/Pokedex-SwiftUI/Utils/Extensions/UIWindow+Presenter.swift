import UIKit

extension UIWindow: Presenter {
    func present(viewController: UIViewController) {
        rootViewController = viewController
        makeKeyAndVisible()
    }
}
