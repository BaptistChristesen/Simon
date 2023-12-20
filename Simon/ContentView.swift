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
    @State private var sequence: [Int] = []
    @State private var index: Int = 0
    @State private var timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    @State private var isPlayingSequence = false
    @State private var userInput: [Int] = []
    var body: some View {
        VStack {
            Text("Simon")
                .font(Font.custom("Verdana Bold", size: 36))
            Button("Start") {
                startGame()
            }
            .font(Font.custom("Verdana Bold", size: 24))
            .disabled(isPlayingSequence)
            HStack {
                colorDisplay[0]
                    .opacity(flash[0] ? 1 : 0.4)
                    .onTapGesture {
                        flashColorDisplay(index: 0)
                        processUserInput(index: 0)
                    }
                colorDisplay[1]
                    .opacity(flash[1] ? 1 : 0.4)
                    .onTapGesture {
                        flashColorDisplay(index: 1)
                        processUserInput(index: 1)
                    }
            }
            
            HStack {
                colorDisplay[2]
                    .opacity(flash[2] ? 1 : 0.4)
                    .onTapGesture {
                        flashColorDisplay(index: 2)
                        processUserInput(index: 2)
                    }
                colorDisplay[3]
                    .opacity(flash[3] ? 1 : 0.4)
                    .onTapGesture {
                        flashColorDisplay(index: 3)
                        processUserInput(index: 3)
                    }
            }
            .preferredColorScheme(.dark)
        }
        .onReceive(timer) { _ in
            if isPlayingSequence {
                if index < sequence.count {
                    flashColorDisplay(index: sequence[index])
                    index += 1
                } else {
                    index = 0
                    sequence.append(Int.random(in: 0...3))
                    isPlayingSequence = false
                    userInput = []
                }
            }
        }
    }
    func processUserInput(index: Int) {
        userInput.append(index)
        if userInput == sequence {
            if userInput.count == sequence.count {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    startGame()
                }
            }
        } else {
            print("Game Over")
        }
    }
    func flashColorDisplay(index: Int) {
        flash[index].toggle()
        withAnimation(.easeInOut(duration: 0.5)) {
            flash[index].toggle()
        }
    }
    func startGame() {
        index = 0
        sequence = [Int.random(in: 0...3)]
        isPlayingSequence = true
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
