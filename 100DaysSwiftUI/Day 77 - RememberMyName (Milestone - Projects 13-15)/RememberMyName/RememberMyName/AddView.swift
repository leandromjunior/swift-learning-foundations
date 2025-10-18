//
//  AddView.swift
//  RememberMyName
//
//  Created by Leandro Motta Junior on 17/10/25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    var onSave: (String) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name the picture", text: $name)
            }
            .navigationTitle("Relate a Name")
            .toolbar {
                Button("Save") {
                    onSave(name)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView() { _ in }
}
