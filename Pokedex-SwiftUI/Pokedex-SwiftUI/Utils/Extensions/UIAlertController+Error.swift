import UIKit

extension UIAlertController {
    static func show(error: Error,
                     in controller: UIViewController,
                     retry: @escaping () -> Void,
                     cancel: @escaping () -> Void) {
        let alertController = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Retry", style: .default, handler: { _ in retry() })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in cancel() })
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        controller.present(alertController, animated: true, completion: nil)
    }
}
