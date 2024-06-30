//
//  LoginView.swift
//  GitCoredata
//
//  Created by user263604 on 6/29/24
6/29/24.
//

import SwiftUI

struct LoginView: View {
    @State private var authToken = ""
    @State private var isLoggedIn = false
    @Environment(\.managedObjectContext) private var context
    //ghp_kKqZhM5QtjAgC9m2HLtrOip0BK2lVn16WsK
    
    var body: some View {
        if isLoggedIn {
            HomeView(authToken: authToken, context: context)
        } else {
            VStack {
                TextField("Enter GitHub Personal Access Token", text: $authToken)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    isLoggedIn = true
                }) {
                    Text("Login")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }
}

#Preview {
    LoginView()
}
