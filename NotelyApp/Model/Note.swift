//
//  Note.swift
//  NotelyApp
//
//  Created by Bhumika Patel on 25/10/23.
//

import SwiftUI
import SwiftData

@Model
class Note {
    var content: String
    var isBookmark: Bool = false
    var group: NoteGroup?
    
    init(content: String, group: NoteGroup? = nil) {
        self.content = content
        self.group = group
    }
}
