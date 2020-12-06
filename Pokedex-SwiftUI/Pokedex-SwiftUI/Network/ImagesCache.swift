import Foundation

class ImagesCache: ImagesCacheProtocol {
    private(set) var loadedImages: [URL: Data]
    private(set) var runningRequests: [UUID: UrlSessionDataTaskProtocol]
    
    init(loadedImages: [URL: Data] = [:],
         runningRequests: [UUID: UrlSessionDataTaskProtocol] = [:]) {
        self.loadedImages = loadedImages
        self.runningRequests = runningRequests
    }
    
    func getImage(with url: URL) -> Data? {
        loadedImages[url]
    }
    
    func storeImage(with url: URL, data: Data) {
        loadedImages[url] = data
    }
    
    func store(_ request: Request) {
        runningRequests[request.uuid] = request.task
    }
    
    func remove(_ request: Request) {
        remove(request.uuid)
    }
    
    func remove(_ uuid: UUID) {
        runningRequests.removeValue(forKey: uuid)
    }
}
