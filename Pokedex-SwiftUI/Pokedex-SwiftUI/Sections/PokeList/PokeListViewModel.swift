import Foundation

class PokeListViewModel: ObservableObject {
    @Published private(set) var state: PokeListViewModel.State = .loading
    var statePublisher: Published<PokeListViewModel.State>.Publisher { $state }
    let network: NetworkContextProtocol
    let coordinator: PokeListCoordinatorProtocol
    private(set) var viewModels: [PokeListCellViewModel] = []
    private var next: String?
    
    var canLoadNext: Bool = false
        
    init(network: NetworkContextProtocol,
         coordinator: PokeListCoordinatorProtocol) {
        self.network = network
        self.coordinator = coordinator
    }
    
    var pageTitle: String {
        "Pokedex"
    }
    
    func load() {
        network.getPokemonList(completion: { [weak self] result in
            switch result {
            case let .success(list):
                self?.loadSucceeded(list)
            case let .failure(error):
                self?.loadFailed(error)
            }
        })?.execute()
    }
    
    func loadNext(model: PokeListCellViewModel) {
        guard model == viewModels.last else { return } 
        guard let next = next else { return }
        
        network.getPokemonList(with: next, completion: { [weak self] result in
            switch result {
            case let .success(list):
                self?.loadSucceeded(list)
            case let .failure(error):
                self?.loadFailed(error)
            }
        })?.execute()
    }
    
    func showDetail(_ model: PokeListCellViewModel) -> PokeDetailView {
        coordinator.showDetail(preview: model.preview, network: network)
    }
    
    private func loadSucceeded(_ result: PokePreviewList) {
        let paths = Array(viewModels.count..<(viewModels.count + result.results.count))
            .map({ IndexPath(row: $0, section: 0) })
        
        viewModels = viewModels + result
            .results
            .map({ PokeListCellViewModel(network: network, preview: $0) })
        next = result.next
        canLoadNext = next != nil
        state = .update(paths)
    }
    
    private func loadFailed(_ error: Error) {
        state = .error(error)
    }
}

extension PokeListViewModel {
    enum State {
        case loading
        case update([IndexPath])
        case error(Error)
    }
}
