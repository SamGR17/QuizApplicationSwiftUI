//
//  QuizEnd.swift
//  QuizAppSwiftUI
//
//  Created by StudentPM on 4/23/25.
//

import SwiftUI

struct QuizEnd: View {
    @Binding var score: Int // gets the score number from the QuizQuestions screen
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Final Score!") //Just the label to let you know that the number below is your final score
                    .foregroundColor(.white)
                    .font(.system(size: 60))
                    .fontWeight(.bold)
                    .position(x: 180, y: 100)
                
                Text("\(score)/20") // This text displays the score that you got out of 20
                    .foregroundColor(.white)
                    .font(.system(size: 50))
                    .position(x: 180, y: -140)
                
                //This is the retry button, so you can retake the quiz
                NavigationLink(destination: QuizQuestions().navigationBarBackButtonHidden()){
                    Text("Retry?")
                        .frame(width: 200, height: 80)
                        .font(.system(size: 35))
                        .fontWeight(.bold)
                        .background(.orange)
                        .foregroundColor(.white)
                        .cornerRadius(6.0)
                }
            }
            .padding()
            .background(Image("ArcadeCarpetBackground") //background image
                .resizable()
                .frame(width: 500, height: 900))
        }
    }
}

#Preview {
    QuizEnd(score: .constant(0))
}
