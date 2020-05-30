//
//  ItemDetailView.swift
//  HomepwnerSUI
//
//  Created by Joachim Goennheimer on 28.05.20.
//  Copyright © 2020 Joachim Goennheimer. All rights reserved.
//

import SwiftUI
import Combine

struct ItemDetailView: View {
    
    @Binding var item: Item
    @State var nameField: String = ""
    @State var serialNumberField: String = ""
    @State var valueFieldString: String = ""
    @State var isShowingImagePicker = false
    @State var itemImage = UIImage()
    
    var body: some View {
        
        VStack(spacing: 50) {
            VStack {
                HStack {
                    Text("Name")
                    TextField(self.item.name, text: self.$item.name)
                }
                HStack {
                    Text("Serial")
                    TextField(self.item.serialNumber, text: self.$item.serialNumber)
                }
                HStack {
                    Text("Value")
//                    Does not work like intended. Could not figure out how to update valueInDollars integer value.
//                    Used string value as workaround. Have no idea why it works with String but not with integer,      probably a bug in Swift.
//                    Works with string but cannot filter input before updating string.
                    TextField(self.item.valueInDollarsString, text: self.$item.valueInDollarsString)
                        .keyboardType(.numberPad)
                        .onReceive(Just(valueFieldString)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                self.updateValueInDollars(valueString: filtered)
                            }
                    }
                }
            }
            .font(.system(size: 20))
            Text("Date Created: \(self.item.getDateCreatedString())")
            Image(uiImage: itemImage)
            .resizable()
            .scaledToFill()
                .frame(width: 350, height: 350)
                .clipped()
            Button(action: {
                self.isShowingImagePicker.toggle()
            }) {Image.init(systemName: "camera")
                .resizable()
                .scaledToFill()
            .frame(width: 50, height: 50)
            }
            .sheet(isPresented: $isShowingImagePicker, content: {
                ImagePickerView(isPresented: self.$isShowingImagePicker, selectedImage: self.$itemImage)
            })
            
//                loading image from Item if possible.
                .onAppear() {
                self.itemImage = self.item.image
            }
//            laving image in Item.
            .onDisappear() {
                self.item.image = self.itemImage
            }
        }
    }
    
//    followed a tutorial for this.
    struct ImagePickerView: UIViewControllerRepresentable {
        
        @Binding var isPresented: Bool
        @Binding var selectedImage: UIImage
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ItemDetailView.ImagePickerView>) -> UIViewController {
            let controller = UIImagePickerController()
            controller.delegate = context.coordinator
            return controller
        }
        
        func makeCoordinator() -> ItemDetailView.ImagePickerView.Coordinator {
            return Coordinator(parent: self)
        }
        
        class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
            
            let parent: ImagePickerView
            init(parent: ImagePickerView) {
                self.parent = parent
            }
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:
                [UIImagePickerController.InfoKey: Any]) {
                if let selectedImageFromPicker = info[.originalImage] as? UIImage {
                    print(selectedImageFromPicker)
                    self.parent.selectedImage = selectedImageFromPicker

                }
                self.parent.isPresented = false
            }
        }
        
        func updateUIViewController(_ uiViewController: ItemDetailView.ImagePickerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ItemDetailView.ImagePickerView>) {
            
        }
    }
    
    
//    function is apparently not called. Just here for reference of what was originally tried.
    func updateValueInDollars(valueString: String) {
        self.item.valueInDollars = Int(valueString)!
        print(self.item.valueInDollars)
        self.item.valueInDollarsString = valueString
    }
    
    
}

//struct ItemDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemDetailView(item: Item(name: "Table", valueInDollars: 25, valueInDollarsString: "25", serialNumber: "2016"))
////        NavigationView { ItemDetailView(item: exampleData[0]) }
//
//    }
//}

