import SwiftUI

struct PokeListCellView: View {
    let viewModel: PokeListCellViewModel
    @State private var imageData: Data = Data()
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Image.initialize(data: imageData)
                Text(viewModel.name).font(Font.semibold(size: 17))
            }
        }
        .cornerRadius(CGFloat.cornerRadius)
        .onReceive(viewModel.statePublisher, perform: stateUpdate(_:))
        .onAppear(perform: { viewModel.loadImage() })
    }
    
    private func stateUpdate(_ state: PokeListCellViewModel.State) {
        switch state {
        case let .success(data):
            onSuccess(data)
        case let .failure(error):
            onFailure(error)
        case .loading:
            onLoading()
        }
    }
    
    private func onLoading() {
        
    }
    
    private func onSuccess(_ data: Data) {
        imageData = data
    }
    
    private func onFailure(_ error: Error) {
        
    }
}
