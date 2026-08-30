//
//  StringUtils.swift
//  Nuko
//
//  Created by JuanDa on 29/08/2026.
//

import Foundation

func getCapitals(_ string: String) -> String {
    string
        .trimmingCharacters(in: .whitespacesAndNewlines)
        .split(separator: " ")
        .compactMap { $0.first }
        .map { String($0).uppercased() }
        .joined()
}
