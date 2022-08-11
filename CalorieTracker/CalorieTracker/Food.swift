//
//  Food.swift
//  CalorieTracker
//
//  Created by Tony Tang on 8/10/22.
//

import SwiftUI

public struct Food : Codable, Equatable, Identifiable {
    public var id: Int64
    public var name: String
    public var proteins: Int
    public var fats: Int
    public var carbs: Int
    
    public init(id: Int64, name: String, proteins: Int, fats: Int, carbs: Int) {
        self.id = id
        self.name = name
        self.proteins = proteins
        self.fats = fats
        self.carbs = carbs
    }
    
}
