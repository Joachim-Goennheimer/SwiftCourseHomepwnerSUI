//
//  ContentView.swift
//  HomepwnerSUI
//
//  Created by Joachim Goennheimer on 28.05.20.
//  Copyright © 2020 Joachim Goennheimer. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var items: [Item] = []
    
    var body: some View {
        NavigationView {
            List(items) { item in
                itemCellView(item: item)
        }
        .navigationBarTitle(Text("Homepwner"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(items: exampleData)
    }
}

struct itemCellView: View {
    
    var item: Item
    var body: some View {
        NavigationLink(destination: Text(item.name)) {
            VStack {
                Text(item.name)
                Text(item.serialNumber)
                    .foregroundColor(.secondary)
            }
            Text("\(item.valueInDollars)$")
                .multilineTextAlignment(.trailing)
        }
    }
}
