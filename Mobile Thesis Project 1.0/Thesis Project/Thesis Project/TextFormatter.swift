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
        let specialWords = ["for", "less", "plus"]
        let singleDigitNumbers = ["one": "1"]
        let lowerCaseInput = input.lowercased()
        let dividedInput = lowerCaseInput.split(separator: " ")
        var forLoopBeingConstructed = false
        var forLoopDefinitionSection = 1
        var wordIndex = 0
        while wordIndex < dividedInput.count {
            var word = String(dividedInput[wordIndex])
            var nextWord = ""
            if(specialWords.contains(word)) {
                switch (word) {
                case "for":
                    forLoopBeingConstructed = true
                    output += "for("
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
                default:
                    break
                }
            } else if(singleDigitNumbers.keys.contains(word)) {
                output += singleDigitNumbers[word]!
                word = singleDigitNumbers[word]!
            } else {
                output += word
            }
            if(forLoopBeingConstructed) {
                let number = Int(word)
                if(number != nil) {
                    if(forLoopDefinitionSection == 3) {
                        output += ") {\n"
                    }
                    output += ";"
                    forLoopDefinitionSection += 1
                    if(forLoopDefinitionSection > 3) {
                        forLoopBeingConstructed = false
                        forLoopDefinitionSection = 1
                    }
                }
            }
            output += " "
            wordIndex += 1
        }
        return output
    }
}
