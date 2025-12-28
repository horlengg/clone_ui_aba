//
//  ColorExtension.swift
//  clone_aba_ui
//
//  Created by Houleng Ly on 20/12/25.
//

//#4f3421


import SwiftUI

extension Color {
    /// Initialize Color from hex string
    /// Supports formats: "#RRGGBB", "RRGGBB", "#RRGGBBAA", "RRGGBBAA"
    ///
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    /// Convert Color to hex string
    func toHex(includeAlpha: Bool = false) -> String? {
        guard let components = UIColor(self).cgColor.components else { return nil }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        let a = components.count >= 4 ? Float(components[3]) : 1.0
        
        if includeAlpha {
            return String(format: "#%02lX%02lX%02lX%02lX",
                         lroundf(r * 255),
                         lroundf(g * 255),
                         lroundf(b * 255),
                         lroundf(a * 255))
        } else {
            return String(format: "#%02lX%02lX%02lX",
                         lroundf(r * 255),
                         lroundf(g * 255),
                         lroundf(b * 255))
        }
    }
}

// MARK: - Usage Examples
struct ColorHexExamples: View {
    var body: some View {
        VStack(spacing: 20) {
            // Different hex formats
            Text("Facebook Blue")
                .foregroundColor(Color(hex: "#1877F2"))
            
            Text("Without # symbol")
                .foregroundColor(Color(hex: "FF5733"))
            
            Text("Short format (3 digits)")
                .foregroundColor(Color(hex: "#F00"))
            
            Text("With alpha channel")
                .foregroundColor(Color(hex: "#FF573380"))
            
            // Using in backgrounds
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(hex: "#4CAF50"))
                .frame(width: 200, height: 50)
                .overlay(
                    Text("Green Background")
                        .foregroundColor(.white)
                )
            
            // Border color
            TextField("Email", text: .constant(""))
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(hex: "#E0E0E0"), lineWidth: 1)
                )
                .padding(.horizontal)
        }
        .padding()
    }
}

// MARK: - Common Color Presets
extension Color {
    static let primaryColor = Color(hex: "#4f3421")
}
