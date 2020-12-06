import Foundation

protocol Dispatcher {
    func dispatch(_ function: @escaping () -> Void)
}
