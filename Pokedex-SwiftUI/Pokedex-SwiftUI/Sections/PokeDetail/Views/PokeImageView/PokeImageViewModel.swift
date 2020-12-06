import Foundation

class PokeImageViewModel {
    let url: String
    let network: NetworkContextProtocol
    
    var onError: (Error) -> Void = { _ in }
    var onSuccess: (Data) -> Void = { _ in }
    
    init(url: String, network: NetworkContextProtocol) {
        self.url = url
        self.network = network
    }
    
    func load() {
        network.getPokemonImage(with: url) { [weak self] result in
            switch result {
            case let .failure(error):
                self?.failure(error)
            case let .success(data):
                self?.success(data: data)
            }
        }?.execute()
    }
    
    private func failure(_ error: Error) {
        onError(error)
    }
    
    private func success(data: Data) {
        onSuccess(data)
    }
}
