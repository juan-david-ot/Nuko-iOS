//
//  InfoCard.swift
//  Nuko
//
//  Created by JuanDa on 29/08/2026.
//

import SwiftUI

struct InfoCard<Content: View>: View {
    let icon: String
    let title: String
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(title, systemImage: icon)
                .font(.headline.bold())
            VStack(alignment: .leading, spacing: 2) {
                content
            }
            .font(.subheadline)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
    InfoCard(icon: "calendar", title: "Próximos Eventos") {
        Text("Cumpleaños Mamá")
        Text("Cena con Sara").foregroundStyle(.secondary)
        Text("Cine en Familia").foregroundStyle(.secondary)
        Text("Veterinario").foregroundStyle(.secondary)
    }
}
