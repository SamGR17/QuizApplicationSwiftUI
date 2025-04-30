//
//  QuizQuestions.swift
//  QuizAppSwiftUI
//
//  Created by StudentPM on 4/23/25.
//

import SwiftUI

//This is the struct that makes up the parts for each question, it adds a place for the question text, answers, and the correct answer
struct Questions{
    var question: String
    var answers: [String]
    var correctAnswer: String
}


struct QuizQuestions: View {
    //This is the array containing all the questions for the quiz, each contains the question text, options, and correct answer
    @State var questionsAsked : [Questions] = [
    Questions(question: "1. What is the largest living fish?", answers: ["Sunfish", "Whale Shark", "Blue Whale", "Beluga Sturgeon"], correctAnswer: "Whale Shark"),
    
    Questions(question: "2. Acarophobia is the fear of what?", answers: ["Animal fur or skin", "Dining with other people", "Peanut butter sticking to the roof of your mouth", "Bites by small parasitic insects"], correctAnswer: "Bites by small parasitic insects"),
    
    Questions(question: "3. What was the first country to declare internet a legal right?", answers: ["Finland", "Australia", "China", "Russia"], correctAnswer: "Finland"),
    
    Questions(question: "4. What kind of a creature is Rikki-Tikki-Tavi?", answers: ["Slug", "Mongoose", "Amphibian", "Sea Mammal"], correctAnswer: "Mongoose"),
    
    Questions(question: "5. A nebula is a large interstellar cloud of what?", answers: ["Multi-colored fire", "plasma", "Dust and gases", "visible radiation"], correctAnswer: "Dust and gases"),
    
    Questions(question: "6. Where was the world's first public aquarium?", answers: ["London", "Taiwan", "Berlin", "Miami"], correctAnswer: "London"),
    
    Questions(question: "7. A tetragon is geometric shape that has how many sides?", answers: ["5", "7", "4", "3"], correctAnswer: "4"),
    
    Questions(question: "8. What is the world’s most populous country that drives on the left?", answers: ["Nepal", "India", "Bhutan", "Thailand"], correctAnswer: "India"),
    
    Questions(question: "9. Who is the Greek equivalent of the Roman god Diana?", answers: ["Demeter", "Artemis", "Athena", "Aphrodite"], correctAnswer: "Artemis"),
    
    Questions(question: "10. Where was ballet invented?", answers: ["France", "Russia", "Greece", "Italy"], correctAnswer: "Italy"),
    
    Questions(question: "11. What is the capital of Hawaii?", answers: ["Honolulu", "Kailua-Kona", "Hawi", "Lahaina"], correctAnswer: "Honolulu"),
    
    Questions(question: "12. What cheese's name literally means recooked in Italian?", answers: ["Mozzarella", "Parmesan", "Ricotta", "Pimento"], correctAnswer: "Ricotta"),
    
    Questions(question: "13. What do speleologists study?", answers: ["Mars", "Wild cave systems", "Mites and ticks", "Male health"], correctAnswer: "Wild cave systems"),
    
    Questions(question: "14. What is a half hunter?", answers: ["Type of anti-virus", "A pocket watch", "Crossbow", "A hat"], correctAnswer: "A pocket watch"),
    
    Questions(question: "15. Which chemical element did the ancients call brimstone?", answers: ["Sulfur", "Mercury", "Polonium", "Fluorine"], correctAnswer: "Sulfur"),
    
    Questions(question: "16. What is the world's longest lake?", answers: ["Lake Balkhash", "Lake Baikal", "Lake Tanganyika", "Lake Malawi"], correctAnswer: "Lake Tanganyika"),
    
    Questions(question: "17. What type of gemstone was historically worn with the belief that it would prevent the wearer from becoming drunk?", answers: ["Amethyst", "Opal", "Citrine", "Garnet"], correctAnswer: "Amethyst"),
    
    Questions(question: "18. What was the first Mickey Mouse cartoon?", answers: ["The Gallopin' Gaucho", "Steamboat Willie", "The Plowboy", "Plane Crazy"], correctAnswer: "Plane Crazy"),
    
    Questions(question: "19. What is the fear of mushrooms known as?", answers: ["Nomophobia", "Mycophobia", "Ablutophobia", "Coulrophobia"], correctAnswer: "Mycophobia"),
    
    Questions(question: "20. How many times faster does sound travel in water than in air?", answers: ["Two times", "Three times", "Four times", "Five times"], correctAnswer: "Four times")
    ]
    
    @State var score: Int = 0 //variable containing the score number
    @State var questionNum: Int = 0 //variable meant to move through the questions in the array
    
