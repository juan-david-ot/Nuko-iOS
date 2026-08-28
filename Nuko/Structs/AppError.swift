//
//  AppError.swift
//  Nuko
//
//  Created by JuanDa on 28/08/2026.
//

import Foundation

struct APIErrorResponse: Decodable {
    let error: String
}

enum AppError: LocalizedError {
    case api(String)
    case unknown

    var errorDescription: String? {
        switch self {
        case .api(let message):
            return message
        case .unknown:
            return "Ha ocurrido un error. Inténtalo de nuevo."
        }
    }
}
