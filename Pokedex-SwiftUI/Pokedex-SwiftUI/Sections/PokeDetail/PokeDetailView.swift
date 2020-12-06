import SwiftUI

struct PokeDetailView: View {
    @ObservedObject var viewModel: PokeDetailViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.name).font(Font.semibold(size: 22))
            Text(viewModel.height).font(Font.light(size: 16))
            Text(viewModel.weight).font(Font.light(size: 16))
            Text(viewModel.baseExperience).font(Font.light(size: 16))
        }
        .onAppear(perform: { viewModel.load() })
    }
}
