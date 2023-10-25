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
    @State private var requestedGroup: NoteGroup?
    @State private var deleteRequest: Bool = false
    @State private var renameRequest: Bool = false
    @State private var isDark: Bool = true
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
                    ForEach(group){ group in
                        Text(group.groupTitle)
                            .tag(group.groupTitle)
                            .foregroundStyle(selected == group.groupTitle ? Color.primary : .gray)
                        
                            .contextMenu{
                                Button("Rename"){
                                    groupTitle = group.groupTitle
                                    requestedGroup = group
                                    renameRequest = true
                                }
                                Button("Delete"){
                                    groupTitle = group.groupTitle
                                    requestedGroup = group
                                    deleteRequest = true
                                }
                            }
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
            //rename
            .alert("Rename Group", isPresented: $renameRequest) {
                TextField("Record", text: $groupTitle)
                
                Button("Cancel", role: .cancel){
                    groupTitle = ""
                    requestedGroup = nil
                    
                }
                
                Button("Rename") {
                    if let requestedGroup {
                        requestedGroup.groupTitle = groupTitle
                        groupTitle = ""
                        self.requestedGroup = nil
                    }
                }
            }
            //delete
            .alert("Are you sure to delete \(groupTitle) Group?", isPresented: $deleteRequest) {
                Button("Cancel", role: .cancel){
                    groupTitle = ""
                    requestedGroup = nil
                    
                }
                
                Button("Delete", role: .destructive) {
                    if let requestedGroup {
                        context.delete(requestedGroup)
                        groupTitle = ""
                        self.requestedGroup = nil
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    HStack(spacing: 10){
                        Button("", systemImage: "plus"){
                            let note = Note(content: "")
                            context.insert(note)
                        }
                        Button("", systemImage: isDark ? "moon" : "sun.min"){
                            isDark.toggle()
                        }
                        .contentTransition(.symbolEffect(.replace))
                    }
                }
            }
            .preferredColorScheme(isDark ? .light : .dark)
        } detail: {
            NoteView(group: selected, allGroup: group)
        }
        
        
    }
}

#Preview {
    ContentView()
}
