//
//  Home.swift
//  NotelyApp
//
//  Created by Bhumika Patel on 25/10/23.
//

import SwiftUI

struct Home: View {
    @State private var selected: String?
    var body: some View {
        NavigationSplitView{
            List(selection: $selected){
                Text("All Notes")
                    .tag("All Notes")
                Text("Bookmark")
                    .tag("Bookmark")
                
                // create group
                
                Section{
                    
                } header: {
                    HStack(spacing: 5){
                        Text("Group")
                        Button("", systemImage: "plus"){
                            
                        }
                        .tint(Color.gray)
                        .buttonStyle(.plain)
                    
                    }
                }
            }
        } detail: {
            
        }
        .navigationTitle(selected ?? "Notes")
    }
}

#Preview {
    ContentView()
}
