import UIKit

extension UINavigationController {
    override func present(viewController: UIViewController) {
        pushViewController(viewController, animated: true)
    }
}
