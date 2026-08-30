//
//  UnderlineTab.swift
//  Nuko
//
//  Created by JuanDa on 29/08/2026.
//

import SwiftUI

struct UnderlineTab: View {
    @Binding var selectedTab: HomeTab
    @Namespace private var indicator

    private let tabs: [(HomeTab, String)] = [
        (.resume, "Resumen"),
        (.core, "Núcleo"),
        (.chat, "Chat")
    ]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs, id: \.0) { tab, label in
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedTab = tab
                    }
                } label: {
                    VStack(spacing: 8) {
                        Text(label)
                            .font(.subheadline.weight(selectedTab == tab ? .semibold : .regular))
                            .foregroundStyle(selectedTab == tab ? .primary : .secondary)
                            .frame(maxWidth: .infinity)

                        ZStack {
                            if selectedTab == tab {
                                Capsule()
                                    .fill(Color.accentColor)
                                    .frame(height: 2)
                                    .matchedGeometryEffect(id: "underline", in: indicator)
                            } else {
                                Capsule()
                                    .fill(Color.clear)
                                    .frame(height: 2)
                            }
                        }
                    }
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    UnderlineTab(selectedTab: Binding.constant(HomeTab.chat))
}
