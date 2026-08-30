//
//  CoreService.swift
//  Nuko
//
//  Created by JuanDa on 28/08/2026.
//

import Foundation
import Alamofire

nonisolated struct CreateCoreResponse: Decodable, Sendable {
    let newCore: Core
    let newCoreUser: CoreUser
}

nonisolated struct InvitationLinkResponse: Decodable, Sendable {
    let inviteLink: String
}

nonisolated struct DecodeInvitationResponse: Decodable, Sendable {
    let core: Core
    let hostUser: User
}

nonisolated struct AcceptInvitationResponse: Decodable, Sendable {
    let core: Core
    let newCoreUser: CoreUser
}

enum CoreService {
    static func getUserCores() async throws -> [Core] {
        let request = AF.shared
            .request("\(AF.baseURL)/cores", method: .get)
            .validate()
        
        return try await decode([Core].self, from: request)
    }
    
    static func getUserCoreById(coreId: String) async throws -> Core {
        let request = AF.shared
            .request("\(AF.baseURL)/cores/\(coreId)", method: .get)
            .validate()
        
        return try await decode(Core.self, from: request)
    }
    
    static func getUserCoreInformationById(coreId: String) async throws -> Core {
        let request = AF.shared
            .request("\(AF.baseURL)/cores/\(coreId)/information", method: .get)
            .validate()
        
        return try await decode(Core.self, from: request)
    }
    
    static func createCore(core: Core) async throws -> CreateCoreResponse {
        let request = AF.shared
            .request("\(AF.baseURL)/cores", method: .post, parameters: core, encoder: JSONParameterEncoder.default)
            .validate()
        
        return try await decode(CreateCoreResponse.self, from: request)
    }
    
    static func createInvitationToCore(coreId: String) async throws -> String {
        let request = AF.shared
            .request("\(AF.baseURL)/cores/\(coreId)/invitation", method: .post)
            .validate()
        
        return try await decode(InvitationLinkResponse.self, from: request).inviteLink
    }
    
    static func decodeInvitationToCore(token: String) async throws -> DecodeInvitationResponse {
        let request = AF.shared
            .request("\(AF.baseURL)/cores/invitation/\(token)", method: .get)
            .validate()
        
        return try await decode(DecodeInvitationResponse.self, from: request)
    }
    
    static func acceptInvitationToCore(token: String) async throws -> AcceptInvitationResponse {
        let request = AF.shared
            .request("\(AF.baseURL)/cores/invitation/\(token)", method: .post)
            .validate()
        return try await decode(AcceptInvitationResponse.self, from: request)
    }
}
