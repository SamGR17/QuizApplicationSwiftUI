//
//  ContentView.swift
//  QuizAppSwiftUI
//
//  Created by StudentPM on 4/23/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack {
                Text("Rando Trivia") //The quiz's title
                    .font(.system(size: 60))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .position(x: 180, y: 230)
                
                //The start button that takes you to the actual quiz
                NavigationLink(destination: QuizQuestions().navigationBarBackButtonHidden(true)){
                    Text("Start")
                        .frame(width: 250, height: 50)
                        .background(.blue)
                        .foregroundColor(.white)
                        .font(.system(size: 35))
                        .cornerRadius(6.0)
                }
                .position(x: 180, y: 190)
            }
            .padding()
            .background(Image("ArcadeCarpetBackground") //background image
                .resizable()
                .frame(width: 500, height: 900))
        }
    }
}

#Preview {
    ContentView()
}
