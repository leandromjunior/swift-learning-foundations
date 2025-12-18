//
//  ContentView-ViewModel.swift
//  WordScramble
//
//  Created by Leandro Motta Junior on 18/12/25.
//

import Foundation
import UIKit

extension ContentView {
     
    @Observable
    class ViewModel {
        
        var useWords = [String]()
        var rootWords = ""
        var newWord = ""
        
        var errorTitle = ""
        var errorMessage = ""
        var showingError = false
        
        var score = 0
        
        init(useWords: [String] = [String](), rootWords: String = "", newWord: String = "", errorTitle: String = "", errorMessage: String = "", showingError: Bool = false, score: Int = 0) {
            self.useWords = useWords
            self.rootWords = rootWords
            self.newWord = newWord
            self.errorTitle = errorTitle
            self.errorMessage = errorMessage
            self.showingError = showingError
            self.score = score
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
            
            useWords.insert(answer, at: 0)
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
}
