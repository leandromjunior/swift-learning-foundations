//
//  DetailView.swift
//  HabitTracker
//
//  Created by Leandro Motta Junior on 24/08/25.
//

import SwiftUI

struct DetailView: View {
    // A DetailView mostra um hábito, então ela só precisa de um item (Habit), não da coleção inteira. Se passassemos o Habits, teria que também dizer qual item dentro da coleção abrir — o que complicaria e deixaria a DetailView menos reutilizável.
    @Binding var habit: Habit

    var body: some View {
        NavigationStack {

            VStack {
                Text("\(habit.name)")
                    .font(.title)
                    .padding(.top)
                
                Spacer()
                
                Text("\(habit.description)")
                Text("\(habit.registerCount)")
                
                Spacer()
                
                Button("Register activity") {
                    habit.registerCount += 1
                }
            }
        }
    }
}

#Preview {
//    DetailView(habit: Habits())
    DetailView(habit: .constant(Habit(name: "Teste", description: "Teste", registerCount: 3)))
}