    @State var answerButtonsAvailability: Bool = true //meant for making the option buttons disabled or enabled
    @State var nextQuestionBtnAvailability: Bool = false //meant for making the next question button disabled or enabled
    @State var endQuizBtnAvailability: Bool = false //meant for making the end quiz button disabled or enabled
    
    @State var isCorrect: Bool = false //meant to determine if the answer is right or wrong
    
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Score: \(score)") //This displays the current score
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .position(x: 180, y: 20)
                
                
                Text("\(questionsAsked[questionNum].question)") //This displays the current question
                    .frame(width: 350, height: 200)
                    .background(.white)
                    .border(Color.purple, width: 4)
                    .cornerRadius(8.0)
                    .position(x: 180, y: 50)
                
                
                //This creates buttons for all the options for a question
                ForEach(questionsAsked[questionNum].answers.indices, id: \.self){ i in
                    Button(action: {checkIfCorrect(index: i)}, label: {
                        Text("\(questionsAsked[questionNum].answers[i])")
                            .frame(width: 350, height: 50)
                            .background(isCorrect == false ? .white : .green) //If isCorrect is equal to false, the buttons will all be white, if isCorrect is equal to true, the buttons will all be green
                            .foregroundColor(.black)
                            .border(Color.yellow, width: 4)
                            .cornerRadius(8.0)
                    })
                    .position(x: 180, y: 100)
                    .disabled(answerButtonsAvailability == true ? false : true)
                }
                
                //This is the next question button
                Button(action: {nextQuestionButton()}, label: {
                    Text("Next Question")
                        .frame(width: 150, height: 50)
                        .background(nextQuestionBtnAvailability == false ? .gray : .blue) //If the variable is equal to false, the button will be gray meaning it is disabled, if the variable is equal to true, the button will be blue meaning it is enabled
                        .foregroundColor(.white)
                        .cornerRadius(6.0)
                })
                .position(x: 80, y: 141)
                .disabled(nextQuestionBtnAvailability == false ? true : false) //If the variable is false, the button will be disabled, if the variable is true, the button will be enabled
                
                NavigationLink(destination: QuizEnd(score: $score).navigationBarBackButtonHidden(true)){
                    Text("End Quiz")
                        .frame(width: 150, height: 50)
                        .background(endQuizBtnAvailability == false ? .gray : .red) //If the variable is false, the button will be gray meaning it is disabled, if the variable is true, the button will be red meaning it is enabled
                        .foregroundColor(.white)
                        .cornerRadius(6.0)
                }
                .position(x: 280, y: 50)
                .disabled(endQuizBtnAvailability == false ? true : false) //If the variable is false, the button will be disabled, if the variable is true, the button will be enabled
            }
            .padding()
            .background(Image("ArcadeCarpetBackground") // background image
                .resizable()
                .frame(width: 500, height: 900))
        }
    }
    
    //This function is meant to check if an answer is correct and let you move on to the other questions
    func checkIfCorrect(index: Int){
        //The option the user picks is correct, it will add 1 to the current score, turn the buttons green, enable the next question button, and disable the option buttons
        if questionsAsked[questionNum].answers[index] == questionsAsked[questionNum].correctAnswer{
            score += 1
            
            isCorrect = true
            nextQuestionBtnAvailability = true
            answerButtonsAvailability = false
            
            //If it is the final question of the quiz, it will enable the end quiz button
            if questionNum == (questionsAsked.count - 1){
                endQuizBtnAvailability = true
            }
        }
        else{ // If the option the user picks is wrong, it will add nothing to the current score, enable the next question button, and disable the option buttons
            nextQuestionBtnAvailability = true
            answerButtonsAvailability = false
            
            //If it is the final question of the quiz, it will enable the end quiz button
            if questionNum == (questionsAsked.count - 1){
                endQuizBtnAvailability = true
            }
        }
        
        //Also, if it is the final question of the quiz, this will disable the next question button, so that the end quiz button will be the only button available
        if questionNum == (questionsAsked.count - 1){
            nextQuestionBtnAvailability = false
        }
    }
    
    //This function is meant to take you to the next question
    func nextQuestionButton(){
        questionNum += 1 // 1 is added to the questionNum variable to move to the next item in the array, in other words, the next question
        
        //when the button is clicked, it will reset the all the buttons' color, disable the next question button, and enable the option buttons
        isCorrect = false
        nextQuestionBtnAvailability = false
        answerButtonsAvailability = true
    }
}

#Preview {
    QuizQuestions()
}
