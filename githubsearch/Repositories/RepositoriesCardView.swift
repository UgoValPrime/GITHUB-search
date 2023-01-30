import SwiftUI

struct RepositoriesCardView: View {
  var repository: SearchRepositoryDataModelResponse

    var body: some View {
      VStack(alignment: .leading, spacing: 15) {
        HStack(spacing: 10) {
          titleView

          Spacer()

          RatingView(rating: String(repository.watchers ?? 0 ))
          StackView(stack: repository.language ?? "")
        }

        Text(repository.description ?? "")
          .font(.appMediumFont)
          .multilineTextAlignment(.leading)

          
          ScrollView(.horizontal, showsIndicators: false) {
              HStack {
                  if let topics = repository.topics{
                      ForEach(topics, id: \.self) { topic in
                          tagView(tag: topic)
                      }
                  }
              }
          }
      }
      .padding(10)
      .overlay(
        RoundedRectangle(cornerRadius: 5)
          .stroke(.gray, lineWidth: 0.25)
          .shadow(radius: 10)
      )
    }

  var titleView: some View {
    HStack(spacing: 0) {
        AsyncImage(url: URL(string: repository.owner?.avatarURL ?? ""), scale: 1)
        { image in image.resizable() } placeholder: { Color.red } .frame(width: 28, height: 28) .clipShape(RoundedRectangle(cornerRadius: 14))
        .padding(.trailing, 5)

      Text(repository.owner?.login ?? "")
        .font(.appSBMediumFont)
        .foregroundColor(.appPurple)

        Text("/" + (repository.name ?? ""))
        .font(.appSBMediumFont)
        .foregroundColor(.black)
    }
  }

  func tagView(tag: String) -> some View {
    Text(tag)
      .font(.appSmallFont)
      .padding(.vertical, 5)
      .padding(.horizontal, 10)
      .foregroundColor(.pillText)
      .background(Color.pillBlue)
      .cornerRadius(5)
  }
}

//struct RepositoriesCardView_Previews: PreviewProvider {
//    static var previews: some View {
//      RepositoriesCardView(repository: SearchRepositoryDataModelResponse)
//    }
//}
