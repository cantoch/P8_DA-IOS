//
//  AddExerciseView.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import SwiftUI

struct AddExerciseView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: AddExerciseViewModel
    
    var body: some View {
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
            VStack {
                Form {
                    Section("Catégorie") {
                        Picker("Catégorie", selection: $viewModel.category) {
                            Text("Football").tag("Football")
                            Text("Natation").tag("Natation")
                            Text("Cyclisme").tag("Cyclisme")
                            Text("Marche").tag("Marche")
                            Text("Course").tag("Course")
                        }
                    }
                    Section("Heure de début") {
                        DatePicker("Heure de début", selection: $viewModel.startTime, displayedComponents: .hourAndMinute)
                    }
                    Section("Durée") {
                        Stepper("\(viewModel.duration) min", value: $viewModel.duration, in: 10...180, step: 10)
                    }
                    Section("Intensité") {
                        Picker("Intensité", selection: $viewModel.intensity) {
                            Text("Faible").tag(2)
                            Text("Moyenne").tag(5)
                            Text("Forte").tag(9)
                        }
                        .pickerStyle(.segmented)
                    }
                    Section {
                        HStack {
                            Spacer()
                            Button("Ajouter l'exercice") {
                                if viewModel.category.isEmpty ||
                                    viewModel.duration <= 0 ||
                                    viewModel.intensity == 0 {
                                    viewModel.errorMessage = "Veuillez remplir tous les champs avant de valider."
                                } else if viewModel.addExercise() {
                                    presentationMode.wrappedValue.dismiss()
                                } else {
                                    viewModel.errorMessage = "Impossible d’ajouter l’exercice."
                                }
                            }
                            .padding(15)
                            .bold()
                            Spacer()
                        }
                        .foregroundStyle(Color(.white))
                        .background(Color(hex: "52B788"))
                        .cornerRadius(50)
                        .listRowBackground(Color.clear)
                        .padding(.horizontal, 40)
                        HStack {
                            Spacer()
                            if let errorMessage = viewModel.errorMessage {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .font(.footnote)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, 5)
                                    .listRowBackground(Color.clear)
                            }
                            Spacer()
                        }
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
                .padding(.top, 20)
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Nouvel Exercice ...")
        }
    }
}

#Preview {
    AddExerciseView(viewModel: AddExerciseViewModel(context: PersistenceController.preview.container.viewContext))
}
