//
//  HomeBannerView.swift
//  clone_aba_ui
//
//  Created by Houleng Ly on 21/12/25.
//

import SwiftUI

struct HomeBannerView: View {
    
    @State var isShowAmount : Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                
                Image("app_banner_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 108)
                
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 15)
                    
                    buildBannerTop()
                    
                    Spacer()
                        .frame(height: 4)
                    
                    buildBannerCardTitle()
                    
                    Spacer()
                        .frame(height: 15)
                    
                    HStack(spacing: 10) {
                        
                        buildBannerButton(
                            iconName: "receive_money_icon",
                            label: "Receive",
                            iconSize: 25,
                            action: {}
                        )
                        
                        buildBannerButton(
                            iconName: "send_money_icon",
                            label: "Send",
                            iconSize: 30,
                            action: {}
                        )
                        buildBannerButton(
                            iconName: "send_money_icon",
                            label: "Analytics",
                            iconSize: 30,
                            action: {}
                        )
                        
                        Spacer()
                    }
                }
                .padding(.horizontal, 30)
            }
            .frame(height: 108)
        }
    }
    
    @ViewBuilder
    func buildBannerTop() -> some View {
        HStack(spacing:0) {
            ZStack(alignment: .leading) {
                
                HStack{
                    Text("$44.44")
                        .font(.system(size: 22))
                        .fontWeight(.semibold)
                        .foregroundColor(.primaryColor)
                }
                Image("amount_hidden_cover")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 35)
                    .offset(x : -5)
                    .opacity(isShowAmount ? 0 : 1)
                    .animation(.easeOut(duration: 0.2),value: isShowAmount)
                
                
            }
            .frame(width: 90,height: 30)
            
                
            Button(action: toggleAmount) {
                VStack {
                    Image("eye_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                }
                .frame(width: 30, height: 28)
                .background(Color(hex: "#c7b29b"))
                .cornerRadius(8)
            }
            
        }
        .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    @ViewBuilder
    func buildBannerCardTitle() -> some View {
        HStack {
            Spacer()
                .frame(width: 2)
            
            Text("Default")
                .font(.system(size: 10))
                .foregroundColor(Color.primaryColor)
                .padding(.vertical,2)
                .padding(.horizontal,10)
                .background(
                    LinearGradient(
                        colors: [
                            Color(hex: "#c29561"),
                            Color(hex: "#c79e67")
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .cornerRadius(4)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(lineWidth: 1)
                        .fill(Color.primaryColor)
                )
            
            Text("Savings")
                .font(.system(size: 10))
                .foregroundColor(Color.primaryColor.opacity(0.6))
            
            Spacer()
            
        }
    }
    
    @ViewBuilder
    func buildBannerButton(
        iconName : String,
        label : String,
        iconSize : CGFloat,
        action: @escaping () -> Void
    ) -> some View {
        
        Button(action : action ){
            
            HStack(spacing:5) {
                Image(iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(height : iconSize)
                
                Text(label)
                    .font(.system(size: 12))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.primaryColor)
            }
            
        }
    }
    
    func toggleAmount() {
        isShowAmount = !isShowAmount
    }
    
}
