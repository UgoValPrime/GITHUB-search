import Foundation


final class UserViewModel: ObservableObject {
    @Published var user: [UserDataModelResponse] = []
    @Published var userRepos: [ReposListDataResponse] = []
    @Published var scantyUser:  [SearchUserDataModelResponse]?
    @Published var tempUser: [UserDataModelResponse] = []
    @Published var searchText: String = ""
    @Published var totalCount: Int?
    var pageNumber : Int = 1
    var errCount: Int = 0
    
    @Published var error: LocalizedError?
    @Published var subError: LocalizedError?

    var gitResource: GitProtocol?

    init(gitResource: GitProtocol = GitResource()) {
        self.gitResource = gitResource
    }
    
    
    func getUserRepoDetails(_ url: String) {
        
        gitResource?.fetch(from: url, resultType: [ReposListDataResponse].self, completion: { [weak self]  result in
            switch result {
            case .success(let listOf):
               
                DispatchQueue.main.async {
                    let val = listOf
                    self?.userRepos = val
                }
              
            case .failure(let error):
                DispatchQueue.main.async {
                    if self?.errCount ?? 0 < 2 {
                        self?.user = []
                        self?.error = error
                    }
                    self?.errCount += 1
                }
                print("Error processing json data for repo: \(error.localizedDescription)")
            }
        })
    }
    
    func getUsersDetails(_ url: String) {
        print("the api to hit", url)
        
        gitResource?.fetch(from: url, resultType: UserDataModelResponse.self, completion: { [weak self]  result in
            switch result {
            case .success(let listOf):
               
                DispatchQueue.main.async {
                    let val = listOf
                    if self?.tempUser.count ?? 0 >= self?.scantyUser?.count ?? 0 {
                        self?.tempUser.removeAll()
                        self?.tempUser.append(val)
                        self?.user = self?.tempUser ?? []
                    }else{
                        self?.tempUser.append(val)
                        self?.user = self?.tempUser ?? []
                    }
                }
              
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.subError = error
                }
                print("Error processing json data for user: \(error.localizedDescription)")
            }
        })
    }


    func getUsersListData() {
        let queryItems = [URLQueryItem(name: "q", value: searchText), URLQueryItem(name: "page", value: String(pageNumber ))]
        var urlComps = URLComponents(string: "\(API.baseUrl)\(API.userPath)")!
        urlComps.queryItems = queryItems
        let result = urlComps.url!
        let url = result.absoluteString
        
        gitResource?.fetch(from: url, resultType: SearchUserDataModel.self, completion: { [weak self]  result in
            switch result {
            case .success(let listOf):
               
                DispatchQueue.main.async {
                    self?.errCount = 0
                    self?.totalCount = listOf.totalCount
                    self?.scantyUser = listOf.items
                    for item in self!.scantyUser! {
                        self?.getUsersDetails(item.url ?? "google.com")
                    }
                }
              
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.user = []
                    self?.error = error
                }
                print("Error processing json data for details: \(error.localizedDescription)")
            }
        })
        }
    }


