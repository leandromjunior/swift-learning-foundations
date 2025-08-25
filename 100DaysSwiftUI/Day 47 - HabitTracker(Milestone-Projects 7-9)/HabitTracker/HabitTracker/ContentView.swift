//
//  ContentView.swift
//  HabitTracker
//
//  Created by Leandro Motta Junior on 23/08/25.
//

import SwiftUI

struct Habit {
    var name: String
    var description: String
}

@Observable
class Habits {
    var habits = [Habit]()
    
    init(habits: [Habit] = [Habit]()) {
        self.habits = habits
    }
}

struct ContentView: View {
    @Environment(\.dismiss) var dismiss
    @State private var habitTracker = Habits()
    @State private var name = ""
    @State private var description = ""
    @State private var isShowingNewHabit = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(habitTracker.habits, id: \.name) { i in
                    NavigationLink {
                        //DetailView(habit: habitTracker)
                    } label: {
                        VStack (alignment: .leading) {
                            Text("\(i.name)")
                            Text("\(i.description)")
                        }
                    }
                }
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                Button("New Habit", systemImage: "plus") {
                    isShowingNewHabit.toggle()
                }
            }
            .sheet(isPresented: $isShowingNewHabit) {
                AddView(habitTracker: habitTracker)
            }
        }
    }
}

#Preview {
    ContentView()
}
