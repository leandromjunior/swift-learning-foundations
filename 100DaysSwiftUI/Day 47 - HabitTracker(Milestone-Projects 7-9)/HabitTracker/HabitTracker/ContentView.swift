//
//  ContentView.swift
//  HabitTracker
//
//  Created by Leandro Motta Junior on 23/08/25.
//

import SwiftUI

struct Habit: Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String
    var registerCount: Int
}

@Observable
class Habits {
    var habits = [Habit]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(habits) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }
    
    init() {
        if let savedHabits = UserDefaults.standard.data(forKey: "Habits") {
            if let decodedHabits = try? JSONDecoder().decode([Habit].self, from: savedHabits) {
                habits = decodedHabits
                return
            }
        }
        
        habits = []
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
