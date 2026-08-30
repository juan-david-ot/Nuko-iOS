//
//  AppTheme.swift
//  Nuko
//
//  Created by JuanDa on 29/08/2026.
//

import SwiftUI

enum AppTheme: String, CaseIterable, Identifiable {
    case light, dark, system

    var id: String { rawValue }

    var label: String {
        switch self {
        case .light: return "Claro"
        case .dark: return "Oscuro"
        case .system: return "Sistema"
        }
    }

    var colorScheme: ColorScheme? {
        switch self {
        case .light: return .light
        case .dark: return .dark
        case .system: return nil
        }
    }
}
