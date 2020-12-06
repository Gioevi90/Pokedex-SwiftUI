import SwiftUI
import Combine

struct PokeListView: View {
    @ObservedObject var viewModel: PokeListViewModel
    @State var cellViewModels: [PokeListCellViewModel] = []
    @State var isLoading: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.background
                ScrollView {
                    LazyVGrid(columns: [GridItem(spacing: 8, alignment: .center),
                                        GridItem(spacing: 8, alignment: .center)]) {
                        ForEach(viewModel.viewModels, id: \.self) { model in
                            NavigationLink(destination:  viewModel.showDetail(model)) {
                                PokeListCellView(viewModel: model)
                                    .onAppear(perform: { viewModel.loadNext(model: model) })
                            }
                        }
                    }.padding(.all, 8)
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .hide(if: !isLoading)
                }
            }
            .accentColor(Color.black)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle(Text(viewModel.pageTitle))
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
        }
    }
    
    private func loading() {
        isLoading = true
    }
    
    private func update(_ paths: [IndexPath]) {
        isLoading = false
    }
    
    private func onError(_ error: Error) {
        isLoading = false
    }
}
