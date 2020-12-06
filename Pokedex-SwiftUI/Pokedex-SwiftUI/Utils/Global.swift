import Foundation

struct Application {
    static let network = NetworkContext(configuration: NetworkConfiguration(baseUrl: "https://pokeapi.co"))
}
