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
                
                buildHomeUserProfileView()
                
                Spacer()
                    .frame(height: 20)
                
                buildAppHomeBannerView()
                

                Text("Home Page")
                    .font(.title)
                    .foregroundColor(.white)
                
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
                .frame(width: 60,height: 60)
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
    
    @ViewBuilder
    func buildAppHomeBannerView() -> some View {
        ZStack {
            Image("app_banner_background")
                .resizable()
                .scaledToFit()
                .frame(height: 250)
            
            VStack {
                HStack {
                    VStack {
                        
                    }
                    .frame(width: 60,height: 40)
                    .background(.red)
                    
                    Button(action :{}){
                        Image("")
                    }
                    
                    Spacer()
                }
            }
        }
    }
    
}

