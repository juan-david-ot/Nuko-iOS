//
//  RequiredLabel.swift
//  Nuko
//
//  Created by JuanDa on 28/08/2026.
//

import SwiftUI

struct RequiredLabel: View {
    let text: String
    var isRequired: Bool = true

    var body: some View {
        HStack(spacing: 2) {
            Text(text)
            if isRequired {
                Text("*")
                    .foregroundStyle(.red)
            }
        }
        .font(.footnote.bold())
    }
}

#Preview {
    RequiredLabel(text: "Required Field")
}
