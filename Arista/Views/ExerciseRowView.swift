//
//  ExerciseRowView.swift
//  Arista
//
//  Created by Renaud Leroy on 13/10/2025.
//

import SwiftUI

struct ExerciseRowView: View {
    var exercise: Exercise
    
    var body: some View {
        HStack {
            Image(systemName: iconForCategory(exercise.category))
                .font(.custom("FontAwesome", size: 30))
                .frame(width: 50)
                .padding(.trailing, 10)
            VStack(alignment: .leading, spacing: 4) {
                Text(exercise.category ?? "Sans catégorie")
                    .font(.headline.bold())
                HStack {
                    Image(systemName: "stopwatch")
                    Text("\(exercise.duration) min")
                        .foregroundColor(.secondary)
                }
                .font(.footnote)
                HStack {
                    Text("Début:")
                    Text("\(exercise.startDate?.formatted(date: .abbreviated, time: .shortened) ?? "")")
                        .foregroundColor(.secondary)
                }
                .font(.footnote)
            }
            Spacer()
            VStack {
                Text("Intensité").font(.footnote)
                    .padding(4)
                IntensityIndicator(intensity: Int(exercise.intensity))
                Spacer()
            }
        }
        .frame(maxHeight: 70)
    }
    
    private func iconForCategory(_ category: String?) -> String {
        switch category {
        case "Football": "sportscourt"
        case "Natation": "figure.pool.swim"
        case "Course": "figure.run"
        case "Marche": "figure.walk"
        case "Cyclisme": "bicycle"
        default: "questionmark.circle.fill"
        }
    }

    struct IntensityIndicator: View {
        var intensity: Int

        var body: some View {
            let level = intensityLevel(for: intensity)
            HStack(spacing: 2) {
                ForEach(0..<level, id: \.self) { _ in
                    Image(systemName: "flame.fill")
                        .foregroundColor(colorForIntensity(intensity))
                        .font(.caption)
                }
            }
        }

        private func intensityLevel(for intensity: Int) -> Int {
            switch intensity {
            case 0...3: return 1
            case 4...6: return 2
            case 7...10: return 3
            default: return 1
            }
        }

        private func colorForIntensity(_ intensity: Int) -> Color {
            switch intensity {
            case 0...3: return .green
            case 4...6: return .yellow
            case 7...10: return .red
            default: return .gray
            }
        }
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    let mockExercise = Exercise(context: context)
    mockExercise.category = "Football"
    mockExercise.duration = 45
    mockExercise.intensity = 3
    mockExercise.startDate = Date()
    return ExerciseRowView(exercise: mockExercise)
}
