//
//  ContentView.swift
//  WordScramble
//
//  Created by Leandro Motta Junior on 04/08/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    Section {
                        TextField("Enter a word", text: $viewModel.newWord)
                            .textInputAutocapitalization(.never)
                    }
                    
                    Section {
                        ForEach(viewModel.useWords, id: \.self) {word in
                            HStack {
                                //Add a little circle with the number of letters of the typed word
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                            }
                        }
                    }
                }
                .navigationTitle(viewModel.rootWords)
                .onSubmit {
                    withAnimation {
                        viewModel.addNewWord()
                    }
                }
                .onAppear(perform: viewModel.startGame)
                .alert(viewModel.errorTitle, isPresented: $viewModel.showingError) {
                    Button("OK") { }
                } message: {
                    Text(viewModel.errorMessage)
                }
                .toolbar {
                    Button("Reset", action: viewModel.startGame)
                }
                
                VStack {
                    Text("Score: \(viewModel.score)")
                        .font(.title.bold())
                        .foregroundStyle(.blue)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
