//
//  NotelyAppApp.swift
//  NotelyApp
//
//  Created by Bhumika Patel on 25/10/23.
//

import SwiftUI
import SwiftData

@main
struct NotelyAppApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            //frame set of mac
            .frame(minWidth: 320, minHeight: 400)
        }
        //.windowResizability(.contentSize)
        //add data model to the app
        // now that we have successfully set up the persistence data model for our app,let's start building of UI
        .modelContainer(for: [Note.self, NoteGroup.self])
    }
}
