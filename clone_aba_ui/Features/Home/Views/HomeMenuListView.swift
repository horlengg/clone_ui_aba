//
//  HomeMenuListView.swift
//  clone_aba_ui
//
//  Created by Houleng Ly on 21/12/25.
//

import SwiftUI

struct HomeMenuListView : View {
    
    let menuList = [
        MenuItem(
            icon : "hanuman_icon",
            title: "Payments",
            action: {}
        ),
        MenuItem(
            icon : "transfer_icon",
            title : "Transfer",
            action: {}
        ),
        MenuItem(
            icon : "card_icon",
            title : "Cards",
            action: {}
        ),
        MenuItem(
            icon : "aba_scan_icon",
            title : "ABA Scan",
            action: {}
        ),
        MenuItem(
            icon : "account_icon",
            title : "Accounts",
            action: {}
        ),
        MenuItem(
            icon : "aba_merchant_icon",
            title : "ABA Merchant",
            action: {}
        )
    ]
//    DraggableView
    var body: some View {
        VStack {
            DraggableView(
                menuList: menuList,
                config: MenuGridDisplayerConfig(
                    columns: 3,
                    columnSpacing: 5,
                    rowSpacing: 15,
                    aspectRatio: 110/72
                ),
                transitionInSecond: 0.3
            ) { data in
                buildMenuCard(data)
            }
        }
        .padding(.horizontal,10)
        .padding(.vertical,10)
    }
    
    
    @ViewBuilder
    func buildMenuCard(_ data : MenuItem) -> some View {
        
        VStack(spacing: 5) {
            Image(data.icon)
                .resizable()
                .scaledToFit()
                .frame(height: 40)
            
            Text(data.title)
                .font(.system(size: 12))
                .fontWeight(.semibold)
                .foregroundColor(.primaryColor)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(
            Image("menu_card_background")
                .resizable()
                .aspectRatio(contentMode: .fill)
        )
        .onTapGesture {
            data.action()
        }
    }
    
}


struct MenuItem {
    var icon : String
    var title : String
    var action : () -> Void
}
