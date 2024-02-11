//
//  Puzzle.swift
//  sllidenumber
//
//  Created by Thanadon Boontawee on 8/2/2567 BE.
//

import Foundation

struct GameModel<TileContentType> {
    private(set) var puzzle: Array<Tile>
    let standard: Array<Tile>
    let spaceTile: Tile
    var isWin = false
    
    
    init(numberOfSlide: Int, tileNumberFactory: (Int) -> TileContentType) {
        var tileArray: [Tile] = []
        for i in 0...15 {
            let number = tileNumberFactory(i)
            tileArray.append(Tile(number: number))
        }
        
        spaceTile = tileArray[15]
        
        standard = tileArray
        puzzle = tileArray
        shuffle()
    }
    
    mutating func shift(_ tile: Tile) { // _ mean dont have to write name when use this function
        let shiftedIndex = index(of: tile)
        var aroundTileIndex: [Int] = []

        if (shiftedIndex-1 >= 0) {
            aroundTileIndex.append(shiftedIndex-1)
        }
        if (shiftedIndex+1 < 16) {
            aroundTileIndex.append(shiftedIndex+1)
        }
        if (shiftedIndex-4 >= 0) {
            aroundTileIndex.append(shiftedIndex-4)
        }
        if (shiftedIndex+4 < 16) {
            aroundTileIndex.append(shiftedIndex+4)
        }
        
        for index in aroundTileIndex {
            if puzzle[index].id == spaceTile.id {
                if swapable(index1: shiftedIndex, index2: index) {
                    // swap position
                    puzzle.swapAt(shiftedIndex, index)
                    // count += 1
                }
            }
        }
    }
    
    private func checkWin(of puzzleNow: Array<Tile>) -> Bool {
        for index in puzzleNow.indices {
            if (puzzleNow[index].id != standard[index].id) {
                return false
            }
        }
        return true
    }
    
//    private mutating func isGameWin() {
//        if checkWin(of: puzzle) {
//            isWin = true
//        } else {
//            isWin = false
//        }
//    }
    
    
    private func swapable(index1: Int, index2: Int) -> Bool {
        let row1 = index1 / 4
        let col1 = index1 % 4
        let row2 = index2 / 4
        let col2 = index2 % 4

        // Check if the tiles are in the same row and adjacent columns, or in the same column and adjacent rows
        return (row1 == row2 && abs(col1 - col2) == 1) || (col1 == col2 && abs(row1 - row2) == 1)
    }
    
    private func index(of tile: Tile) -> Int {
        for index in puzzle.indices {
            if puzzle[index].id == tile.id {
                return index
            }
        }
        return 0
    }
    
    mutating func isGameWin() -> Bool {
        return checkWin(of: puzzle)
    }
    
//    mutating func getCount() -> Int {
//        return count
//    }
    
    mutating func shuffle() {
        puzzle.shuffle()
    }
    
    mutating func startNewGame() {
        // correct = false
        // count = 0
        shuffle()
    }
    
    struct Tile: Identifiable {
        let id = UUID()
        var number: TileContentType
    }
    
}
