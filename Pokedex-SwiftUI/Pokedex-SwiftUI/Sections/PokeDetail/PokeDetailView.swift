import SwiftUI

struct PokeDetailView: View {
    @ObservedObject var viewModel: PokeDetailViewModel
    @State private var currentPage = 0
    
    var body: some View {
        GeometryReader { reader in
            ScrollView {
                VStack(spacing: 8) {
                    PagerView(pageCount: viewModel.imageViewModels.count,
                              currentIndex: $currentPage) {
                        ForEach(viewModel.imageViewModels, id: \.url.self) {
                            PokeImageView(viewModel: $0)
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(5)
                    .frame(height: reader.size.width)
                    
                    VStack(spacing: 8) {
                        Text(viewModel.name).font(Font.semibold(size: 22))
                        Text(viewModel.height).font(Font.light(size: 16))
                        Text(viewModel.weight).font(Font.light(size: 16))
                        Text(viewModel.baseExperience).font(Font.light(size: 16))
                        Color.separator.frame(height: 1).padding(.horizontal, 8)
                        PokeInfoView(viewModel: viewModel.typeViewModel)
                        Color.separator.frame(height: 1).padding(.horizontal, 8)
                        PokeInfoView(viewModel: viewModel.abilitityViewModel)
                        Color.separator.frame(height: 1).padding(.horizontal, 8)
                        PokeInfoView(viewModel: viewModel.statViewModel)
                    }
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(5)
                }
                .padding(8)
            }
        }
        .background(Color.background)
        .onAppear(perform: { viewModel.load() })
    }
}

struct PagerView<Content: View>: View {
    let pageCount: Int
    @Binding var currentIndex: Int
    let content: Content
    @GestureState private var translation: CGFloat = 0

    init(pageCount: Int, currentIndex: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                self.content.frame(width: geometry.size.width)
            }
            .frame(width: geometry.size.width, alignment: .leading)
            .offset(x: -CGFloat(self.currentIndex) * geometry.size.width)
            .offset(x: self.translation)
            .animation(.interactiveSpring())
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.width
                }.onEnded { value in
                    let offset = value.translation.width / geometry.size.width
                    let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
                    self.currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1)
                }
            )
        }
    }
}
