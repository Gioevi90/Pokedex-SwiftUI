import SwiftUI
import Combine

struct PokeListView: View {
    @ObservedObject var viewModel: PokeListViewModel
    @State var cellViewModels: [PokeListCellViewModel] = []
    
    var body: some View {
        ZStack {
            Color.background
            ScrollView {
                LazyVGrid(columns: [GridItem(spacing: 8, alignment: .center),
                                    GridItem(spacing: 8, alignment: .center)]) {
                    ForEach(viewModel.viewModels, id: \.self) { model in
                        PokeListCellView(viewModel: model)
                    }
                }.padding(.horizontal, 8)
            }
        }
        .onReceive(viewModel.statePublisher, perform: stateUpdate(_:))
        .onAppear(perform: { viewModel.load() })
    }
    
    private func stateUpdate(_ newState: PokeListViewModel.State) {
        switch newState {
        case .loading:
            loading()
        case let .update(paths):
            update(paths)
        case let .error(error):
            onError(error)
        case let .select(preview):
            onSelect(preview: preview)
        }
    }
    
    private func loading() {
        
    }
    
    private func update(_ paths: [IndexPath]) {
        
    }
    
    private func onError(_ error: Error) {
        
    }
    
    private func onSelect(preview: PokePreview) {
        
    }
}
