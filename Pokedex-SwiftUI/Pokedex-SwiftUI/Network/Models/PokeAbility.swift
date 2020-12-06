import Foundation

struct PokeAbility: Equatable, Codable {
    let is_hidden: Bool
    let slot: Int
    let ability: PokeResource
}
