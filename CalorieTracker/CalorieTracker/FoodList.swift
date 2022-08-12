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

final class FoodList: FoodStoring, RandomAccessCollection {
    
    func index(before i: Int) -> Int {
        <#code#>
    }
    
    func index(after i: Int) -> Int {
        <#code#>
    }
    
    var startIndex: Int
    
    var endIndex: Int
    
    typealias Element = Food
    
    typealias Index = Int
    
    typealias SubSequence = Food
    
    typealias Indices = Int
    
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
