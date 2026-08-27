//
//  ContentView.swift
//  Nuko
//
//  Created by JuanDa on 25/3/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var authEnvironment: AuthEnvironment
    
    func logIn() async {
        do {
            let user = try await AuthService.logIn(user: User(username: "", password: ""))
            authEnvironment.token = user
        }
        catch {
            print(error)
        }
    }
    
    var body: some View {
        if authEnvironment.token != nil {
            AppView()
        }
        else {
            Text("Inicia sesion")
            Button("Log in") {
                Task {
                    await logIn()
                }
            }
        }
    }
}

#Preview {
    ContentView().environmentObject(AuthEnvironment())
}
