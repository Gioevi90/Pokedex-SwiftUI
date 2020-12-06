import Foundation

protocol NetworkContextProtocol {
    var configuration: NetworkConfigurationProtocol { get }
    
    func getPokemonList(completion: @escaping (Result<PokePreviewList, Error>) -> Void) -> Request?
    func getPokemonList(with urlString: String, completion:  @escaping (Result<PokePreviewList, Error>) -> Void) -> Request?
    func getPokemonImage(with urlString: String, completion:  @escaping (Result<Data, Error>) -> Void) -> Request?
    func getPokemonDetail(with urlString: String, completion: @escaping (Result<PokeDetail, Error>) -> Void) -> Request?
}
