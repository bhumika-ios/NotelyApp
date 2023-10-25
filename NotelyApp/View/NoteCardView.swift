//
//  NoteCardView.swift
//  NotelyApp
//
//  Created by Bhumika Patel on 25/10/23.
//

import SwiftUI

struct NoteCardView: View {
    @Bindable var note: Note
    var isKeyboardEnabled: FocusState<Bool>.Binding
    var body: some View {
        TextEditor (text: $note.content)
            .focused(isKeyboardEnabled)
            .overlay(alignment:.leading, content: {
                Text ("Finish Work")
                    .foregroundStyle(.gray)
                    .padding (.leading, 5)
                    .opacity(note.content.isEmpty ? 1 : 0)
                    .allowsHitTesting (false)
            })
            .scrollContentBackground (.hidden)
            .multilineTextAlignment (.leading)
            .padding (15)
            .frame (maxWidth: .infinity)
            .background(.gray.opacity (0.15),in: .rect(cornerRadius: 12))
    }
}
//#Preview {
//    NoteCardView()
//}
