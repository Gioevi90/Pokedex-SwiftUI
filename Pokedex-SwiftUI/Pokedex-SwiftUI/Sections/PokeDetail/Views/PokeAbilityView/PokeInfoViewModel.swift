import Foundation

struct PokeInfoViewModel {
    let title: String
    let values: [String]
    
    var pokeInfoRowViewModels: [PokeSlotViewModel] {
        values.map(PokeSlotViewModel.init)
    }
}
