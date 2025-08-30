//
//  ContentView.swift
//  HabitTracker
//
//  Created by Leandro Motta Junior on 23/08/25.
//

import SwiftUI

struct Habit: Identifiable {
    var id = UUID()
    var name: String
    var description: String
    var registerCount: Int
}

@Observable
class Habits {
    var habits = [Habit]()
    
    init(habits: [Habit] = [Habit]()) {
        self.habits = habits
    }
}

struct ContentView: View {
    @State var habitTracker = Habits()
    @State private var isShowingNewHabit = false
    var body: some View {
        NavigationStack {
            List {
                ForEach($habitTracker.habits) { $i in
                    NavigationLink {
                        DetailView(habit: $i)
                    } label: {
                        VStack (alignment: .leading) {
                            Text("\(i.name)")
                            Text("\(i.description)")
                            Text("\(i.registerCount)")
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
