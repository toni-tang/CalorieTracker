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
    func save(_ food: Food) async throws -> Food
    @discardableResult func delete(_ food: Food) async throws -> Bool
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
    
    func save(_ food: Food) async throws -> Food {
        try await database.writer.write { db in
            return try food.saved(db)
        }
    }
    
    @discardableResult func delete(_ food: Food) async throws -> Bool {
        try await database.writer.write { db in
            guard let id = food.id else { return false }
            return try Food.deleteOne(db, id: id)
        }
    }
    
}
