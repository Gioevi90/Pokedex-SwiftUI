import Foundation

class PokeListViewModel: ObservableObject {
    @Published private(set) var state: PokeListViewModel.State = .loading
    var statePublisher: Published<PokeListViewModel.State>.Publisher { $state }
    private let network: NetworkContextProtocol
    private let coordinator: PokeListCoordinatorProtocol
    private(set) var viewModels: [PokeListCellViewModel] = []
    private var next: String?
        
    init(network: NetworkContextProtocol,
         coordinator: PokeListCoordinatorProtocol) {
        self.network = network
        self.coordinator = coordinator
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
    
    func loadNext(_ indexPath: IndexPath) {
        guard let next = next else { return }
        guard indexPath.row == viewModels.count - 1 else { return }
        
        network.getPokemonList(with: next, completion: { [weak self] result in
            switch result {
            case let .success(list):
                self?.loadSucceeded(list)
            case let .failure(error):
                self?.loadFailed(error)
            }
        })?.execute()
    }
    
    private func loadSucceeded(_ result: PokePreviewList) {
        let paths = Array(viewModels.count..<(viewModels.count + result.results.count))
            .map({ IndexPath(row: $0, section: 0) })
        
        viewModels = viewModels + result
            .results
            .map({ PokeListCellViewModel(network: network,
                                              preview: $0,
                                              onSelect: { [weak self] in self?.state = .select($0) }) })
        next = result.next
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
        case select(PokePreview)
    }
}
