//
//  DetailView.swift
//  HabitTracker
//
//  Created by Leandro Motta Junior on 24/08/25.
//

import SwiftUI

struct DetailView: View {
    //var habit = Habits()
    var habit = [Habit]()

    var body: some View {
        NavigationStack {
            ForEach(habit, id: \.name) { i in //habit.habits
                VStack {
                    Text("\(i.name)")
                        .font(.title)
                        .padding(.top)
                    
                    Spacer()
                    
                    Text("\(i.description)")
                    
                    Spacer()
                }
            }
            
            VStack {
                Spacer()
                
                Button("Register activity") {
                    
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
//    DetailView(habit: Habits())
    DetailView(habit: [Habit(name: "Teste", description: "Testetstetse")])
}
