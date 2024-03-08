//
//  ContentView.swift
//  Fruit list with second screen
//
//  Created by Vaidik Dubey
//

import SwiftUI

struct FruitModel : Identifiable {
    let id : String = UUID().uuidString
    let name : String
    let count : Int
}

class FruitViewModel : ObservableObject{
    @Published var fruitArray: [FruitModel] = []
    @Published var isLoading: Bool = false
    
    init(){
        getFruits()
    }
    
    func getFruits(){
        let fruit1 = FruitModel(name: "Orange", count: 1)
        let fruit2 = FruitModel(name: "Banana", count: 2)
        let fruit3 = FruitModel(name: "Watermelon", count: 88)
        
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            
            self.fruitArray.append(fruit1)
            
            self.fruitArray.append(fruit2)
            
            self.fruitArray.append(fruit3)
            
            self.isLoading = false
        }
    }
    func deleteFruit(index: IndexSet) {
        fruitArray.remove(atOffsets: index)
    }
    
}



struct ContentView : View {
    
    // @State var fruitArray: [FruitModel] = []
    
    //@Stateobject -> use this on creation/ init
    //@ObservedObject -> use this for subview
    
    @StateObject var fruitViewModel = FruitViewModel()
    
    
    var body: some View {
        NavigationView{
            List {
                
                if fruitViewModel.isLoading{
                    ProgressView()
                } else{
                    ForEach(fruitViewModel.fruitArray) {fruit in
                        HStack {
                            Text("\(fruit.count)")
                                .foregroundColor(.red)
                            Text(fruit.name)
                                .font(.headline)
                                .bold()
                        }
                    }
                    .onDelete(perform: fruitViewModel.deleteFruit)
                    
                    
                }
                
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Fruit List")
            .navigationBarItems(trailing :
                                    NavigationLink(
                                        destination : SecondScreen(fruitViewModal: fruitViewModel),
                                        label :{
                                            Image(systemName: "arrow.right")
                                                .font(.title)
                                            
                                        }))
            
                                    
            
            
            
        }
    }
}
    
struct SecondScreen : View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var fruitViewModal : FruitViewModel
        
    
    var body: some View{
            ZStack {
                Color.green.ignoresSafeArea()
                
                VStack{
                    ForEach(fruitViewModal.fruitArray) {fruit in
                        Text(fruit.name)
                            .bold()
                            .foregroundColor(.white)
                        
                    }
                }
                
                
            }
        }
    }
    
    
    




struct ViewModelBootcamp_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
        //SecondScreen()
    }
}
