import Foundation

protocol UrlSessionProtocol {
    func dataTask(url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> UrlSessionDataTaskProtocol
}
