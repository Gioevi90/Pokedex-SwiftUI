import Foundation

class PokeImageViewModel {
    let url: String
    let network: NetworkContextProtocol
    
    @Published private(set) var state: PokeImageViewModel.State = .loading
    var statePublisher: Published<PokeImageViewModel.State>.Publisher { $state }
        
    init(url: String, network: NetworkContextProtocol) {
        self.url = url
        self.network = network
    }
    
    func load() {
        network.getPokemonImage(with: url) { [weak self] result in
            switch result {
            case let .failure(error):
                self?.state = .failure(error)
            case let .success(data):
                self?.state = .success(data)
            }
        }?.execute()
    }
}

extension PokeImageViewModel {
    enum State {
        case success(Data)
        case failure(Error)
        case loading
    }
}
