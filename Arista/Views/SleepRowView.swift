//
//  SleepRowView.swift
//  Arista
//
//  Created by Renaud Leroy on 13/10/2025.
//

import SwiftUI

struct SleepRowView: View {
    var session: Sleep
    
    var body: some View {
        HStack {
            Image(systemName: "bed.double")
                .font(.custom("FontAwesome", size: 30))
                .frame(width: 50)
                .padding(.trailing, 10)
            VStack(alignment: .leading, spacing: 4) {
                Text("Session de sommeil")
                    .font(.headline.bold())
                HStack {
                    Image(systemName: "stopwatch")
                    Text("\(session.duration) min")
                        .foregroundColor(.secondary)
                }
                .font(.footnote)
                HStack {
                    Text("Début:")
                    Text("\(session.startDate?.formatted(date: .abbreviated, time: .shortened) ?? "")")
                        .foregroundColor(.secondary)
                }
                .font(.footnote)
            }
            Spacer()
            VStack {
                Text("Qualité").font(.footnote)
                    .padding(4)
                QualityIndicator(quality: Int(session.quality))
                Spacer()
            }
        }
        .frame(maxHeight: 70)
    }
}

struct QualityIndicator: View {
    let quality: Int
        
    var body: some View {
        let level = qualityLevel(quality)
        HStack(spacing: 2) {
            ForEach(0..<level, id: \.self) { _ in
                Image(systemName: "moon.fill")
                    .foregroundColor(qualityColor(quality))
                    .font(.caption)
            }
        }
    }
    
    private func qualityLevel(_ quality: Int) -> Int {
        switch quality {
        case 0...3:
            return 1
        case 4...6:
            return 2
        case 7...10:
            return 3
        default:
            return 1
        }
    }
    
    
    func qualityColor(_ quality: Int) -> Color {
        switch quality {
        case 0...3:
            return .red
        case 4...6:
            return .yellow
        case 7...10:
            return .green
        default:
            return .gray
        }
    }
}


#Preview {
    let context = PersistenceController.preview.container.viewContext
    return SleepRowView(session: Sleep(context: context))
}
