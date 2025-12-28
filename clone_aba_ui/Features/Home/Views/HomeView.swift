//
//  HomeView.swift
//  clone_aba_ui
//
//  Created by Houleng Ly on 20/12/25.
//

import SwiftUI

struct HomeView : View {
    
    var body: some View {
        
        AppBackgroundView {
            
            VStack {
                
                Spacer()
                    .frame(height: 40)

                HomeHeaderView()
                
                Spacer()
                    .frame(height: 20)
                
                buildHomeUserProfileView()
                
                Spacer()
                    .frame(height: 20)
                
                HomeBannerView()
                
                Spacer()
                    .frame(height: 20)
                
                HomeMenuListView()
//                    .background()
                
                Spacer()
                    .frame(height: 20)
                

                
                Spacer()
                
                
            }
        }
    }
    
    @ViewBuilder
    func buildHomeUserProfileView() -> some View {
        HStack {
            
            Image("profile")
                .resizable()
                .scaledToFit()
                .frame(width: 50,height: 50)
                .clipShape(Circle())
                .overlay(
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(style: StrokeStyle(lineWidth: 2))
                        .fill(.white)
                )
            
            Spacer()
                .frame(width: 20)
            
            VStack(alignment : .leading) {
                
                Text("Good Morning")
                    .font(.caption)
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                
                Text("Houleng")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
            }
            
            Spacer()
        }
        .padding(.horizontal,20)
    }
}

