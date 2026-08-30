//
//  AuthEnvironment.swift
//  Nuko
//
//  Created by JuanDa on 27/08/2026.
//

import Foundation
import Combine

@MainActor
final class AuthEnvironment: ObservableObject {
    @Published private(set) var user: User? = nil
    @Published private(set) var isLoading: Bool = true
    
    func authUser() async {
        let token = KeychainStorage.getToken()

        if token != nil {
            do {
                self.user = try await AuthService.verify()
            } catch {
                print(error)
                await logOut()
            }
        }
        else {
            await logOut()
        }
        
        isLoading = false
    }

    func logOut() async {
        KeychainStorage.deleteToken()
        user = nil
        isLoading = false
    }
}
