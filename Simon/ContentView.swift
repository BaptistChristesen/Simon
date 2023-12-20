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
    @State private var CorrectHits = 0
    @State private var round = 0
    @State private var active = false
    @State private var message = "Good Luck"
    var body: some View {
        VStack {
            Text("Simon")
                .font(Font.custom("Verdana Bold", size: 36))
            
            Button("Start") {
                // Reset game state and start a new round
                message = "Good Luck"
                sequence = [Int.random(in: 0...3)]
                CorrectHits = 0
                round = 1
                active = false
                startRound()
            }
            .font(Font.custom("Verdana Bold", size: 24))
            Text(message)
                .font(Font.custom("Verdana Bold", size: 36))
                .disabled(isPlayingSequence)
            // Display the color buttons and take user input
            HStack {
                colorDisplay[0]
                    .opacity(flash[0] ? 1 : 0.4)
                    .onTapGesture {
                        flashColorDisplay(index: 0)
                        processUserInput(0)
                    }
                colorDisplay[1]
                    .opacity(flash[1] ? 1 : 0.4)
                    .onTapGesture {
                        flashColorDisplay(index: 1)
                        processUserInput(1)
                    }
            }
            
            HStack {
                colorDisplay[2]
                    .opacity(flash[2] ? 1 : 0.4)
                    .onTapGesture {
                        flashColorDisplay(index: 2)
                        processUserInput(2)
                    }
                colorDisplay[3]
                    .opacity(flash[3] ? 1 : 0.4)
                    .onTapGesture {
                        flashColorDisplay(index: 3)
                        processUserInput(3)
                    }
            }
            .preferredColorScheme(.dark)
        }
    }
    // Toggle flash animation for a color
    func flashColorDisplay(index: Int) {
        flash[index].toggle()
        withAnimation(.easeInOut(duration: 0.5)) {
            flash[index].toggle()
        }
    }
    // Recursively flash colors in the sequence
    func flashSequence(index: Int) {
        if index < sequence.count {
            flashColorDisplay(index: sequence[index])
            let nextIndex = index + 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.flashSequence(index: nextIndex)
            }
        } else {
            active = true
        }
    }
    // Initiate the flashing sequence animation
    func startRound() {
        active = false
        CorrectHits = 0
        flashSequence(index: 0)
    }
    // Add a new random color to the sequence and initiate flashing
    func addToSequence() {
        sequence.append(Int.random(in: 0...3))
        startRound()
    }
    // Process user input and check against the current sequence
    func processUserInput(_ input: Int) {
        if active {
            if input == sequence[CorrectHits] {
                
                // Correct input, check if the user completed the sequence
                
                CorrectHits += 1
                if CorrectHits == sequence.count {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        round += 1
                        addToSequence()
                    }
                }
            } else {
                // Incorrect input, end the game
                message = "You Lost - Click Start to Restart"
            }
        }
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
