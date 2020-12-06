import Foundation

struct Request: Cancellable {
    let task: UrlSessionDataTaskProtocol
    let uuid: UUID
    let imagesCache: ImagesCacheProtocol?
    
    init(task: UrlSessionDataTaskProtocol,
         uuid: UUID = UUID(),
         imagesCache: ImagesCacheProtocol? = nil) {
        self.task = task
        self.uuid = uuid
        self.imagesCache = imagesCache
    }
    
    func cancel() {
        task.cancel()
        imagesCache?.remove(self)
    }
    
    func execute() {
        task.resume()
        imagesCache?.store(self)
    }
}
