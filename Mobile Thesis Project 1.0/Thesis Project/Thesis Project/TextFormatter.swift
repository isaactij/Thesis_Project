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
//        output = ""
        let specialWords = ["for", "less", "plus", "underscore", "to", "open", "quote", "close"]
        let singleDigitNumbers = ["one": "1"]
        let lowerCaseInput = input.lowercased()
        let dividedInput = lowerCaseInput.split(separator: " ")
        var forLoopBeingConstructed = false
//        var forLoopDefinitionSection = 1
        var wordIndex = 0
        var quoteOpened = false
        var doNotAddPostSpace = false
//        var addNewLine = false
        
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
                            output += " {"
                            wordIndex += 2
                            doNotAddPostSpace = true
                            tabCount += 1
                            addNewLine = true
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
//                            output.lastIndex(where: {$0 == "\"" && $1 == "n"})
//                            output.where
//                            let index = output.index(output.startIndex, offsetBy: output.count - 2)
                            tabCount -= 1
                            let index = output.index(output.startIndex, offsetBy: indexOfLastNewLine)
                            let newLineSubstring = output[index...]
                            if newLineSubstring.trimmingCharacters(in: .whitespaces) != "\n" {
                                addNewLine = true
                                newLineHandler(tabOnly: false)
                            }
                            else if newLineSubstring.count > 2 {
//                                let range = tabCount > 0 ? ((tabCount  * 4) - 1) : tabCount * 4
//                                for _ in 0...range {
//                                    output.removeLast()
//                                }
                                output = output.trimmingCharacters(in: .whitespaces)
                                newLineHandler(tabOnly: true)
                            }
//                            addNewLine = true
//                            newLineHandler()
                            output += "}"
                            wordIndex += 2
//                            tabCount -= 1
                            addNewLine = true
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
            newLineHandler(tabOnly: false)
//            if addNewLine {
//                output += "\n"
//                if tabCount > 0 {
//                    for _ in 1...tabCount {
//                        output += "    "
//                    }
//                }
//                addNewLine = false
//            }
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
}
