//
//  ContentView.swift
//  CalorieTracker
//
//  Created by Tony Tang on 8/5/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ViewModel
    
    @State var calories: Double = 0.5
    @State var protein: Double = 0.5
    @State var fat: Double = 0.5
    @State var carbohydrates: Double = 0.5
    @State var selectedFood = Food()
    
    init(_ database : Database = .db ) {
        let viewModel = ViewModel(foodDatabase: FoodList(.db))
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack{
            VStack{
                Text("Tracker")
                    .font(.system(size: 30))
                HStack{
                    CircularProgressView(progress: calories, color: .blue, value: 200/400)
                        .frame(width: 150, height: 150)
                        .padding(20)
                    VStack{
                        CircularProgressView(progress: protein, color: .red, value: 15)
                            .frame(width: 50, height: 50)
                            .padding(20)
                        CircularProgressView(progress: protein, color: .yellow, value: 20)
                            .frame(width: 50, height: 50)
                            .padding(20)
                        CircularProgressView(progress: protein, color: .green, value: 10)
                            .frame(width: 50, height: 50)
                            .padding(20)
                    }
                }
                Picker("Add Food", selection: $selectedFood){
                    ForEach(viewModel.foodList){
                        Text($0.name)
                    }
                }
                    .onChange(of: selectedFood){ value in
                        viewModel.selectedFoodList.append(selectedFood)
                        viewModel.objectWillChange.send()
                    }
                List{
                    ForEach(viewModel.selectedFoodList){
                        Text($0.name)
                    }
                }
                Spacer()
            }
        }
    }
}

struct CircularProgressView: View {
    let progress: Double
    let color: Color
    let value: Int
    
    var body: some View {
        VStack{
            ZStack {
                Circle()
                    .stroke(
                        color.opacity(0.5),
                        lineWidth: 10
                    )
                Text("\(value)")
                    .frame(width: 70, height: 70)
                    .font(.system(size: 15))
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        color,
                        style: StrokeStyle(
                            lineWidth: 10,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut, value: progress)
            }
        }
    }
}

func calculate() -> Int {
    return 0
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(.db)
    }
}
