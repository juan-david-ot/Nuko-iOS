//
//  CoresEnvironment.swift
//  Nuko
//
//  Created by JuanDa on 28/08/2026.
//

import Foundation
import Combine

@MainActor
final class CoresEnvironment: ObservableObject {
    @Published private(set) var cores: [Core] = []
    @Published var core: String? = nil
    
    func refreshCores() async {
        do {
            cores = try await CoreService.getUserCores()
        } catch {
            print(error)
        }
    }
}
