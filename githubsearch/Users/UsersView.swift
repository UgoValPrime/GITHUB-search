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
                
                Spacer()
            }
            .padding()
            .errorAlert(error: $viewModel.error)
        }
    }
    @ViewBuilder
    var listView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                if let user = viewModel.user {
                    ForEach(user, id: \.id) { user in
                        NavigationLink(destination: UserDetailView(viewModel: viewModel, user: user)) {
                            UsersCardView(users: user)
                        }
                    }
                } else if viewModel.user.count < 1{
                    EmptyState(message: "We’ve searched the ends of the earth and we’ve not found this user, please try again", imageName: "emptySearch")  // any idea why this isnt working??
                }else {
                    EmptyState(message: "Search Github for users...", imageName: "emptySearch")
                }
            }
        }
    }
    var emptyState: some View {
        VStack(spacing: 30) {
            Spacer()
            Image("emptySearch")
            
            Text("Search Github for users...")
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
