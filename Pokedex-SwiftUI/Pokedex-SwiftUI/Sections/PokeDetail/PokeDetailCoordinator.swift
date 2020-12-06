import Foundation

struct PokeDetailCoordinator {
    let preview: PokePreview
    let network: NetworkContextProtocol
    
    func start() -> PokeDetailView {
        let viewModel = PokeDetailViewModel(preview: preview, network: network)
        return PokeDetailView(viewModel: viewModel)
    }
}
