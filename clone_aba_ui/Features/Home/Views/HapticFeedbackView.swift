//
//  HapticFeedbackView.swift
//  clone_aba_ui
//
//  Created by Houleng Ly on 26/12/25.
//

import SwiftUI

struct HapticFeedbackView: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Haptic Feedback Demo")
                .font(.title)
                .fontWeight(.bold)
            
            // Impact Haptics
            VStack(alignment: .leading, spacing: 15) {
                Text("Impact Feedback")
                    .font(.headline)
                
                HStack(spacing: 15) {
                    Button("Light") {
                        let impact = UIImpactFeedbackGenerator(style: .light)
                        impact.impactOccurred()
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Medium") {
                        let impact = UIImpactFeedbackGenerator(style: .medium)
                        impact.impactOccurred()
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Heavy") {
                        let impact = UIImpactFeedbackGenerator(style: .heavy)
                        impact.impactOccurred()
                    }
                    .buttonStyle(.bordered)
                }
            }
            
            Divider()
            
            // Notification Haptics
            VStack(alignment: .leading, spacing: 15) {
                Text("Notification Feedback")
                    .font(.headline)
                
                HStack(spacing: 15) {
                    Button("Success") {
                        let notification = UINotificationFeedbackGenerator()
                        notification.notificationOccurred(.success)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    
                    Button("Warning") {
                        let notification = UINotificationFeedbackGenerator()
                        notification.notificationOccurred(.warning)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    
                    Button("Error") {
                        let notification = UINotificationFeedbackGenerator()
                        notification.notificationOccurred(.error)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                }
            }
            
            Divider()
            
            // Selection Haptic
            VStack(alignment: .leading, spacing: 15) {
                Text("Selection Feedback")
                    .font(.headline)
                
                Button("Selection Change") {
                    let selection = UISelectionFeedbackGenerator()
                    selection.selectionChanged()
                }
                .buttonStyle(.bordered)
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    HapticFeedbackView()
}
