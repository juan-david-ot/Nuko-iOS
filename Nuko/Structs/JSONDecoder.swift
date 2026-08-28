//
//  JSONDecoder.swift
//  Nuko
//
//  Created by JuanDa on 26/08/2026.
//

import Foundation

extension JSONDecoder {
    nonisolated static let nukoDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
}
