//
//  SleepError.swift
//  Arista
//
//  Created by Renaud Leroy on 28/09/2025.
//

import Foundation

enum SleepError: Error, Identifiable, LocalizedError {
    case fetchSleepFailed
    case saveSleepFailed
    case unknown
    
    var id : String { localizedDescription }
    
    var errorDescription: String? {
        switch self {
        case .fetchSleepFailed:
            return "Erreur lors de la récupération des sessions de sommeil"
        case .saveSleepFailed:
            return "Erreur lors de l'enregistrement de la session de sommeil"
        case .unknown:
            return "Une erreur inattendue s'est produite"
        }
    }
}

enum ExerciseError: Error, Identifiable, LocalizedError {
    case fetchExerciseFailed
    case saveExerciseFailed
    case deleteExerciseFailed
    case unknown
    
    var id : String { localizedDescription }
    
    var errorDescription: String? {
        switch self {
        case .fetchExerciseFailed:
            return "Erreur lors de la récupération des exercices"
        case .saveExerciseFailed:
            return "Erreur lors de l'enregistrement de l'exercice"
        case .deleteExerciseFailed:
            return "Erreur lors de la suppression de l'exercice"
        case .unknown:
            return "Une erreur inattendue s'est produite"
        }
    }
}

enum UserError: Error, Identifiable, LocalizedError {
    case fetchUserFailed
    case saveUserFailed
    case unknown
    
    var id : String { localizedDescription }
    
    var errorDescription: String? {
        
        switch self {
        case .fetchUserFailed:
            return "Erreur lors de la récupération des informations de l'utilisateur"
        case .saveUserFailed:
            return "Erreur lors de l'enregistrement des informations de l'utilisateur"
        case .unknown:
            return "Une erreur inattendue s'est produite"
        }
    }
}
