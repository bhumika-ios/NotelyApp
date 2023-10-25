//
//  NoteView.swift
//  NotelyApp
//
//  Created by Bhumika Patel on 25/10/23.
//

import SwiftUI
import SwiftData

struct NoteView: View {
    var group: String?
    var allGroup: [NoteGroup]
    
    @Query private var notes: [Note]
    init(group: String?, allGroup: [NoteGroup]) {
        self.group = group
        self.allGroup = allGroup
        let predicate = #Predicate<Note>{
            return $0.group?.groupTitle == group
        }
        let bookmarkPredicate = #Predicate<Note>{
            return $0.isBookmark
        }
        let finalPredicate = group == "All Notes" ? nil : (group == "Bookmark" ? bookmarkPredicate : predicate)
        _notes = Query(filter: finalPredicate, sort: [], animation: .snappy)
    }
    @FocusState private var isKeyboardEnabled : Bool
    @Environment(\.modelContext) private var context
    var body: some View {
        
        GeometryReader{
            let size = $0.size
            let width = size.width
            
            let rowCount = max(Int(width / 250), 1)
            
            ScrollView{
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 10), count: rowCount),spacing: 10){
                    ForEach(notes){ note in
                        NoteCardView(note: note, isKeyboardEnabled: $isKeyboardEnabled)
                            .contextMenu {
                                
                                Button(note.isBookmark ? "Remove from Bookmark" : "Move to Bookmark"){
                                    note.isBookmark.toggle()
                                }
                                Menu{
                                    ForEach(allGroup) { group in
                                        Button {
                                            note.group = group
                                        } label: {
                                            HStack(spacing: 5) {
                                                if group == note.group {
                                                    Image (systemName: "checkmark")
                                                        .font(.caption)
                                                }
                                                Text(group.groupTitle)
                                            }
                                        }
                                    }
                                    Button("Remove from Group") {
                                        note.group = nil
                                    }
                                } label: {
                                    Text("Group")
                                }
                                Button("Delete", role: .destructive) {
                                context.delete (note)
                                }
                            }
                    }
                    
                }
                .padding(12)
            }
            .onTapGesture {
                isKeyboardEnabled = false
            }
        }
    }
}

#Preview {
    ContentView()
}
//    Menu {
//        ForEach(allGroup) { group in
//            Button {
//                note.group = group
//            } label: {
//                HStack(spacing: 5) {
//                    if group == note.group {
//                        Image (systemName: "checkmark")
//                            .font(.caption)
//                    }
//                    Text(group.groupTitle)
//                }
//            
//            }
//        } label:{
//            Text("Group")
//        }
//    }
