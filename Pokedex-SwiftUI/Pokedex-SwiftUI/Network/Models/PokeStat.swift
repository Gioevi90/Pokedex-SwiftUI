import Foundation

struct PokeStat: Equatable, Codable {
    let effort: Int
    let base_stat: Int
    let stat: PokeResource
}
