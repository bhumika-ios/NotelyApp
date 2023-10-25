//
//  Item.swift
//  NotelyApp
//
//  Created by Bhumika Patel on 25/10/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
