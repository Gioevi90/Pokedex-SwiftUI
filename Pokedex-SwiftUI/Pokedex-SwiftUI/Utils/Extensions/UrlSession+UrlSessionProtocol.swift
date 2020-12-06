import Foundation

extension URLSession: UrlSessionProtocol {
    func dataTask(url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> UrlSessionDataTaskProtocol {
        dataTask(with: url, completionHandler: completionHandler)
    }
}
