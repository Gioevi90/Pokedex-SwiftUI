import Foundation

struct NetworkContext: NetworkContextProtocol {
    let configuration: NetworkConfigurationProtocol
    let urlSession: UrlSessionProtocol
    let dispatcher: Dispatcher
    let imagesCache: ImagesCacheProtocol
        
    init(configuration: NetworkConfigurationProtocol,
         urlSession: UrlSessionProtocol = URLSession.main,
         dispatcher: Dispatcher = MainQueueDispatcher(),
         imagesCache: ImagesCacheProtocol = ImagesCache()) {
        self.configuration = configuration
        self.urlSession = urlSession
        self.dispatcher = dispatcher
        self.imagesCache = imagesCache
    }
    
    func getPokemonList(completion: @escaping (Result<PokePreviewList, Error>) -> Void) -> Request? {
        getPokemonList(with: configuration.baseUrl + "/api/v2/pokemon",
                       completion: completion)
    }
    
    func getPokemonList(with urlString: String, completion: @escaping (Result<PokePreviewList, Error>) -> Void) -> Request? {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidUrl))
            return nil
        }
        return get(url,
                   session: urlSession,
                   dispatcher: dispatcher,
                   completion: completion)
    }
    
    func getPokemonDetail(with urlString: String, completion: @escaping (Result<PokeDetail, Error>) -> Void) -> Request? {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidUrl))
            return nil
        }
        return get(url,
                   session: urlSession,
                   dispatcher: dispatcher,
                   completion: completion)
    }
    
    func getPokemonImage(with urlString: String, completion: @escaping (Result<Data, Error>) -> Void) -> Request? {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidUrl))
            return nil
        }
        return get(url,
                   session: urlSession,
                   dispatcher: dispatcher,
                   completion: completion)
    }
}

private extension NetworkContext {
    func get<T: Decodable>(_ url: URL,
                           session: UrlSessionProtocol,
                           dispatcher: Dispatcher,
                           completion: @escaping (Result<T, Error>) -> Void) -> Request {
        let task = session
            .dataTask(url: url,
                      completionHandler: { data, response, error in
                        if let error = error {
                            dispatcher.dispatch { completion(.failure(error)) }
                            return
                        }
                        
                        guard !response.notFound else {
                            dispatcher.dispatch { completion(.failure(NetworkError.notFound)) }
                            return
                        }
                        
                        guard let data = data else {
                            dispatcher.dispatch { completion(.failure(NetworkError.invalidResponse)) }
                            return
                        }
                        
                        do {
                            let list = try JSONDecoder().decode(T.self, from: data)
                            dispatcher.dispatch { completion(.success(list)) }
                        } catch {
                            dispatcher.dispatch { completion(.failure(error)) }
                        }
                      })
        return Request(task: task)
    }
    
    func get(_ url: URL,
             session: UrlSessionProtocol,
             dispatcher: Dispatcher,
             completion: @escaping (Result<Data, Error>) -> Void) -> Request? {
        
        if let image = imagesCache.getImage(with: url) {
            completion(.success(image))
            return nil
        }
        
        let uuid = UUID()
        let task = session
            .dataTask(url: url,
                      completionHandler: { data, _, error in
                        defer {
                            dispatcher.dispatch { self.imagesCache.remove(uuid) } }
                        if let error = error {
                            dispatcher.dispatch { completion(.failure(error)) }
                            return
                        }
                        guard let data = data else {
                            dispatcher.dispatch { completion(.failure(NetworkError.invalidResponse)) }
                            return
                        }
                        dispatcher.dispatch {
                            self.imagesCache.storeImage(with: url, data: data)
                            completion(.success(data))
                        }
                      })
        return Request(task: task, uuid: uuid, imagesCache: imagesCache)
    }
}

extension URLSession {
    static var main: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = URLCache(memoryCapacity: 1024 * 1024 * 5,
                                          diskCapacity: 1024 * 1024 * 200,
                                          diskPath: "PokeDex")
        return URLSession(configuration: configuration)
    }
}

extension Optional where Wrapped == URLResponse {
    var notFound: Bool {
        (self as? HTTPURLResponse)?.statusCode == 404
    }
}
