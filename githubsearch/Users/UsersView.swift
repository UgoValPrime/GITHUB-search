import SwiftUI

struct UsersView: View {
    @ObservedObject var viewModel = UserViewModel()
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack {
                    Text("Users")
                    Spacer()
                }
                
                SearchView(
                    searchText: $viewModel.searchText,
                    placeholder: "Search for users",
                    searchAction: {viewModel.getUsersListData() }
                )
                listView
            }
            .padding(.leading)
            .padding(.trailing)
            .errorAlert(error: $viewModel.error)
        }
    }
    @ViewBuilder
    var listView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                
                if viewModel.scantyUser?.count == 0 {
                    EmptyState(message: "We’ve searched the ends of the earth and we’ve not found this user, please try again",
                               imageName: "emptySearch")
                } else if viewModel.user.count == 0 {
                    EmptyState(message: "Search Github for users...", imageName: "emptySearch")
                } else if let user = viewModel.user {
                    ForEach(user, id: \.id) { user in
                        NavigationLink(destination: UserDetailView(viewModel: viewModel, user: user)) {
                            UsersCardView(users: user)
                        }
                    }
                }
            }
        }
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
