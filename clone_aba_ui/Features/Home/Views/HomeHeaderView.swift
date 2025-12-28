//
//  HomeHeaderView.swift
//  clone_aba_ui
//
//  Created by Houleng Ly on 20/12/25.
//

import SwiftUI

struct HomeHeaderView: View {
    var body: some View {
        HStack(spacing : 20) {
            
            Spacer()
            
            AppButtonIconView(
                iconName: "message_icon",
                action: {},
                size: 25
            )
            AppButtonIconView(
                iconName: "notification_icon",
                action: {},
                size: 30
            )
            AppButtonIconView(
                iconName: "bakong_icon",
                action: {},
                size: 40
            )
            
        }
        .padding(.horizontal,20)
        
    }
}


