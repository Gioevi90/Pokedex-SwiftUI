import Foundation

extension Optional where Wrapped == String {
    var orEmpty: String {
        guard let self = self else { return "" }
        return self
    }
}
