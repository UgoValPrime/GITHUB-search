import SwiftUI

struct StackView: View {
  var stack: String

    var body: some View {
      HStack(spacing: 5) {
        Color.appGreen
          .frame(width: 12, height: 12)
          .cornerRadius(10)

        Text(stack)
          .font(.appSmallFont)
      }
    }
}

struct StackView_Previews: PreviewProvider {
    static var previews: some View {
      StackView(stack: "Vue")
    }
}
