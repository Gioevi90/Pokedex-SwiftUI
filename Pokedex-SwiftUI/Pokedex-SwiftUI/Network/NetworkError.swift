import Foundation

enum NetworkError: LocalizedError, CustomStringConvertible {
    case invalidUrl
    case invalidResponse
    case notFound
    
    var description: String {
        switch self {
        case .invalidUrl:
            return "An unknown error has occured. Please try again."
        case .invalidResponse:
            return "An unknown error has occured. Please try again."
        case .notFound:
            return "An error has occured: the resource does not exists."
        }
    }
    
    var errorDescription: String? {
        description
    }
}
