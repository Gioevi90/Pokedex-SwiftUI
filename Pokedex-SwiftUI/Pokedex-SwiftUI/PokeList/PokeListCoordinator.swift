import Foundation
import SwiftUI

protocol PokeListCoordinatorProtocol {
    func start() -> PokeListView
}

struct PokeListCoordinator: PokeListCoordinatorProtocol {
    let network: NetworkContextProtocol
    
    func start() -> PokeListView {
        let viewModel = PokeListViewModel(network: network, coordinator: self)
        return PokeListView(viewModel: viewModel)
    }
}
