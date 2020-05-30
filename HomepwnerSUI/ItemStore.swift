//
//  ItemStore.swift
//  HomepwnerSUI
//
//  Created by Joachim Goennheimer on 28.05.20.
//  Copyright © 2020 Joachim Goennheimer. All rights reserved.
//

// import Foundation

import SwiftUI
import Combine

class ItemStore: ObservableObject {
    var allItems: [Item] {
        didSet {
            didChange.send()
        }
    }
    
    init(allItems: [Item] = []) {
        self.allItems = allItems
    }
    
    var didChange = PassthroughSubject<Void, Never>()
    
    
//    func createRandomItem() -> Item {
//
//        let adjectives = ["Fluffy", "Rusty", "Shiny"]
//        let nouns = ["Bear", "Sport", "Mac"]
//
//        var idx = arc4random_uniform(UInt32(adjectives.count))
//        let randomAdjective = adjectives[Int(idx)]
//
//        idx = arc4random_uniform(UInt32(nouns.count))
//        let randomNoun = nouns[Int(idx)]
//
//        let randomName = "\(randomAdjective) \(randomNoun)"
//        let randomValue = Int(arc4random_uniform(100))
//        let randomSerialNumber = UUID().uuidString.components(separatedBy: "-").first!
//
////        let newItem = Item(name: randomName, valueInDollars: randomValue, serialNumber: randomSerialNumber)
//        let newItem = Item(name: randomName, valueInDollars: randomValue, valueInDollarsString: "20" serialNumber: randomSerialNumber)
//
//        allItems.append(newItem)
//        return newItem
//    }
    
//    func removeItem(_ item: Item) {
//            if let index = allItems.firstIndex(of: item) {
//                allItems.remove(at: index)
//            }
//        }
        
        func moveItem(from fromIndex: Int, to toIndex: Int) {
            
            if fromIndex == toIndex {
                return
            }
    //            check is necessary because No more items is implemented as additional row. Otherwise app might crash
    //            Note: not necessary anymore after completing gold challenge.
            else if (toIndex >= allItems.count || fromIndex >= allItems.count) {
                return
            }
            else {

                let movedItem = allItems[fromIndex]
                allItems.remove(at: fromIndex)
                allItems.insert(movedItem, at: toIndex)
            }
            
        }
    
    
}
