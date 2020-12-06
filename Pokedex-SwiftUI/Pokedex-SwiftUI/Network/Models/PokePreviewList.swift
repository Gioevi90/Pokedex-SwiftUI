import Foundation

struct PokePreviewList: Equatable, Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokePreview]
}
