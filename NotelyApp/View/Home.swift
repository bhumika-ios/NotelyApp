//
//  Home.swift
//  NotelyApp
//
//  Created by Bhumika Patel on 25/10/23.
//

import SwiftUI
import SwiftData
struct Home: View {
    @State private var selected: String?
    
    //queries all group
    @Query(animation: .snappy) private var group: [NoteGroup]
    
    //view property
    @State private var addGroup: Bool = false
    @State private var groupTitle: String = ""
    //Model
    @Environment(\.modelContext) private var context
    var body: some View {
        NavigationSplitView{
            List(selection: $selected){
                Text("All Notes")
                    .tag("All Notes")
                    .foregroundStyle(selected == "All Notes" ? Color.primary : .gray)
                Text("Bookmark")
                    .tag("Bookmark")
                    .foregroundStyle(selected == "Bookmark" ? Color.primary : .gray)
                
                // create group
                
                Section{
                    ForEach(group){
                        Text($0.groupTitle)
                            .tag($0.groupTitle)
                            .foregroundStyle(selected == $0.groupTitle ? Color.primary : .gray)
                    }
                } header: {
                    HStack(spacing: 5){
                        Text("Group")
                        Button("", systemImage: "plus"){
                            addGroup.toggle()
                        }
                        .tint(Color.gray)
                        .buttonStyle(.plain)
                    
                    }
                }
            }
        } detail: {
            
        }
        .navigationTitle(selected ?? "Notes")
        .alert("Add Group", isPresented: $addGroup) {
            TextField("Record", text: $groupTitle)
            
            Button("Cancel", role: .cancel){
                groupTitle = ""
                
            }
            
            Button("Add") {
                let group = NoteGroup(groupTitle: groupTitle)
                context.insert(group)
                groupTitle = ""
            }
        }
    }
}

#Preview {
    ContentView()
}
