//
//  NoteGroup.swift
//  NotelyApp
//
//  Created by Bhumika Patel on 25/10/23.
//

import SwiftUI
import SwiftData

@Model
class NoteGroup{
    var groupTitle: String
    
    //Relationship
    @Relationship(deleteRule: .cascade, inverse: \Note.group)
    
    var note: [Note]?
    
    init(groupTitle: String) {
        self.groupTitle = groupTitle
    }
}
