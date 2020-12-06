import Foundation

protocol ImagesCacheProtocol {
    func getImage(with url: URL) -> Data?
    func storeImage(with url: URL, data: Data)
    func store(_ request: Request)
    func remove(_ request: Request)
    func remove(_ uuid: UUID)
}
