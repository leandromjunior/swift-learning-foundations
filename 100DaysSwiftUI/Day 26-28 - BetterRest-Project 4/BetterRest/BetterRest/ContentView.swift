//
//  ContentView.swift
//  BetterRest
//
//  Created by Leandro Motta Junior on 02/08/25.
//

import CoreML
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
struct BetterRest: View {
    @State private var wakeUp = defaultWakeTime //By default the wakeUp value will be 7:00
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack {
            Form {
                VStack(alignment: .leading) {
                Text("When do you want to Wake Up?")
                    .font(.headline)
                
                DatePicker("Enter a datetime", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
            }
             
                VStack(alignment: .leading) {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.5)
                }
                
                VStack(alignment: .leading) {
                    Text("Daily coffee intake")
                        .font(.headline)
                    
                    // If the unity is 1, so the string is singular else is plural
                    Stepper(coffeeAmount == 1 ? "\(coffeeAmount) cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
                }
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
            .navigationTitle("Better Rest")
            .toolbar {
                Button("Calculate", action: calculateBedTime)
            }
        }
    }
    
    func calculateBedTime() {
        
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60 // Converting to seconds
            let minute = (components.minute ?? 0) * 60 // Converting to seconds
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        
        showingAlert = true
    }
}

/*
 Day 28
 1 - Replace each VStack in our form with a Section, where the text view is the title of the section. Do you prefer this layout or the VStack layout? It’s your app – you choose!
 2 - Replace the “Number of cups” stepper with a Picker showing the same range of values.
 3 - Change the user interface so that it always shows their recommended bedtime using a nice and large font. You should be able to remove the “Calculate” button entirely.
 */
struct RefactoringBetterRest: View {
    
    @State private var wakeUp = defaultWakeTime //By default the wakeUp value will be 7:00
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        
        return Calendar.current.date(from: components) ?? .now // nill coalescing
    }
    
    var body: some View {
        
        NavigationStack {
            Form {
                Section("When do you want to wake up") {
                
                DatePicker("Enter a datetime", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
            }
             
                Section("Desired amount of sleep") {
                    
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.5)
                }
                
                Section("Daily coffee intake") {
                    
                    Picker("Select the cups", selection: $coffeeAmount) {
                        ForEach(1..<21) {cups in
                            Text(cups == 1 ? "\(cups) cup" : "\(cups) cups")
                        }
                    }
                }
                
                VStack {
                    HStack {
                        Text("Bedtime")
                            .font(.title)
                        
                        Spacer()
                        
                        calculateBedTime()
                    }
                    .foregroundStyle(.blue)
                }
            }
            .navigationTitle("Better Rest")
        }
    }
    
    func calculateBedTime() -> some View {
        
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60 // Converting to seconds
            let minute = (components.minute ?? 0) * 60 // Converting to seconds
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            return Text("\(sleepTime.formatted(date: .omitted, time: .shortened))")
        } catch {
            return Text("Sorry, there was a problem calculating your bedtime.")
        }
    }
}

#Preview {
    RefactoringBetterRest()
}
