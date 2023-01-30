import Foundation


final class UserViewModel: ObservableObject {
    @Published var user: [UserDataModelResponse] = []
    @Published var userRepos: [ReposListDataResponse] = []
    @Published var scantyUser:  [SearchUserDataModelResponse] = []
    @Published var searchText: String = ""
    @Published var userUrl: String = ""
    @Published var repoUrl: String = ""
    
    @Published var error: LocalizedError?
    @Published var subError: LocalizedError?

    var gitResource: GitProtocol?
    var pageNumber : Int?

    init(gitResource: GitProtocol = GitResource()) {
        self.gitResource = gitResource
    }
    
    
    
    
    func getUserRepoDetails(_ url: String) {
        gitResource?.getUserRepoDetails(url: url ) { [weak self] result in
            switch result {
            case .success(let listOf):
                let val = listOf
                self?.userRepos = val
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.subError = error
                }
                print("Error processing json data for repo: \(error.localizedDescription)")
            }
        }
    }
    
    func getUsersDetails(_ url: String) {
        gitResource?.getUserDetails(url: url) { [weak self] result in
            switch result {
            case .success(let listOf):
                
                let val = listOf
                if self?.user.count ?? 0 >= self?.scantyUser.count ?? 0 {
                    self?.user.removeAll()
                    self?.user.append(val)
                }else{
                    self?.user.append(val)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.subError = error
                }
                print("Error processing json data: \(error.localizedDescription)")
            }
        }
    }


    func getUsersListData() {
        gitResource?.getUsersListData(searchQuery: self.searchText, PageNumber: self.pageNumber ?? 1) { [weak self] result in
            switch result {
            case .success(let listOf):
                self?.scantyUser = listOf.items
                for item in listOf.items {
                    self?.getUsersDetails(item.url ?? "google.com")
                    self?.getUserRepoDetails(item.reposURL ?? "google.com")
                }
            
            case .failure(let error):
                
                DispatchQueue.main.async {
                    self?.user = []
                    self?.error = error
                }
                
                print("Error processing json data: \(error.localizedDescription)")
            }
        }
    }
}

