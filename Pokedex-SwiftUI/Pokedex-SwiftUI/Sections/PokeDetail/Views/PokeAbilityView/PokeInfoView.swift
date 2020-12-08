import SwiftUI

struct PokeInfoView: View {
    let viewModel: PokeInfoViewModel
    
    var body: some View {
        HStack() {
            Text(viewModel.title)
                .font(Font.light(size: 16))
                .frame(minWidth: 0, maxWidth: .infinity)
            VStack(alignment: .leading) {
                ForEach(viewModel.values, id: \.self) {
                    PokeSlotView(viewModel: PokeSlotViewModel(title: $0))
                }
            }.frame(minWidth: 0, maxWidth: .infinity)
        }
    }
}
