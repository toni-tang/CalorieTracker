//
//  ContentView+ViewModel.swift
//  CalorieTracker
//
//  Created by Tony Tang on 8/12/22.
//

import SwiftUI

extension ContentView {
    @MainActor final class ViewModel: ObservableObject {
        @Published var foodList = [Food]()
        @Published var selectedFoodList = [Food]()
        private let foodDatabase : FoodStoring
        
        init(foodDatabase: FoodStoring) {
            self.foodDatabase = foodDatabase
            refresh()
        }
        
        func refresh() {
            Task {
                self.foodList = try await foodDatabase.fetch()
            }
        }
        
    }
}
