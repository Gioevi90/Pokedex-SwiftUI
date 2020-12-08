import SwiftUI

struct PokeImageView: View {
    let viewModel: PokeImageViewModel
    @State private var data: Data = Data()
    
    var body: some View {
        Image
            .initialize(data: data)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .onAppear(perform: viewModel.load)
            .onReceive(viewModel.statePublisher, perform: stateUpdated)
    }
    
    private func stateUpdated(_ state: PokeImageViewModel.State) {
        switch state {
        case .loading:
            onLoading()
        case let .success(data):
            onSuccess(data)
        case let .failure(error):
            onFailure(error)
        }
    }
    
    private func onLoading() {
        
    }
    
    private func onSuccess(_ data: Data) {
        self.data = data
    }
    
    private func onFailure(_ error: Error) {
        
    }
}
