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
    @ObservedObject var viewModel = NumberViewModel()
    // @State var showResult = false
    let numbers = 0...15
    
    var body: some View {
        VStack { // V - Colummn, H - Row
            LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()]) {
                ForEach(viewModel.puzzle) { tile in
                    Numberview(tile)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture { // tap on screen
                            viewModel.choose(tile)
                        }
                }
            }
//                ForEach(viewModel.matrix.indices) { row in
//                    ForEach(viewModel.matrix) { col in
//                        let number = col.number // viewModel.matrix[row][col]
//                        Numberview(number: number, onTap: { tappedNum in
//                            self.viewModel.choose(tappedNum)
//                        })
//                        .aspectRatio(1.0, contentMode: .fit)
//                        
//                    }
//                }
            
                
//                ForEach(viewModel.matrix) { tile in
//                    Numberview(number: tile, onTap: { tappedNum in
//                        self.viewModel.choose(tile: tappedNum)
//                    })
//                }
                
                
                // .aspectRatio(2/3, contentMode: .fit)
//                .onTapGesture { // tap on screen
//                        onTap(tile)
//                }
            
            
            //                ForEach(numbers) { number in viewModel.numbers
            //                            .aspectRatio(2/3, contentMode: .fit)
            //                            .onTapGesture { // tap on screen
            //                                viewModel.choose(number)
            //                            }
            //                    }
            .foregroundColor(.purple)
            Spacer()
        }
    }
}

struct Numberview: View {
    var number: NumberViewModel.Tile

    init(_ num: NumberViewModel.Tile) {
        self.number = num
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text("\(number.number)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
