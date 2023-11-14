//
//  ContentView.swift
//  Simon
//
//  Created by Caden Christesen on 11/13/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Simon")
                .font(.system(size: 72))
            
        }
        .preferredColorScheme(.dark)
        .padding()
    }
}

#Preview {
    ContentView()
}
