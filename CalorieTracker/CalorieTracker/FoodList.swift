//
//  FoodList.swift
//  CalorieTracker
//
//  Created by Tony Tang on 8/11/22.
//

import SwiftUI
import GRDB

protocol FoodStoring {
    func fetch() async throws -> [Food]
}

final class FoodList: FoodStoring {
    private let database: Database
    
    init(_ database: Database = .db) {
        self.database = database
    }

    func fetch() async throws -> [Food] {
        try await database.reader.read { db in
            return try Food.fetchAll(db)
        }
    }
    
}
