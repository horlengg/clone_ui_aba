//
//  AppViewBackgroound.swift
//  clone_aba_ui
//
//  Created by Houleng Ly on 20/12/25.
//

import SwiftUI

struct AppBackgroundView : View {
    let content: AnyView
    
    init<Content: View>(@ViewBuilder content: () -> Content) {
        self.content = AnyView(content())
    }
    
    var body: some View {
        ZStack {
            Image("app_background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            content
        }
    }
}
