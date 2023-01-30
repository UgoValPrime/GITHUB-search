import SwiftUI

struct UsersCardView: View {
    var users: UserDataModelResponse
    var body: some View {
      HStack(alignment: .top, spacing: 5) {
          AsyncImage(url: URL(string: users.avatarURL ?? ""), scale: 1)
          { image in image.resizable() } placeholder: { Color.red } .frame(width: 28, height: 28) .clipShape(RoundedRectangle(cornerRadius: 14))
          .padding(.trailing, 5)

        VStack(alignment: .leading, spacing: 5) {
            Text(users.name ?? "")
            .font(.appSBLargeFont)
            .foregroundColor(.pillText)

            Text(users.login ?? "")
            .font(.appMediumFont)

            Text(users.bio ?? "")
            .font(.appSBMediumFont)

          HStack(spacing: 20) {
              bottomView(text: users.location ?? "")
              bottomView(text: users.email ?? "")
          }
        }

        Spacer()
      }
      .padding(10)
      .overlay(
        RoundedRectangle(cornerRadius: 5)
          .stroke(.gray, lineWidth: 0.25)
          .shadow(radius: 10)
      )
    }

  func bottomView(text: String) -> some View {
    Text(text)
      .font(.appSmallFont)
      .foregroundColor(.gray)
  }
}

//struct UsersCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        UsersCardView()
//    }
//}
