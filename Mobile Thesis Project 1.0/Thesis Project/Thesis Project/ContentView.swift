//
//  ContentView.swift
//  Thesis Project
//
//  Created by Isaac Tijerina on 10/22/21.
//

import SwiftUI

struct ContentView: View {
        @State private var providedText = ""
    //    @State private var providedText = "For underscore in 0 to 1 open curly brace print open parenthesis quote hello world quote close parenthesis For underscore in 0 to 1 open curly brace print open parenthesis quote hello world quote close parenthesis For underscore in 0 to 1 open curly brace print open parenthesis quote hello world quote close parenthesis For underscore in 0 to 1 open curly brace print open parenthesis quote hello world quote close parenthesis close curly brace close curly brace close curly brace close curly brace if true open curly brace x plus equals two close curly brace"
//    @State private var providedText = "let variable equal 0 let boolean equal false let lower case input equal input dot lowercased open parenthesis close parenthesis let divided input equal lower case input dot split open parenthesis spearator colon quote space quote close parenthesis var word Index equal zero while word index less than divided input dot count open curly brace var word equal string open parenthesis divided input open bracket word index close bracket close parenthesis var next word equal quote space quote if special words dot contains open parenthesis word close parenthesis open curly brace switch open parenthesis word close parenthesis open curly brace case quote woah quote colon remove last character open parenthesis close parenthesis close curly brace close curly brace close curly brace"
    @State private var formattedText = ""
    
    init() {
        // Allows background color set on the VStacks with TextEditor fields to fill in the background of the TextEditor fields as well
        UITextView.appearance().backgroundColor = .clear
        // Sets the cursor in TextEditor fields to be black
        UITextView.appearance().tintColor = UIColor.black
    }
    
    var body: some View {
        VStack {
            inputView
            outputView
            HStack {
                Button("Format Text") {
                    let formatController = TextFormatter()
                    formattedText = formatController.formatText(input: providedText)
                }
                Spacer()
                Button("Clear Text") {
                    providedText = ""
                    formattedText = ""
                }
            }
        }
    }
    
    var inputView: some View {
        VStack{
            Text("Please enter your code here:")
            TextEditor(text: $providedText)
                .frame(maxWidth: .infinity)
        }
        .background(Color.blue)
        .cornerRadius(15)
    }
    
    var outputView: some View {
        VStack{
            Text("Formatted Text:")
            ScrollView{
                Text(formattedText)
                    .lineLimit(nil)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading, .bottom], 5)
            }
        }
        .background(Color.green)
        .cornerRadius(15)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
