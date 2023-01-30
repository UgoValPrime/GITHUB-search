import SwiftUI

struct RepositoriesView: View {
  @ObservedObject var viewModel = RepositoryViewModel()

    var body: some View {
      VStack(spacing: 20) {
        HStack {
          Text("Repositories")
          Spacer()
        }

        SearchView(
          searchText: $viewModel.searchText,
          placeholder: "Search for repositories",
          searchAction: { viewModel.getReposListData() }
        )

        listView

        Spacer()
      }
      .padding()
      .errorAlert(error: $viewModel.error)
      
    }

  @ViewBuilder
  var listView: some View {
    ScrollView(.vertical, showsIndicators: false) {
      LazyVStack {
        if let repositories = viewModel.repositories {
          ForEach(repositories, id: \.id) { repository in
            RepositoriesCardView(repository: repository)
          }
        } else if viewModel.repositories?.count == 0 {
            EmptyState(message: "We’ve searched the ends of the earth, repository not found, please try again", imageName: "emptySearch")  // any idea why this isnt working??
           
        }else {
            EmptyState(message: "Search Github for repositories, issues and pull requests!", imageName: "emptySearch")
        }
      }
    }
  }
}

struct RepositoryView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoriesView()
    }
}
