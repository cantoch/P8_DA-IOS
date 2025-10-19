//
//  ExerciseListView.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import SwiftUI

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



