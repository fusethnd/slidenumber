//
//  ContentView.swift
//  sllidenumber
//
//  Created by Thanadon Boontawee on 4/2/2567 BE.
//

// Problem
// * not display item that swapped
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = PuzzleViewModel()
    @State private var isGameFinished = false
    @State private var count = 0
    
    var body: some View {
        VStack { // V - Colummn, H - Row
            LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()]) {
                ForEach(viewModel.puzzle) { tile in
                        Tileview(tile)
                        .aspectRatio(1.0, contentMode: .fit)
                            .onTapGesture { // tap on screen
                                viewModel.shift(tile)
                                count += 1
                                checkGameWin()
                            }
                    }
            }
            .foregroundColor(.purple)
            Spacer()
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
        
        Text("Count: \(count)")
        
        Button("Start New Game") {
            // Handle OK button action
            viewModel.startNewGame()
            count = 0
        }.padding()
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
            let base = RoundedRectangle(cornerRadius: 12)
            
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(tile.number)
            }
        }
    }
}

#Preview {
    ContentView()
}
