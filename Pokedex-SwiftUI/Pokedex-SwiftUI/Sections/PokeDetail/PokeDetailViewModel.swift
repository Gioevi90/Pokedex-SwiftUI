import Foundation

class PokeDetailViewModel: ObservableObject {
    let preview: PokePreview
    let network: NetworkContextProtocol
    
    @Published private var detail: PokeDetail?
    
    var onUpdate: () -> Void = {}
    var onError: (Error) -> Void = { _ in }
    var onLoading: () -> Void = {}
    
    var name: String {
        detail.map({ $0.name }).orEmpty
    }
        
    var baseExperience: String {
        detail.map({ "BASE EXP: \($0.base_experience) pt" }).orEmpty
    }
    
    var height: String {
        detail.map({ "HEIGHT: \($0.height * 10) cm" }).orEmpty
    }
    
    var weight: String {
        detail.map({ "WEIGHT: \($0.weight / 10) kg" }).orEmpty
    }
    
    var imageViewModels: [PokeImageViewModel] {
        [detail?.sprites.front_default,
         detail?.sprites.back_default,
         detail?.sprites.front_female,
         detail?.sprites.back_female,
         detail?.sprites.front_shiny,
         detail?.sprites.back_shiny,
         detail?.sprites.front_shiny_female,
         detail?.sprites.back_shiny_female]
            .compactMap({ $0 })
            .map({ PokeImageViewModel(url: $0, network: network) })
    }
    
    var abilitityViewModel: PokeInfoViewModel {
        let values = detail?.abilities.map({ $0.ability.name.uppercased() }) ?? []
        return PokeInfoViewModel(title: "ABILITIES", values: values)
    }
    
    var statViewModel: PokeInfoViewModel {
        let values = detail?.stats.map({ "\($0.stat.name.uppercased()): \($0.base_stat)" }) ?? []
        return PokeInfoViewModel(title: "STATS", values: values)
    }
    
    var typeViewModel: PokeInfoViewModel {
        let values = detail?.types.map({ $0.type.name.uppercased() }) ?? []
        return PokeInfoViewModel(title: "TYPES", values: values)
    }
        
    init(preview: PokePreview, network: NetworkContextProtocol) {
        self.preview = preview
        self.network = network
    }
    
    func load() {
        onLoading()
        network.getPokemonDetail(with: preview.url,
                                 completion: { [weak self] result in
                                    switch result {
                                    case let .success(detail):
                                        self?.onSuccess(detail)
                                    case let .failure(error):
                                        self?.onFailure(error)
                                    }
                                 })?.execute()
    }
        
    private func onSuccess(_ detail: PokeDetail) {
        self.detail = detail
        onUpdate()
    }
    
    private func onFailure(_ error: Error) {
        onError(error)
    }
}
