//
//  EmptyState.swift
//  githubsearch
//
//  Created by  Henrietta Henry on 29/01/2023.
//

import SwiftUI

struct EmptyState: View {
    var message: String
    var imageName: String
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            Image(imageName)
            
            Text(message)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
}

struct EmptyState_Previews: PreviewProvider {
    static var previews: some View {
        EmptyState(message: "We dont have data for you", imageName: "emptySearch")
    }
}
