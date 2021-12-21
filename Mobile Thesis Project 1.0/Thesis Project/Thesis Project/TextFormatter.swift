//
//  TextFormatter.swift
//  Thesis Project
//
//  Created by Isaac Tijerina on 10/26/21.
//

import Foundation
import SwiftUI
import Combine

class TextFormatter {
    
    func formatText(input: String) -> String{
        var output = ""
        let specialWords = ["for", "less", "plus", "underscore", "to", "open", "quote", "close"]
        let singleDigitNumbers = ["one": "1"]
        let lowerCaseInput = input.lowercased()
        let dividedInput = lowerCaseInput.split(separator: " ")
        var forLoopBeingConstructed = false
//        var forLoopDefinitionSection = 1
        var wordIndex = 0
        var quoteOpened = false
        var doNotAddPostSpace = false
        
        while wordIndex < dividedInput.count {
            var word = String(dividedInput[wordIndex])
            var nextWord = ""
            if(specialWords.contains(word)) {
                switch (word) {
                case "for":
                    forLoopBeingConstructed = true
                    output += "for"
                case "less":
                    nextWord = String(dividedInput[wordIndex + 1])
                    if(nextWord == "than") {
                        output += "<"
                        wordIndex += 1
                    }
                case "plus":
                    nextWord = String(dividedInput[wordIndex + 1])
                    if(nextWord == "plus") {
                        output.removeLast()
                        output += "++"
                        wordIndex += 1
                    }
                case "underscore":
                    output += "_"
                case "to":
                    if(forLoopBeingConstructed) {
                        output += "..."
                    }
//                case "print":
//                    output += "print("
                case "open":
                    nextWord = String(dividedInput[wordIndex + 1])
                    switch (nextWord) {
                    case "curly":
                        nextWord = String(dividedInput[wordIndex + 2])
                        if(nextWord == "brace") {
                            output.removeLast()
                            output += " {\n"
                            wordIndex += 2
                        }
                    case "parenthesis":
                        output.removeLast()
                        output += "("
                        wordIndex += 1
                    default:
                        break
                    }
                case "close":
                    nextWord = String(dividedInput[wordIndex + 1])
                    switch (nextWord) {
                    case "curly":
                        nextWord = String(dividedInput[wordIndex + 2])
                        if(nextWord == "brace") {
                            output.removeLast()
                            output += "\n}\n"
                            wordIndex += 2
                        }
                    case "parenthesis":
                        output.removeLast()
                        output += ")"
                        wordIndex += 1
                    default:
                        break
                    }
                case "quote":
                    if quoteOpened {
                        output.removeLast()
                    } else {
                        doNotAddPostSpace = true
                    }
                    output += "\""
                    quoteOpened = !quoteOpened
                default:
                    break
                }
            } else if(singleDigitNumbers.keys.contains(word)) {
                output += singleDigitNumbers[word]!
                word = singleDigitNumbers[word]!
            } else {
                output += word
            }
//            if(forLoopBeingConstructed) {
//                let number = Int(word)
//                if(number != nil) {
//                    if(forLoopDefinitionSection == 2) {
//                        output += " {\n"
//                    }
//                    forLoopDefinitionSection += 1
//                    if(forLoopDefinitionSection > 2) {
//                        forLoopBeingConstructed = false
//                        forLoopDefinitionSection = 1
//                    }
//                }
//            }
            if !doNotAddPostSpace {
                output += " "
            } else {
                doNotAddPostSpace = false
            }
            wordIndex += 1
        }
        return output
    }
}
