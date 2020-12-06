import Foundation

class PokeListCellViewModel: Hashable {
    @Published private(set) var state: PokeListCellViewModel.State = .loading
    var statePublisher: Published<PokeListCellViewModel.State>.Publisher { $state }
    
    let network: NetworkContextProtocol
    let preview: PokePreview
        
    private var request: Request?
    
    init(network: NetworkContextProtocol, preview: PokePreview) {
        self.network = network
        self.preview = preview
    }
    
    var name: String {
        preview.name
    }
    
    var url: String {
        preview.url
    }
    
    var placeholderName: String {
        "Placeholder"
    }
    
    func cancelRequest() {
        request?.cancel()
    }
    
    func loadImage() {
        guard let identifier = url.components(separatedBy: "/").filter({ !$0.isEmpty }).last else { return }
        request = network.getPokemonImage(with: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(identifier).png", completion: { [weak self] result in
            switch result {
            case let .success(data):
                self?.state = .success(data)
            case let .failure(error):
                self?.state = .failure(error)
            }
        })
        request?.execute()
    }
    
    static func == (lhs: PokeListCellViewModel, rhs: PokeListCellViewModel) -> Bool {
        lhs.preview == rhs.preview
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(preview.name)
    }
}

extension PokeListCellViewModel {
    enum State {
        case loading
        case success(Data)
        case failure(Error)
    }
}
