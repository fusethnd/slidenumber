//
//  ContentView.swift
//  sllidenumber
//
//  Created by Thanadon Boontawee on 4/2/2567 BE.
//

import SwiftUI

extension Color {
    init(hex: UInt) {
        self.init(
            .sRGB,
            red: Double((hex & 0xFF0000) >> 16) / 255.0,
            green: Double((hex & 0x00FF00) >> 8) / 255.0,
            blue: Double(hex & 0x0000FF) / 255.0
        )
    }
}

struct ContentView: View {
    @ObservedObject var viewModel = PuzzleViewModel()
    
    @State private var isGameFinished = false
    @State private var count = 0
    
    var body: some View {
        ZStack {
            Color(hex: 0x2B70E4)
            Circle()
                .foregroundColor(Color(hex: 0xFFFFFF)) // Set the circle color
                .frame(width: 242.8, height: 242.8) // Set the circle size
                .position(x: 55.3, y: 190.7) // Set the fixed position
            
            Circle()
                .foregroundColor(Color(hex: 0x000000))
                .frame(width: 242.8, height: 242.8)
                .position(x: 354.1, y: 733.2)
            
            RoundedRectangle(cornerRadius: 38)
                .foregroundColor(Color(hex: 0xFFD034))
                // Yellow frame
                .frame(width: 391.3, height: 550)
                .position(x: 215, y: 490)
            
            VStack {
                Text("Slide\nNumber\nGame")
                    .font(Font.custom("Barrio-Regular", size: 40))
                    .foregroundColor(Color(hex: 0x000000))
                    .multilineTextAlignment(.center)
                
                ZStack { // Game Blue Block
                    RoundedRectangle(cornerRadius: 15) // Blue frame
                        .foregroundColor(Color(hex: 0x06327D))
                        // Deep Blue
                        .frame(width: 350, height: 370)
                    
                    // Tile game
                    VStack { // V - Colummn, H - Row
                        LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()]) {
                            ForEach(viewModel.puzzle) { tile in
                                    Tileview(tile)
                                    .aspectRatio(1.0, contentMode: .fit)
                                    .gesture(
                                        DragGesture()
                                            .onEnded { value in
                                                // Respond to drag gesture completion
                                                withAnimation(.easeInOut(duration: 0.10)) {
                                                    viewModel.shift(tile)
                                                    count += 1
                                                    checkGameWin()
                                                }
                                            }
                                    )
                                }
                        }
                        .foregroundColor(Color(hex: 0x06327D))
                        .frame(width: 330, height: 330)
                        // .position(x: 198, y: 280)
                        
                        // Spacer()
                    }
                    .padding()
                    .alert(isPresented: $isGameFinished) {
                         Alert(
                            title: Text("You won!"),
                            message: Text("Congratulations! You've solved the puzzle."),
                            primaryButton: .default(Text("Start New Game")) {
                                viewModel.startNewGame()
                                count = 0
                            },
                            secondaryButton: .cancel()
                        )
                    }
                    .onAppear {
                        viewModel.startNewGame()
                    }
                } // ZStack Deep blue
                .padding()
                
                Text("Count")
                    .font(Font.custom("Dosis-SemiBold", size: 25))
                
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(Color(hex: 0x06327D)) // Deep Blue
                        .frame(width: 350, height: 67)
                    
                    Text("\(count)")
                        .font(Font.custom("Dosis-SemiBold", size: 30))
                        .foregroundColor(Color(hex: 0xFFFFFF))
                } // count block
                
                Button {
                    withAnimation {
                        viewModel.startNewGame()
                        count = 0
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .animation(.easeInOut) // Apply animation to the background color and shadow color
                            .foregroundColor(Color(hex: 0x7FC8F8)) // Deep Blue
                            .frame(width: 266.7, height: 71.1)
                            .shadow(color: Color(hex: 0x5AA9E6), radius: 0, x: 5, y: 5)
                        
                        Text("NEW GAME")
                            .font(Font.custom("Dosis-SemiBold", size: 27))
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex: 0xFFFFFF))
                            .shadow(color: Color(hex: 0x5AA9E6), radius: 0, x:2, y:2)
                    }
                }
                .padding()
            }
        }
        // Set the background color for the entire view
        .edgesIgnoringSafeArea(.all)
    }
    
    private func checkGameWin() {
        if viewModel.isGameWin() {
            isGameFinished = true
        }
    }
}

struct Tileview: View {
    var tile: GameModel<String>.Tile

    init(_ tile: GameModel<String>.Tile) {
        self.tile = tile
    }
    
    var body: some View {
        ZStack {
            if !tile.isSpace {
                let base = RoundedRectangle(cornerRadius: 12)
                
                Group {
                    base.foregroundColor(.white)
                    Text(tile.number)
                        .font(Font.custom("Dosis-SemiBold", size: 20))
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
