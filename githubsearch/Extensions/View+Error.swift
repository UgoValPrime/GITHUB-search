import SwiftUI


struct LocalizedAlertError: LocalizedError {
  let underlyingError: LocalizedError
  var errorDescription: String? {
    
      if (underlyingError.localizedDescription == "The operation couldn’t be completed. (githubsearch.UserError error 0.)") {
          
          return NSLocalizedString("No internet", comment: "No internet")
      }else if (underlyingError.localizedDescription == "The operation couldn’t be completed. (githubsearch.UserError error 1.)"){
          return NSLocalizedString("Client error", comment: "My error")
      }else if (underlyingError.localizedDescription == "The operation couldn’t be completed. (githubsearch.UserError error 2.)"){
          return NSLocalizedString("No data", comment: "My error")
      }
      return NSLocalizedString("Error", comment: "My error")
  }
  var recoverySuggestion: String? {
      
      if (underlyingError.localizedDescription == "The operation couldn’t be completed. (githubsearch.UserError error 0.)") {
          
          return NSLocalizedString("Seems you have network issue. Please check and try again", comment: "No internet")
      }else if (underlyingError.localizedDescription == "The operation couldn’t be completed. (githubsearch.UserError error 1.)"){
          
          return NSLocalizedString("you do not have access", comment: "My error")
      }else if (underlyingError.localizedDescription == "The operation couldn’t be completed. (githubsearch.UserError error 2.)"){
          return NSLocalizedString("Seems there isn't any data coming through", comment: "My error")
      }
      return NSLocalizedString("An error occur", comment: "My error")
      
  }

  init?(error: LocalizedError?) {
    guard let localizedError = error else { return nil }
    underlyingError = localizedError
  }
}

extension View {
  func errorAlert(error: Binding<LocalizedError?>, buttonTitle: String = "OK") -> some View {
    let localizedAlertError = LocalizedAlertError(error: error.wrappedValue)
    return alert(isPresented: .constant(localizedAlertError != nil), error: localizedAlertError) { _ in
      Button(buttonTitle) {
        error.wrappedValue = nil
      }
    } message: { error in
      Text(error.recoverySuggestion ?? "")
    }
  }
}
