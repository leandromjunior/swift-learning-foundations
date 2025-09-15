//
//  ExpensesView.swift
//  iExpense
//
//  Created by Leandro Motta Junior on 14/09/25.
//

import SwiftUI
import SwiftData

struct ExpensesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    
    var body: some View {
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
    }
    
    init(filterType: String, sortOrder: [SortDescriptor<Expense>]) {
        _expenses = Query(filter: #Predicate<Expense> { expense in
            filterType == "" || expense.type == filterType
        }, sort: sortOrder)
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let item = expenses[offset]
            modelContext.delete(item)
        }
    }
}

#Preview {
    ExpensesView(filterType: "Personal", sortOrder: [SortDescriptor(\Expense.name)])
        .modelContainer(for: Expense.self)
}
