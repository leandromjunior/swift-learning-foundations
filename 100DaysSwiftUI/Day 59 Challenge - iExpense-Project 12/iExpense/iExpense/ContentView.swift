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
    
    @State private var sortOrder = [
        SortDescriptor(\Expense.name),
        SortDescriptor(\Expense.amount),
    ]

    @State private var selectedType = ""
    
    var body: some View {
        NavigationStack {
            ExpensesView(filterType: selectedType, sortOrder: sortOrder)
                .navigationTitle("iExpense")
                .toolbar {
                    NavigationLink() {
                        AddView()
                            .navigationBarBackButtonHidden(true)
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            
                            Text("Name")
                                .tag([
                                    SortDescriptor(\Expense.name),
                                    SortDescriptor(\Expense.amount),
                                ])
                            
                            Text("Amount")
                                .tag([
                                    SortDescriptor(\Expense.amount),
                                    SortDescriptor(\Expense.name),
                                ])
                        }
                    }
                    
                    Menu("Filter", systemImage: "line.horizontal.3.decrease.circle") {
                        Button("Show All") {
                            selectedType = ""
                        }
                        
                        Button("Show Business") {
                            selectedType = "Business"
                        }
                        
                        Button("Show Personal") {
                            selectedType = "Personal"
                        }
                    }
                }
            }
        }
    }

#Preview {
    ContentView()
}
