//
//  AuthEnvironment.swift
//  Nuko
//
//  Created by JuanDa on 27/08/2026.
//

import Foundation
import Combine

final class AuthEnvironment: ObservableObject {
    @Published var token: String? = nil
    
    // migrated
    @Published private(set) var user: User? = nil
    @Published private(set) var isLoading: Bool = true
    
    func authUser() async {
        let token = UserDefaults.standard.string(forKey: "authToken")
        print("Token guardado:", token ?? "nil")

        guard let token, !token.isEmpty else {
                print("No hay token, deslogueando")
                await logOut()
                return
            }
        
        do {
            let authUser = try await AuthService.verify()
            print("Verify OK:", authUser)
            self.user = authUser
        } catch {
            print(error)
            await logOut()
            return
        }
        
        isLoading = false
    }

    func logOut() async {
        UserDefaults.standard.removeObject(forKey: "authToken")
        user = nil
        isLoading = false
    }
}
