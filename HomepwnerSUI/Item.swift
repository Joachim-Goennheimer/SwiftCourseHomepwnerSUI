//
//  Item.swift
//  HomepwnerSUI
//
//  Created by Joachim Goennheimer on 28.05.20.
//  Copyright © 2020 Joachim Goennheimer. All rights reserved.
//

// import Foundation

import SwiftUI

struct Item: Identifiable {
    
    var id = UUID()
    var name: String
    var valueInDollars: Int
    var serialNumber: String
//    var dateCreated: Date
//    let itemKey: String
    
}

let exampleData = [
    Item(name: "test", valueInDollars: 20, serialNumber: "2018"),
    Item(name: "chair2", valueInDollars: 23, serialNumber: "2020"),
    Item(name: "Chair", valueInDollars: 20, serialNumber: "2015"),
    Item(name: "Table", valueInDollars: 25, serialNumber: "2016"),
    Item(name: "Lamp", valueInDollars: 12, serialNumber: "2017")
]



