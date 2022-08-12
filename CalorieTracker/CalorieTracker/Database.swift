//
//  Database.swift
//  CalorieTracker
//
//  Created by Tony Tang on 8/10/22.
//

import GRDB

struct Database {
    let writer: DatabaseWriter
        
    init(_ writer: DatabaseWriter) throws {
        self.writer = writer
    }
    
    var reader: DatabaseReader {
        writer
    }
    
    static let db : Database = {
        do {
           let database = try Database(DatabaseQueue(path: "/Users/tonytang/Desktop/Xcode/Projects/CalorieTracker/CalorieTracker/CalorieTracker"))
            return database
        } catch {
            fatalError("Unresolved error: \(error)")
        }
    }()
    
    var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        #if DEBUG
        migrator.eraseDatabaseOnSchemaChange = true
        #endif
        migrator.registerMigration("v1") { db in
            try createFoodTable(db)
        }
        return migrator
    }
    
    private func createFoodTable(_ db: GRDB.Database) throws {
        try db.create(table: "foodList") { table in
            table.autoIncrementedPrimaryKey("id")
            table.column("name", .text).notNull()
            table.column("proteins", .integer).notNull()
            table.column("fats", .integer).notNull()
            table.column("carbs", .integer).notNull()
        }
    }
    
}

