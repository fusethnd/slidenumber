//
//  NumberViewModel.swift
//  sllidenumber
//
//  Created by Thanadon Boontawee on 4/2/2567 BE.
//

import Foundation

// class NumberViewModel {
class PuzzleViewModel : ObservableObject {
    
    static let numbers = ["", "1", "2", "3", "4",
                          "5", "6", "7", "8",
                          "9", "10", "11", "12",
                          "13", "14", "15",]
    
    @Published private var model = GameModel<String>(numberOfSlide: numbers.count) {
        index in numbers[index]
    }
    
    var puzzle: [GameModel<String>.Tile] {
        return model.puzzle
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func startNewGame() {
        model.startNewGame()
    }
    
    func shift(_ tile: GameModel<String>.Tile) {
        model.shift(tile)
    }
}
