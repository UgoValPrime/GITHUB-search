import SwiftUI

struct SearchView: View {
  @Binding var searchText: String
  var placeholder: String = ""
  var searchAction: () -> ()

  init(
    searchText: Binding<String>,
    placeholder: String,
    searchAction: @escaping () -> Void
  ) {
    self._searchText = searchText
    self.placeholder = placeholder
    self.searchAction = searchAction
  }

    var body: some View {
      HStack {
        Image(systemName: "magnifyingglass")
          .resizable()
          .scaledToFit()
          .frame(width: 20, height: 20)
          .padding(10)

        TextField(placeholder, text: $searchText)

        Button(action: { searchAction() }) {
          Text("Search")
            .padding(.vertical, 10)
            .padding(.horizontal, 30)
            .foregroundColor(.white)
            .background(Color.black)
            .cornerRadius(5)
            .padding(8)
        }
      }
      .overlay(
        RoundedRectangle(cornerRadius: 5)
          .stroke(.black, lineWidth: 0.5)
      )
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
      SearchView(searchText: .constant(""), placeholder: "Search for users...", searchAction: {})
    }
}
