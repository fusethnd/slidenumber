//
//  sllidenumberApp.swift
//  sllidenumber
//
//  Created by Thanadon Boontawee on 4/2/2567 BE.
//

import SwiftUI

@main
struct sllidenumberApp: App {
    init() {
        printFonts()
    }
    
    func printFonts(){
        let fontFamilyNames = UIFont.familyNames
        
        for familyName in fontFamilyNames {
            print("----------")
            print("Font Family name -> [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName)
            print("Font names ==> [\(names)]")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
