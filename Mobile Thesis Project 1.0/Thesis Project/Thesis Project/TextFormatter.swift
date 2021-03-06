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
    
    private var output = ""
    private var addNewLine = false
    private var tabCount = 0
    private var indexOfLastNewLine = -1
    
    func formatText(input: String) -> String{
        let specialWords = ["for", "less", "plus", "underscore", "to", "open", "quote", "close", "equal", "let", "dot", "colon", "space", "var", "while", "if"]
        let singleDigitNumbers = ["one": "1", "two": "2", "three": "3", "four": "4", "five": "5", "six": "6", "seven": "7", "eight": "8", "nine": "9", "zero": "0"]
        let lowerCaseInput = input.lowercased()
        let dividedInput = lowerCaseInput.split(separator: " ")
        var forLoopBeingConstructed = false
        var wordIndex = 0
        var quoteOpened = false
        var doNotAddPostSpace = false
        
        while wordIndex < dividedInput.count {
            var word = String(dividedInput[wordIndex])
            var nextWord = ""
            if specialWords.contains(word) {
                switch (word) {
                case "for":
                    removeLastCharacter()
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
                    if(nextWord == "equals") {
                        output += "+="
                        wordIndex += 1
                    }
                case "underscore":
                    output += "_"
                case "to":
                    if(forLoopBeingConstructed) {
                        output += "..."
                    }
                case "open":
                    nextWord = String(dividedInput[wordIndex + 1])
                    switch (nextWord) {
                    case "curly":
                        nextWord = String(dividedInput[wordIndex + 2])
                        if(nextWord == "brace") {
                            removeLastCharacter()
                            output += " {"
                            wordIndex += 2
                            doNotAddPostSpace = true
                            tabCount += 1
                            addNewLine = true
                        }
                    case "parenthesis":
                        removeLastCharacter()
                        output += "("
                        wordIndex += 1
                    case "bracket":
                        removeLastCharacter()
                        output += " ["
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
                            removeLastCharacter()
                            tabCount -= 1
                            let index = output.index(output.startIndex, offsetBy: indexOfLastNewLine)
                            let newLineSubstring = output[index...]
                            if newLineSubstring.trimmingCharacters(in: .whitespaces) != "\n" {
                                addNewLine = true
                                newLineHandler(tabOnly: false)
                            }
                            else if newLineSubstring.count > 2 {
                                output = output.trimmingCharacters(in: .whitespaces)
                                newLineHandler(tabOnly: true)
                            }
                            output += "}"
                            wordIndex += 2
                            addNewLine = true
                        }
                    case "parenthesis":
                        removeLastCharacter()
                        output += " )"
                        wordIndex += 1
                    case "bracket":
                        output += "]"
                        wordIndex += 1
                    default:
                        break
                    }
                case "quote":
                    if quoteOpened {
                        removeLastCharacter()
                    } else {
                        doNotAddPostSpace = true
                    }
                    output += "\""
                    quoteOpened = !quoteOpened
                case "equal":
                    output += "="
                case "let":
                    removeLastCharacter()
                    addNewLine = true
                    newLineHandler(tabOnly: false)
                    output += "let"
                case "var":
                    removeLastCharacter()
                    addNewLine = true
                    newLineHandler(tabOnly: false)
                    output += "var"
                case "dot":
                    removeLastCharacter()
                    output += "."
                    doNotAddPostSpace = true
                case "colon":
                    removeLastCharacter()
                    output += ":"
                case "space":
                    output += " "
                case "while":
                    removeLastCharacter()
                    addNewLine = true
                    newLineHandler(tabOnly: false)
                    output += "while"
                case "if":
                    removeLastCharacter()
                    addNewLine = true
                    newLineHandler(tabOnly: false)
                    output += "if"
                default:
                    break
                }
            } else if(singleDigitNumbers.keys.contains(word)) {
                output += singleDigitNumbers[word]!
                word = singleDigitNumbers[word]!
            } else {
                output += word
            }
            if !doNotAddPostSpace {
                output += " "
            } else {
                doNotAddPostSpace = false
            }
            newLineHandler(tabOnly: false)
            wordIndex += 1
        }
        return output
    }
    
    func newLineHandler(tabOnly: Bool) {
        if addNewLine && !tabOnly {
            indexOfLastNewLine = output.count
            output += "\n"
        }
        if tabOnly || addNewLine {
            if tabCount > 0 {
                for _ in 1...tabCount {
                    output += "    "
                }
            }
        }
        addNewLine = false
    }
    
    func removeLastCharacter(){
        if output.count > 0 {
            output.removeLast()
        }
    }
}
