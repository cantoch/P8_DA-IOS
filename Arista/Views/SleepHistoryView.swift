//
//  SleepHistoryView.swift
//  Arista
//
//  Created by Vincent Saluzzo on 08/12/2023.
//

import SwiftUI

import CoreData

struct SleepHistoryView: View {
    @ObservedObject var viewModel: SleepHistoryViewModel
    
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
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage.localizedDescription)
                            .foregroundColor(.red)
                    }
                    else if viewModel.sleepSessions.isEmpty {
                        Text("Aucun exercice enregistré pour le moment.")
                            .foregroundColor(.secondary)
                    }
                    ForEach(viewModel.sleepSessions) { session in
                        SleepRowView(session: session)
                    }
                    .navigationTitle("Sommeils")
                }
                .scrollContentBackground(.hidden)
            }
        }
    }
}

#Preview {
    SleepHistoryView(viewModel: SleepHistoryViewModel(context: PersistenceController.shared.container.viewContext))
}



