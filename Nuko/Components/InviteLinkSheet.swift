//
//  InviteLinkSheet.swift
//  Nuko
//
//  Created by JuanDa on 29/08/2026.
//

import SwiftUI

struct InviteLinkSheet: View {
    let inviteLink: String?
    let error: String?
    
    @State private var didCopy = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Text("¡Comparte la invitación!")
                .font(.title3.bold())
            
            HStack {
                Text(inviteLink ?? "Generando enlace…")
                    .font(.footnote)
                    .lineLimit(1)
                    .truncationMode(.middle)
                Spacer()
                Button {
                    if let inviteLink {
                        UIPasteboard.general.string = inviteLink
                        didCopy = true
                    }
                } label: {
                    Image(systemName: didCopy ? "checkmark" : "square.on.square")
                }
                .disabled(inviteLink == nil)
            }
            .padding()
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12))
            
            if let error {
                Text(error)
                    .font(.footnote)
                    .foregroundStyle(.red)
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    InviteLinkSheet(inviteLink: nil, error: nil)
}
