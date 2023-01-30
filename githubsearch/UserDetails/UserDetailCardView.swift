import SwiftUI

struct UserDetailCardView: View {
    var userRepos: ReposListDataResponse
  var body: some View {
    VStack(alignment: .leading, spacing: 5) {
      HStack(spacing: 10) {
        titleView
        repoAccessView

        Spacer()

          RatingView(rating: String(userRepos.stargazersCount ?? 0))
          StackView(stack: userRepos.language ?? "")
      }

        Text(userRepos.description ?? "These are random words that will be replaced in due time. Config files for my github profile")
        .font(.appMediumFont)
        .multilineTextAlignment(.leading)

      HStack(spacing: 15) {
        bottomView(text: "Forked from discordify")
          bottomView(text: "updated " + (userRepos.updatedAt ?? "updated 2 days ago"))
      }
    }
    .padding()
    .overlay(
      RoundedRectangle(cornerRadius: 5)
        .stroke(.gray, lineWidth: 0.25)
        .shadow(radius: 10)
    )
  }

  var titleView: some View {
    HStack(spacing: 0) {
        Text(userRepos.owner?.login ?? "")
        .font(.appSBMediumFont)
        .foregroundColor(.appPurple)

        Text("/" + (userRepos.name ?? ""))
        .font(.appSBMediumFont)
        .foregroundColor(.black)
    }
  }

  var repoAccessView: some View {
      Text(userRepos.welcomePrivate == true ? "Private" : "Public")
      .font(.appSmallFont)
      .padding(.vertical, 5)
      .padding(.horizontal, 5)
      .overlay(
        RoundedRectangle(cornerRadius: 5)
          .stroke(.gray, lineWidth: 0.25)
          .shadow(radius: 8)
      )
  }

  func bottomView(text: String) -> some View {
    Text(text)
      .font(.appMediumFont)
      .foregroundColor(.textGrey)
  }
}

//struct UserDetailCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserDetailCardView()
//    }
//}
