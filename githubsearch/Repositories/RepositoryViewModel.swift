import Foundation


final class RepositoryViewModel: ObservableObject {
  @Published var repositories: [SearchRepositoryDataModelResponse]?
  @Published var searchText: String = ""
  @Published var error: LocalizedError?
  var gitResource: GitProtocol?
  var pageNumber : Int?
@Published var totalCount: Int?

    init(gitResource: GitProtocol = GitResource()) {
        self.gitResource = gitResource
    }


  func getReposListData() {
      
      let queryItems = [URLQueryItem(name: "q", value: searchText), URLQueryItem(name: "page", value: String(pageNumber ?? 1))]
      var urlComps = URLComponents(string: "\(API.baseUrl)\(API.repoPath)")!
      urlComps.queryItems = queryItems
      let result = urlComps.url!
      let url = result.absoluteString
      
      gitResource?.fetch(from: url, resultType: SearchRepositoryDataModel.self, completion: { [weak self]  result in
          switch result {
          case .success(let listOf):
             
              DispatchQueue.main.async {
                  self?.totalCount = listOf.totalCount
                self?.repositories = listOf.items
              }
            
          case .failure(let error):
              DispatchQueue.main.async {
                  self?.repositories = []
                  self?.error = error
              }
              print("Error processing json data for repo: \(error.localizedDescription)")
          }
      })
    }
}
