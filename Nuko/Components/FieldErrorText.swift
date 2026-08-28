//
//  FieldErrorText.swift
//  Nuko
//
//  Created by JuanDa on 28/08/2026.
//

import SwiftUI

struct FieldErrorText: View {
    let text: String?

    var body: some View {
        if let text {
            Text(text)
                .font(.caption)
                .foregroundStyle(.red)
        }
    }
}

#Preview {
    FieldErrorText(text: "Error")
}
