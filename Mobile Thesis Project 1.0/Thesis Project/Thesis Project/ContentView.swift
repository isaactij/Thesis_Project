//
//  ContentView.swift
//  Thesis Project
//
//  Created by Isaac Tijerina on 10/22/21.
//

import SwiftUI

struct ContentView: View {
    @State private var providedText = ""
    
    var body: some View {
        VStack {
            GeometryReader{ geometry in
                TextEditor(text: $providedText)
                    .frame(height: geometry.size.height)
                    .padding([.top])
            }
            Button("Format Data") {
//                Call data formatter
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
