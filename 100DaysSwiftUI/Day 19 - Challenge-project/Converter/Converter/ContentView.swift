//
//  ContentView.swift
//  Converter
//
//  Created by Leandro Motta Junior on 25/07/25.
//
// Link to the challenge description: www.hackingwithswift.com/100/swiftui/19

import SwiftUI

struct ContentView: View {
    @State private var inputNumber = 0.0
    let units = ["Celsius", "Fahrenheit", "Kelvin"]
    @State private var selectedUnitFrom = "Celsius"
    @State private var selectedUnitTo = "Fahrenheit"
    
    var convertedValue: Double {
        var value = 0.0
        if selectedUnitFrom == units[0] && selectedUnitTo == units[1] {
            value = (inputNumber * 9/5) + 32
        } else if selectedUnitFrom == units[0] && selectedUnitTo == units[2] {
            value = inputNumber + 273.15
        } else if selectedUnitFrom == units[1] && selectedUnitTo == units[0] {
            value = (inputNumber - 32) / 1.8
        } else if selectedUnitFrom == units[1] && selectedUnitTo == units[2] {
            value = (5/9 * (inputNumber - 32)) + 273.15
        } else if selectedUnitFrom == units[2] && selectedUnitTo == units[1] {
            value = (9/5 * (inputNumber - 273.15)) + 32
        } else if selectedUnitFrom == units[2] && selectedUnitTo == units[0] {
            value = inputNumber - 373.15
        } else {
            value = inputNumber
        }
        
        return value
    }
    
    var body: some View {
        Form {
            Section ("Select the units you want to convert") {
                Picker("From", selection: $selectedUnitFrom) {
                    ForEach(units, id: \.self) { unitFrom in
                        Text(unitFrom)
                    }
                }
                
                Picker("To", selection: $selectedUnitTo) {
                    ForEach(units, id: \.self) { unitTo in
                        Text(unitTo)
                    }
                }
            }
            
            Section ("Temperature") {
                TextField("Type the temerature you want to convert", value: $inputNumber, format: .number)
            }
            
            Section ("Temperature in \(selectedUnitTo)") {
                Text(convertedValue, format: .number)
            }
        }
    }
}

#Preview {
    ContentView()
}
