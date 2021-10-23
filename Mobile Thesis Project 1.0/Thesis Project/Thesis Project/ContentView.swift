//
//  ContentView.swift
//  Thesis Project
//
//  Created by Isaac Tijerina on 10/22/21.
//

import SwiftUI

struct ContentView: View {
    @State private var providedText = ""
    @State private var formattedText = ""
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack {
            inputView
            outputView
            Button("Format Data") {
                formattedText = providedText
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
