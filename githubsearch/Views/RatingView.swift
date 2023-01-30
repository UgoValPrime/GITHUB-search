import SwiftUI

struct RatingView: View {
  var rating: String

    var body: some View {
      HStack(spacing: 2) {
        Image("star")
          .resizable()
          .frame(width: 12, height: 12)

        Text(rating)
          .font(.appSmallFont)
      }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
      RatingView(rating: "10")
    }
}
