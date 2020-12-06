import Foundation
import SwiftUI

protocol PokeListCoordinatorProtocol {
    func start() -> PokeListView
    func showDetail(preview: PokePreview,
                    network: NetworkContextProtocol) -> PokeDetailView
}

struct PokeListCoordinator: PokeListCoordinatorProtocol {
    let network: NetworkContextProtocol
    
    func start() -> PokeListView {
        let viewModel = PokeListViewModel(network: network, coordinator: self)
        return PokeListView(viewModel: viewModel)
    }
    
    func showDetail(preview: PokePreview,
                    network: NetworkContextProtocol) -> PokeDetailView {
        let coordinator = PokeDetailCoordinator(preview: preview,
                                                network: network)
        return coordinator.start()
    }
}
