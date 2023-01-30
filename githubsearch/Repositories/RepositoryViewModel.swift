import Foundation


final class RepositoryViewModel: ObservableObject {
  @Published var repositories: [SearchRepositoryDataModelResponse]?
  @Published var searchText: String = ""
  @Published var error: LocalizedError?
  var gitResource: GitProtocol?
  var pageNumber : Int?

    init(gitResource: GitProtocol = GitResource()) {
        self.gitResource = gitResource
    }


  func getReposListData() {
    gitResource?.getReposListData(searchQuery: self.searchText, PageNumber: self.pageNumber ?? 1) { [weak self] result in
            switch result {
            case .success(let listOf):
                print("<><>\(listOf)")
              self?.repositories = listOf.items
            case .failure(let error):
              DispatchQueue.main.async {
                  self?.error = error
                  self?.repositories = []
              }
                print("Error processing json data: \(error.localizedDescription)")
            }
        }
    }
}
