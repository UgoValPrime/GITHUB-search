import SwiftUI

struct HomeView: View {
@Binding var tabSelection: Int
  var body: some View {
    VStack(spacing: 50) {
      HStack {
        Text("Home")
          .font(.appHeaderFont)
        Spacer()
      }

      HStack {
          Button(action: {tabSelection = 3}) {
              homeCardView(name: "Users", image: Image("profile"), backgroundColor: .pillBlue)
          }
     
          Button(action: {tabSelection = 2}) {
              homeCardView(name: "Repositories", image: Image("repo"), backgroundColor: .cardPurple)
          }

        
      }

      Spacer()
    }
    .padding()
  }

  func homeCardView(name: String, image: Image, backgroundColor: Color) -> some View {
    HStack {
      VStack(alignment: .leading, spacing: 50) {
        image
          .resizable()
          .scaledToFit()
          .frame(width: 30, height: 30)
          .padding(5)
          .background(Color.white)

        Text(name)
          .font(.appHeaderFont)
      }
      .padding()

      Spacer()
    }
    .frame(maxWidth: .infinity)
    .background(backgroundColor)
    .cornerRadius(5)
  }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
