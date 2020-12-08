import SwiftUI

struct PokeSlotView: View {
    let viewModel: PokeSlotViewModel
    
    var body: some View {
        ZStack {
            Color.chip
            Text(viewModel.title)
                .foregroundColor(Color.white)
                .font(Font.light(size: 16))
                .padding(4)
        }
        .cornerRadius(5)
    }
}
