//
//  ContentView.swift
//  Simon
//
//  Created by Caden Christesen on 11/13/23.
//

import SwiftUI

struct ContentView: View {
    @State private var colorDisplay = [ColorDisplay(color: .green), ColorDisplay(color: .red), ColorDisplay(color: .yellow), ColorDisplay(color: .blue)]
    @State private var flash = [false, false, false, false]
    var body: some View {
        VStack {
            Text("Simon")
                .font(.system(size: 72))
            HStack{
                colorDisplay[0]
                    .opacity(flash[0] ? 1 : 0.4)
                colorDisplay[1]
                    .opacity(flash[1] ? 1 : 0.4)
            }
            HStack{
                colorDisplay[2]
                    .opacity(flash[2] ? 1 : 0.4)
                colorDisplay[3]
                    .opacity(flash[3] ? 1 : 0.4)
            }
            
        }
        .preferredColorScheme(.dark)
        .padding()
    }
}
struct ColorDisplay: View {
    let color: Color
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .fill(color)
            .frame(width: 100, height: 100, alignment: .center)
            .padding()
    }
}

#Preview {
    ContentView()
}
