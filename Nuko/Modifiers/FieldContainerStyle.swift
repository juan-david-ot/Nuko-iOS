//
//  FieldContainerStyle.swift
//  Nuko
//
//  Created by JuanDa on 28/08/2026.
//

import SwiftUI

struct FieldContainerStyle: ViewModifier {
    var hasError: Bool

    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(hasError ? Color.red : Color(.separator), lineWidth: hasError ? 1.5 : 1)
            )
            .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 12))
    }
}

extension View {
    func fieldContainerStyle(hasError: Bool = false) -> some View {
        modifier(FieldContainerStyle(hasError: hasError))
    }
}
