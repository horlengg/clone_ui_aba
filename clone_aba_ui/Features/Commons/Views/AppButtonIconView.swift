//
//  AppButtonIconView.swift
//  clone_aba_ui
//
//  Created by Houleng Ly on 20/12/25.
//

import SwiftUI


struct AppButtonIconView: View {
    
    var iconName  : String
    var action    : () -> Void
    var size : CGFloat
    
    var body: some View {
        
        Button(action:action) {
            Image(iconName)
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size)
        }
        .buttonStyle(.plain)
    }
}
