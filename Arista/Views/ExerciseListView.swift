//
//  ExerciseListView.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import SwiftUI

import CoreData // temporaire

struct ExerciseListView: View {
    @ObservedObject var viewModel: ExerciseListViewModel
    @State private var showingAddExerciseView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [
                        Color("FondPrincipal"),
                        Color("TonSecondaire"),
                        Color("Accent")
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                List {
                    if let error = viewModel.errorMessage {
                        Text(error.localizedDescription)
                            .foregroundColor(.red)
                            .font(.callout)
                    }
                    else if viewModel.exercises.isEmpty {
                        Text("Aucun exercice enregistré pour le moment.")
                            .foregroundColor(.secondary)
                    }
                    ForEach(viewModel.exercises) { exercise in
                        ExerciseRowView(exercise: exercise)
                    }
                    .onDelete(perform: viewModel.removeExercise)
                }
                .scrollContentBackground(.hidden)
                .onAppear() {
                    viewModel.fetchExercises()
                }
                .navigationTitle("Exercices")
                .navigationBarItems(trailing: Button(action: {
                    showingAddExerciseView = true
                }) {
                    Image(systemName: "plus")

                })
            }
            .sheet(isPresented: $showingAddExerciseView, onDismiss: {
                viewModel.fetchExercises()
            }) {
                AddExerciseView(viewModel: AddExerciseViewModel(context: viewModel.viewContext))
            }
        }
    }
}



#Preview("mockList") {
    // Création d’un contexte en mémoire (pas de vraie persistance)
    let context = PersistenceController.preview.container.viewContext
    
    // Reset du contexte et suppression des exercices existants pour éviter les doublons en preview
    context.reset()
    let fetchRequest: NSFetchRequest<Exercise> = Exercise.fetchRequest()
    if let existing = try? context.fetch(fetchRequest) {
        existing.forEach { context.delete($0) }
        try? context.save()
    }
    
    // On ajoute deux exercices mockés
    let exercise1 = Exercise(context: context)
    exercise1.category = "Course"
    exercise1.duration = 45
    exercise1.startDate = Date()
    exercise1.intensity = 7
    
    let exercise2 = Exercise(context: context)
    exercise2.category = "Cyclisme"
    exercise2.duration = 90
    exercise2.startDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())
    exercise2.intensity = 5
    
    let exercise3 = Exercise(context: context)
    exercise3.category = "Natation"
    exercise3.duration = 45
    exercise3.startDate = Date()
    exercise3.intensity = 10
    
    let exercise4 = Exercise(context: context)
    exercise4.category = "Marche"
    exercise4.duration = 90
    exercise4.startDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())
    exercise4.intensity = 3
    
    // Sauvegarde des données mockées
    try? context.save()
    
    // ViewModel initialisé avec ces données
    let viewModel = ExerciseListViewModel(context: context)
    viewModel.exercises = [exercise1, exercise2]
    
    return ExerciseListView(viewModel: viewModel)
}

#Preview("emptyList") {
    ExerciseListView(viewModel: ExerciseListViewModel(context: PersistenceController.shared.container.viewContext))
}

