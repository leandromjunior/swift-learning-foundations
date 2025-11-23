//
//  AddView.swift
//  iExpense
//
//  Created by Leandro Motta Junior on 12/08/25.
//

import SwiftUI
import SwiftData

struct AddView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "None"
    @State private var amount = 0.0
    
    let types = ["Business", "Personal", "None"]
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Form {
                    TextField("Expense Name", text: $name)
                        .keyboardType(.default)
                    
                    Picker("Type", selection: $type) {
                        ForEach(types, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    TextField("Amount", value: $amount, format: .currency(code: "BRL"))
                        .keyboardType(.decimalPad)
                }
                .navigationTitle("Add new Expense")
                // The code below makes the button appear at the top right of the screen
//                .toolbar {
//                    Button("Save") {
//                        let item = Expense(name: name, type: type, amount: amount)
//                        modelContext.insert(item)
//                        dismiss()
//                    }
//                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
                // This code makes the button appear as a component at the bottom of the screen
                Button {
                    let item = Expense(name: name, type: type, amount: amount)
                    modelContext.insert(item)
                    dismiss()
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity) // Making the button edge to edge
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal, 10) // Giving the button distance from the side edges
                .padding(.vertical, 30) // moving the button away from the bottom edge vertically
            }
        }
    }
}

#Preview {
    AddView()
}
