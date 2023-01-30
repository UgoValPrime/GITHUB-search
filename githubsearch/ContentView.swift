import SwiftUI

struct ContentView: View {
    
    @State private var tabSelection = 1
    
    var body: some View {
        
        TabView(selection: $tabSelection) {
            HomeView(tabSelection: $tabSelection)
          .tabItem {
            Label("Home", image: "home")
          }.tag(1)

        RepositoriesView()
          .tabItem {
            Label("Repository", image: "search")
          }.tag(2)

        UsersView()
          .tabItem {
            Label("Users", image: "profile")
          }.tag(3)
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
