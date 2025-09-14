//
//  ContentView.swift
//  iExpense
//
//  Created by Leandro Motta Junior on 12/08/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses) { expense in
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(expense.name)
                                .font(.headline)
                            
                            Text(expense.type)
                        }
                        
                        Spacer()
                        
                        if expense.amount == 0 {
                            Text(expense.amount, format: .currency(code: "BRL"))
                                .foregroundStyle(.green)
                        } else if expense.amount < 10 {
                            Text(expense.amount, format: .currency(code: "BRL"))
                                .foregroundStyle(.yellow)
                        } else if expense.amount < 100 {
                            Text(expense.amount, format: .currency(code: "BRL"))
                                .foregroundStyle(.orange)
                        } else {
                            Text(expense.amount, format: .currency(code: "BRL"))
                                .foregroundStyle(.red)
                        }
                            
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink() {
                    AddView()
                        .navigationBarBackButtonHidden(true) //added this modifier to hide the default back button in the AddView and in the "AddView" view i created another toolbar with a cancel button and the dismiss environment method

                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let item = expenses[offset]
            modelContext.delete(item)
        }
    }
}

#Preview {
    ContentView()
}
