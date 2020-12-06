import UIKit

extension UIViewController: Presenter {
    @objc func present(viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
}
