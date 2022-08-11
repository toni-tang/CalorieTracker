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
    
    
}

