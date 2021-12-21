//
//  ContentView.swift
//  Thesis Project
//
//  Created by Isaac Tijerina on 10/22/21.
//

import SwiftUI

struct ContentView: View {
//    @State private var providedText = ""
    @State private var providedText = "For underscore in 0 to 1 open curly brace print open parenthesis quote hello world quote close parenthesis close curly brace"
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
            Button("Format Data") {
                let formatController = TextFormatter()
                formattedText = formatController.formatText(input: providedText)
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
