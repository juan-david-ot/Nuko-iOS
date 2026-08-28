//
//  AuthView.swift
//  Nuko
//
//  Created by JuanDa on 27/08/2026.
//

import SwiftUI

struct AuthView: View {
    @State private var selectedTab = 0
    @State var text = ""
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(spacing: 20) {
                    Picker("Form", selection: $selectedTab) {
                        Text("Iniciar Sesión").tag(0)
                        Text("Registrarse").tag(1)
                    }
                    .pickerStyle(.segmented)
                    
                    Group {
                        if selectedTab == 0 {
//                            ScrollView {
                                LogInFormView()
//                            }
//                            .scaledToFit()
                        }
                        if selectedTab == 1 {
//                            ScrollView {
                                SignUpFormView(selectedTab: $selectedTab)
//                            }
//                            .scaledToFit()
                        }
                    }
                    .transition(.blurReplace)
                }
                .animation(.easeInOut(duration: 0.25), value: selectedTab)
                .padding(20)
                .background(.cards, in: RoundedRectangle(cornerRadius: 30))
                .padding(.horizontal, 20)
            }
            .padding(.bottom, 300)
            Spacer()
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .scrollDismissesKeyboard(.interactively)
        .onTapGesture {
            hideKeyboard()
        }
        
    }
}

#Preview {
    AuthView()
}
