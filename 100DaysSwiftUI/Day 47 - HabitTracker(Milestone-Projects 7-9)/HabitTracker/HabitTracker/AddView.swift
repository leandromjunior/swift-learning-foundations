//
//  AddView.swift
//  HabitTracker
//
//  Created by Leandro Motta Junior on 24/08/25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var description = ""
    
    var habitTracker: Habits
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Habit Name", text: $name)
                TextField("Description", text: $description)
            }
            .navigationTitle("New Habit")
            .toolbar {
                Button("Save") {
                    let habit = Habit(name: name, description: description)
                    habitTracker.habits.append(habit)
                    
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(habitTracker: Habits())
}
