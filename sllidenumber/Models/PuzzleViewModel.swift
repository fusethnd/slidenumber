//
//  NumberViewModel.swift
//  sllidenumber
//
//  Created by Thanadon Boontawee on 4/2/2567 BE.
//

import Foundation

// class NumberViewModel {
class Game : ObservableObject {
//    let nrows = 4
//    let ncols = 4
//    var win = false
    
//    var matrix: [[Tile]] = [[]]
    var puzzle: [Tile] = []
//    var count = 0
    
    init() {
        var tileArray: [Tile] = []
        for i in 1...15 {
            tileArray.append(Tile(id: i, number: String(i)))
        }
        
        var spaceTile = Tile(id: 0, number: "0")
        tileArray.append(spaceTile)
        
        puzzle = tileArray
        puzzle.shuffle()
    }
    
    
    
//    init() {
//        for row in 0..<nrows {
//            var matrixRow: [Tile] = []
//            for col in 0..<ncols {
//                let i = row * ncols + col
//                matrixRow.append(Tile(id: i,row: row, col: col, number: i))
//            }
//            matrix.append(matrixRow)
//        }
//        shuffle()
//    }
    

//    mutating func shuffle() {
//        let flatMatrix = matrix.flatMap { element in element }
//        let shuffledFlatMatrix = flatMatrix.shuffled()
//
//        self.matrix = stride(from: 0, to: shuffledFlatMatrix.count, by: matrix[0].count)
//            .map { index in
//                let startIndex = index
//                let endIndex = index + matrix[0].count
//                return Array(shuffledFlatMatrix[startIndex..<endIndex])
//            }
//    }
    
    func findNumberPosition(_ num: Tile) -> Int {
        // find number position
        return puzzle.firstIndex(of: num.id)
//        for index in 0..<16 {
//            if (puzzle[index].number == num.number) {
//                return index // array to store position
//            }
//        }
//        for row in 0..<nrows {
//            for col in 0..<ncols {
//                if (matrix[row][col].number == num) {
//                    return [row, col] // array to store position
//                }
//            }
//        }
//        return [-1, -1]
//        return -1

    
    func findElement(_ position: Int) -> Tile {
        return puzzle[position]
    }
    
    func choose(_ tile: Tile) {
        // find number position
        let tilePos: Int = findNumberPosition(tile) // array of space position : 0 = row, 1 = col
        
        // let number is [2,3] so around number is [1,3],[3,3],[2,2],[2,4]
        // but 2,4 is out of range
        var aroundNumber: [Int] = []
        // let aroundNumber: [Int] = [tilePos-1,tilePos+1,tilePos-4,tilePos+4]
        if (tilePos-1 > 0) {
            aroundNumber.append(tilePos-1)
        }
        if (tilePos+1 < 16) {
            aroundNumber.append(tilePos+1)
        }
        if (tilePos-4 > 0) {
            aroundNumber.append(tilePos-4)
        }
        if (tilePos+4 < 16) {
            aroundNumber.append(tilePos+4)
        }
            
        // back to fix check scope
//        var aroundNumber: [[Int]] = []
//        for _ in 0...3 {
//            // check each ele
//            if (numberPosition[0]-1 >= 0 && numberPosition[0]-1 < 4 &&
//                numberPosition[1] > 0 && numberPosition[1] < 4) {
//                aroundNumber.append([numberPosition[0]-1, numberPosition[1]])
//            }
//            if (numberPosition[0]+1 >= 0 && numberPosition[0]+1 < 4 &&
//                numberPosition[1] > 0 && numberPosition[1] < 4) {
//                aroundNumber.append([numberPosition[0]+1, numberPosition[1]])
//            }
//            if (numberPosition[0] >= 0 && numberPosition[0] < 4 &&
//                    numberPosition[1]-1 > 0 && numberPosition[1]-1 < 4) {
//                    aroundNumber.append([numberPosition[0], numberPosition[1]-1])
//            }
//            if (numberPosition[0] >= 0 && numberPosition[0] < 4 &&
//                    numberPosition[1]+1 > 0 && numberPosition[1]+1 < 4) {
//                    aroundNumber.append([numberPosition[0], numberPosition[1]+1])
//            }
//        }
        
        for pos in aroundNumber {
            if (puzzle[pos].id == 0) { //space founded
                // swap
                puzzle.swapAt(pos, tilePos)
            }
        }

    }
    
//    mutating func startNewGame() {
//        self.count = 0
//        self.win = false
//        self.shuffle()
//    }
    
    struct Tile: Identifiable {
        let id: Int
//        let row: Int
//        let col: Int
        var number: String
    }

}
