//
//  ContentView.swift
//  WordScramble
//
//  Created by Leandro Motta Junior on 04/08/25.
//

import SwiftUI

// Day 29
struct ContentView: View {
    var body: some View {
        List {
            Section("Section 1") {
                Text("Static Row 1")
                Text("Static Row 2")
            }
            
            Section("Section 2") {
                ForEach(0..<5) {
                    Text("Dynamic row \($0)")
                }
            }
            
            Section("Section 3") {
                Text("Static Row 3")
                Text("Static Row 4")
            }
        }
        .listStyle(.grouped)
        
        List(0..<5) {
            Text("Dynamic Row \($0)")
        }
    }
}

struct ListArrayView: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]
    var body: some View {
        List(people, id: \.self) {
            Text($0)
        }
        
        List {
            Text("Static Row")
            
            ForEach(people, id: \.self) {
                Text($0)
            }
            
            Text("Static Row")
        }
    }
}

struct WorkingWithBundleView: View {
    var body: some View {
        if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
            if let fileContents = try? String(contentsOf: fileURL) {
                // We loaded the file into a string
            }
        }
    }
}

struct WorkingWithStrings: View {
    let input = "a b c"
    lazy var letters = input.components(separatedBy: " ")
    
    let input2 = """
                a
                b
                c
                """
    lazy var letters2 = input2.components(separatedBy: "\n")
    lazy var letter = letters.randomElement()
    lazy var trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
    
    let word = "swift"
    let checker = UITextChecker()
    lazy var range = NSRange(location: 0, length: word.utf16.count)
    lazy var misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
    lazy var allGood = misspelledRange.location == NSNotFound
    
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}

//Day 30

struct WordScramble: View {
    @State private var useWords = [String]()
    @State private var rootWords = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter a word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    ForEach(useWords, id: \.self) {word in
                        HStack {
                            //Add a little circle with the number of letters of the typed word
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWords)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK") { }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    func addNewWord() {
        // lowercase and trim(removing spaces) the word to make sure we don't add duplicates words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // exit if the remaining string is empty
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already!", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell this word from \(rootWords)")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know")
            return
        }
        
        withAnimation {
            useWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    func startGame() {
        // Find the url for start.txt in app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            //Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                // Split the string up into an array of strings, splitting on line breaks
                let allWords = startWords.components(separatedBy: "\n")
                // Pick one random word, or use "silkworm" as a sensible default
                rootWords = allWords.randomElement() ?? "silkworm"
                // If we are here everything has worked, so we can exit
                return
            }
        }
        // If were are *here* then there was a problem – trigger a crash and report the error
        fatalError("Could not load start.txt from Bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !useWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWords
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

/* Day 31 - Challenge
 1 - Disallow answers that are shorter than three letters or are just our start word.
 2 - Add a toolbar button that calls startGame(), so users can restart with a new word whenever they want to.
 3 - Put a text view somewhere so you can track and show the player’s score for a given root word. How you calculate score is down to you, but something involving number of words and their letter count would be reasonable.
 */
struct WordScrambleChallengeView: View {
    @State private var useWords = [String]()
    @State private var rootWords = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    Section {
                        TextField("Enter a word", text: $newWord)
                            .textInputAutocapitalization(.never)
                    }
                    
                    Section {
                        ForEach(useWords, id: \.self) {word in
                            HStack {
                                //Add a little circle with the number of letters of the typed word
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                            }
                        }
                    }
                }
                .navigationTitle(rootWords)
                .onSubmit(addNewWord)
                .onAppear(perform: startGame)
                .alert(errorTitle, isPresented: $showingError) {
                    Button("OK") { }
                } message: {
                    Text(errorMessage)
                }
                .toolbar {
                    Button("Reset", action: startGame)
                }
                
                VStack {
                    Text("Score: \(score)")
                        .font(.title.bold())
                        .foregroundStyle(.blue)
                }
            }
        }
    }
    
    func addNewWord() {
        // lowercase and trim(removing spaces) the word to make sure we don't add duplicates words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        var numWord: Int
        
        // exit if the remaining string is empty
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already!", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell this word from \(rootWords)")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know")
            return
        }
        
        guard isBigEnough(word: answer) else {
            wordError(title: "Invalid word", message: "Try another bigger word or any different from the start word")
            return
        }
        
        withAnimation {
            useWords.insert(answer, at: 0)
        }
        newWord = ""
        
        numWord = useWords.count
        score += answer.count
        
        if numWord == 2 {
            score += 20
            numWord = 0
        }
        
    }
    
    func startGame() {
        score = 0
        // Find the url for start.txt in app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            //Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                // Split the string up into an array of strings, splitting on line breaks
                let allWords = startWords.components(separatedBy: "\n")
                // Pick one random word, or use "silkworm" as a sensible default
                rootWords = allWords.randomElement() ?? "silkworm"
                // If we are here everything has worked, so we can exit
                return
            }
        }
        // If were are *here* then there was a problem – trigger a crash and report the error
        fatalError("Could not load start.txt from Bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !useWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWords
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func isBigEnough(word: String) -> Bool {
        
        if word.count < 3 || word == rootWords {
            return false
        }
        
        return true
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct AccessibilityChangesView: View {
    @State private var useWords = [String]()
    @State private var rootWords = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    Section {
                        TextField("Enter a word", text: $newWord)
                            .textInputAutocapitalization(.never)
                    }
                    
                    Section {
                        ForEach(useWords, id: \.self) {word in
                            HStack {
                                //Add a little circle with the number of letters of the typed word
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                            }
                            .accessibilityElement()
                            .accessibilityLabel("\(word), \(word.count) letters")
                        }
                    }
                }
                .navigationTitle(rootWords)
                .onSubmit(addNewWord)
                .onAppear(perform: startGame)
                .alert(errorTitle, isPresented: $showingError) {
                    Button("OK") { }
                } message: {
                    Text(errorMessage)
                }
                .toolbar {
                    Button("Reset", action: startGame)
                }
                
                VStack {
                    Text("Score: \(score)")
                        .font(.title.bold())
                        .foregroundStyle(.blue)
                }
            }
        }
    }
    
    func addNewWord() {
        // lowercase and trim(removing spaces) the word to make sure we don't add duplicates words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        var numWord: Int
        
        // exit if the remaining string is empty
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already!", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell this word from \(rootWords)")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know")
            return
        }
        
        guard isBigEnough(word: answer) else {
            wordError(title: "Invalid word", message: "Try another bigger word or any different from the start word")
            return
        }
        
        withAnimation {
            useWords.insert(answer, at: 0)
        }
        newWord = ""
        
        numWord = useWords.count
        score += answer.count
        
        if numWord == 2 {
            score += 20
            numWord = 0
        }
        
    }
    
    func startGame() {
        score = 0
        // Find the url for start.txt in app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            //Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                // Split the string up into an array of strings, splitting on line breaks
                let allWords = startWords.components(separatedBy: "\n")
                // Pick one random word, or use "silkworm" as a sensible default
                rootWords = allWords.randomElement() ?? "silkworm"
                // If we are here everything has worked, so we can exit
                return
            }
        }
        // If were are *here* then there was a problem – trigger a crash and report the error
        fatalError("Could not load start.txt from Bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !useWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWords
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func isBigEnough(word: String) -> Bool {
        
        if word.count < 3 || word == rootWords {
            return false
        }
        
        return true
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

#Preview {
    //WordScrambleChallengeView()
    AccessibilityChangesView()
}
