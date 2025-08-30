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
    @State private var registerCount = 0
    
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
                    let habit = Habit(name: name, description: description, registerCount: registerCount)
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
