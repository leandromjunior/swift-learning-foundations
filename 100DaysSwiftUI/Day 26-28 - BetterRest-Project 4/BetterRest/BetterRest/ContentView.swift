//
//  ContentView.swift
//  BetterRest
//
//  Created by Leandro Motta Junior on 02/08/25.
//

import SwiftUI

// Day 26
struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    
    var body: some View {
        VStack(spacing: 25) {
            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.5)
            
            DatePicker("Enter a date", selection: $wakeUp)
            
            DatePicker("Enter a date", selection: $wakeUp)
                .labelsHidden()
            
            DatePicker("Enter a date", selection: $wakeUp, displayedComponents: .date)
            
            DatePicker("Enter a date", selection: $wakeUp, displayedComponents: .hourAndMinute)
            
            DatePicker("Enter a date", selection: $wakeUp, in: Date.now...) // Does not let us to choose any data before today
            
        }
        .padding()
    }
    
    func exampleDates () {
        let tomorrow = Date.now.addingTimeInterval(86400) // This value means 1 day in seconds
        
        // Create a range from those two
        let range = Date.now...tomorrow
    }
}

struct WorkingWithDateView: View {
    var body: some View {
        Text(Date.now, format: .dateTime.hour().minute())
        Text(Date.now, format: .dateTime.day().month().year())
        Text(Date.now.formatted(date: .long, time: .shortened))
    }
    
    func exampleDates() {
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        let date = Calendar.current.date(from: components) ?? .now
    }
}

// Day 27

#Preview {
    WorkingWithDateView()
}
