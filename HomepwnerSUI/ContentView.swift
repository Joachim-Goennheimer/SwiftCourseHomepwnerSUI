//
//  ContentView.swift
//  HomepwnerSUI
//
//  Created by Joachim Goennheimer on 28.05.20.
//  Copyright © 2020 Joachim Goennheimer. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
//    tried to implement list with ItemStore like in wwdc videos but did not work.
//    Could not find the issue so I used the uglier solution with @State.
//    @ObservedObject var store = ItemStore()
    
    @State var isEditMode: EditMode = .inactive
    @State var allItems: [Item] = [
//        Item(name: "test", valueInDollars: 20, serialNumber: "2018"),
//        Item(name: "chair2", valueInDollars: 23, serialNumber: "2020"),
//        Item(name: "Chair", valueInDollars: 20, serialNumber: "2015"),
//        Item(name: "Table", valueInDollars: 25, serialNumber: "2016"),
//        Item(name: "Lamp", valueInDollars: 12, serialNumber: "2017")
        
        Item(name: "Table", valueInDollars: 25, valueInDollarsString: "25", serialNumber: "2016"),
        Item(name: "Lamp", valueInDollars: 12, valueInDollarsString: "12", serialNumber: "2017")
    ]
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(allItems) { item in
                        itemCellView(item: item)
                                   }
                    .onDelete(perform: onDelete)
                    .onMove(perform: onMove)
                }
                
                Section {
                    Text("No more items")
                }
                .frame(height: CGFloat(44))
        }
        .opacity(0.9)
        .background(Image("wood-591631_1280"))
        .navigationBarTitle(Text("Homepwner"))
        .listStyle(GroupedListStyle())
        .navigationBarItems(
            leading: EditButton(),
            trailing:
            Button(action: addNewItem) {
                Image.init(systemName: "plus")
            })
        }
        

        
    }
    private func addNewItem() {
        allItems.append(self.createRandomItem())
    }
    
    private func onDelete(at offsets: IndexSet) {
        allItems.remove(atOffsets: offsets)
    }
    
    private func onMove(source: IndexSet, destination: Int) {
        allItems.move(fromOffsets: source, toOffset: destination)
    }
    
    private func createRandomItem() -> Item {
        
        let adjectives = ["Fluffy", "Rusty", "Shiny"]
        let nouns = ["Bear", "Sport", "Mac"]
        
        var idx = arc4random_uniform(UInt32(adjectives.count))
        let randomAdjective = adjectives[Int(idx)]
        
        idx = arc4random_uniform(UInt32(nouns.count))
        let randomNoun = nouns[Int(idx)]
        
        let randomName = "\(randomAdjective) \(randomNoun)"
        let randomValue = Int(arc4random_uniform(100))
        let randomSerialNumber = UUID().uuidString.components(separatedBy: "-").first!
            
//        let newItem = Item(name: randomName, valueInDollars: randomValue, serialNumber: randomSerialNumber)
         let newItem = Item(name: randomName, valueInDollars: randomValue, valueInDollarsString: "\(randomValue)", serialNumber: randomSerialNumber)
        return newItem
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct itemCellView: View {
    
    @State var item: Item
    var body: some View {
        NavigationLink(destination: ItemDetailView(item: $item)) {
            HStack {
                VStack {
                    Text(item.name)
                    Text(item.serialNumber)
                        .foregroundColor(.secondary)
                }
                Text("\(item.valueInDollarsString)$")
                        .multilineTextAlignment(.trailing)
                }
            }
            .frame(height: CGFloat(60))
            .font(.system(size: 20))
    }
}
