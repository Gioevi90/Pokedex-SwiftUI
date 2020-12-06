import Foundation

struct MainQueueDispatcher: Dispatcher {
    func dispatch(_ function: @escaping () -> Void) {
        DispatchQueue.main.async {
            function()
        }
    }
}
