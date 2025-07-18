//
//  ContentView.swift
//  Jokes Game
//
//  Created by John Vea on 12/2/24.
//

import SwiftUI
import CoreData
import Foundation

struct Joke: Codable {
    
    let setup: String
    let punchline: String
}

struct Trivia: Codable {
    let category: String
    let id: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    let question: String
    let tags: [String]
    let type: String
    let difficulty: String
    let regions: [String]?
    let isNiche: Bool
}

private var newTrivia: [Trivia]?

private var newJoke: Joke?
let defaults = UserDefaults.standard
//defaults.set(0, forKey: "highScore")


struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    
    
    
    @State var jokeSetup: String = ""
    @State var jokepunchline: String = ""
    @State var userAnswer: String = ""
    @State var isCorrect: Bool = false
    @State var didUserAnswer: Bool = false
    @State private var similarityScore: Double?
    @State private var similarityScore2: Double?
    @State var userScore = 0
    @State var SkipsRemaining = 5
    @State var inGame: Bool  = false
    @State var nextQuestion: String = "Skip"
    @State var questionsAnswered = 0
    @State private var isAlertPresented = false
    @State var gameLost: Bool = false
    @State var totalQuestions = 10
    @State var settingSelected: Bool = false
    @State var seletedLevel = "easy"
    @State var categories = ["General Knowledge", "Film & TV", "Music", "Food & Drink", "History", "Science", "Geography", "History", "Art & Literature", "Sport & Leisure", "Society & Culture"]
    @State var categorySelected: String = "General Knowledge"
    @State private var angle = 0.0
    @State var quesT = ""
    @State var answerChoices = ["General Knowledge"]
    @State var correctAnswerChoice = ""
    @State var theLevel = ""
    @State var textLength = 0
    var body: some View {
        VStack{
//            if(didUserAnswer && inGame){
//                Spacer(minLength: 10)
//            }
            Text("Brain Spark ⚡️").font(.largeTitle)
                .bold()
            if(inGame){
                Spacer()
            }
            
            if(!inGame){
                HStack{
                    Spacer()
                    Spacer()
                    @State var settingIcon = settingSelected ? "checkmark.circle.fill" : "gear"
                    
                    Button("",  systemImage: settingIcon ){
                        angle += 360
                        settingSelected.toggle()
                    }
                    .font(.title)
                    .foregroundStyle(Color.white)
                    .rotationEffect(.degrees(angle))
                    .animation(.easeInOut, value: angle)
                    .animation(.spring(response: 0.5, dampingFraction: 0.3, blendDuration: 0), value: 3.5)
                }
            }
            if(inGame){
//                if(didUserAnswer){
//                    Text("\n")
                    
                    
//                    Spacer()
//                    Spacer()
                    
//                    Spacer()
//                    Spacer()
//                }
                HStack{
                    Spacer(minLength: 30.0)
                }
                Text("   Score: \(userScore)" + "\t                    " + "Skips Remaining: \(SkipsRemaining)          ")
                    .font(.title3)
                    .bold()
            }
            else{
//                Text("\t\t\t      \t\t\t \t\t\t \t\t\t                       ")
                HStack{
                    Spacer(minLength: 30.0)
                }
                ZStack{
                    Image(.brainSparkIcon)
                        .resizable()
                        .scaledToFit()
//                        .minimumScaleFactor(1.0)
                    //                ZStack{
                    
                    if(settingSelected){
                        
                        VStack{
                            HStack{
                                Text("Level:")
                                    .font(.title3)
                                    .bold()
                                
                                Picker("Level", selection: $seletedLevel) {
                                    Text("Easy").tag("easy")
                                    Text("Medium").tag("medium")
                                    Text("Hard").tag("hard")
                                }.pickerStyle(.palette)
                            }
                            HStack{
                                Text("Category:").font(.title3)
                                    .bold()
                                Picker("Category", selection: $categorySelected){
                                    ForEach(categories, id: \.self){ category in
                                        Text(category).tag(category)
                                    }
                                }.pickerStyle(.wheel)
                            }
        //                    .animation(.default, value:settingSelected)
        //                    .animation(.easeInOut, value: angle)
                            
        //                    Spacer()
        //                    Spacer()
        //                    Spacer()
        //                    Spacer()
                        }.animation(.easeInOut, value: angle)
                            .background(.ultraThinMaterial)
                            .cornerRadius(10)
                    }
                    
                }
//                    HStack{
//                        Text("\n\n\n\nWelcome!").font(.largeTitle)
//                            .bold()
////                    }
//                    Spacer()
//                }
//                Text("Made by John Bleck Vea").font(.title3)
//                    .bold()
            }
//            if(didUserAnswer){
//                Spacer()
//                Spacer()
//            }
            //if(!settingSelected){
                Spacer()
            //}
//            if(settingSelected){
//                
//                VStack{
//                    HStack{
//                        Text("Level:")
//                            .font(.title3)
//                            .bold()
//                        
//                        Picker("Level", selection: $seletedLevel) {
//                            Text("Easy").tag("easy")
//                            Text("Medium").tag("medium")
//                            Text("Hard").tag("hard")
//                        }.pickerStyle(.palette)
//                    }
//                    HStack{
//                        Text("Category:").font(.title3)
//                            .bold()
//                        Picker("Category", selection: $categorySelected){
//                            ForEach(categories, id: \.self){ category in
//                                Text(category).tag(category)
//                            }
//                        }.pickerStyle(.wheel)
//                    }
////                    .animation(.default, value:settingSelected)
////                    .animation(.easeInOut, value: angle)
//                    
////                    Spacer()
////                    Spacer()
////                    Spacer()
////                    Spacer()
//                }.animation(.easeInOut, value: angle)
//            }
            
            
            
//            if(inGame){
//                Text(jokeSetup).frame(width: .infinity, height: .infinity)
//                    .font(.title3)
//                    .bold()
//                Spacer()
//                Text("Your answer:")
//                    .font(.title3)
//                    .bold()
//                
//                TextField(
//                    "Guess the answer",
//                    text: $userAnswer
//                )
//                .font(.title3)
//                .bold()
//                .multilineTextAlignment(.center)
//                .onSubmit {
//                    didUserAnswer = true
//                    let score = cosineSimilarity(punchline: jokepunchline.lowercased(), userAnswer: userAnswer.lowercased())
//                    similarityScore2 = cosineSimilarity(punchline:userAnswer.lowercased() , userAnswer: jokepunchline.lowercased().replacingOccurrences(of: ".", with: ""))
//                    similarityScore = score
//                    print("Score: %f\n", score)
//                    print(similarityScore2!)
//                    if(similarityScore! > 0.48 || similarityScore2! > 0.47){
//                        userScore += 1
//                    }
//                    questionsAnswered += 1
//                    nextQuestion = "Next"
//
//                }
//            }
            if(inGame){
                //Text("\(newTrivia![questionsAnswered].question)").frame(width: .infinity, height: .infinity)
                //Text(newQuestion)
//                Text("\(newTrivia![questionsAnswered].question)").frame(width: .infinity, height: .infinity)
                
                Text(quesT).font(.title2)
                    .bold()
//                    .padding(.all, max(CGFloat(quesT.count * 2), 16))
                    .frame(minWidth: max(CGFloat(quesT.count * 2), 50))
//                    .frame(width: .infinity, height: .infinity)
                VStack{
                    if(!didUserAnswer){
                    VStack{
                        Spacer()
                        if let firstAnswer = answerChoices.first {
                            Button("\(firstAnswer)") {
                                didUserAnswer = true
                                userAnswer = firstAnswer
                                if(firstAnswer == correctAnswerChoice) {
                                    userScore += 1
                                }
                                nextQuestion = "Next"
                            }.font(.title3)
                                .padding(.all, max(CGFloat(textLength), 16))
                                .frame(minWidth: max(CGFloat(textLength * 10), 150))
                                .foregroundStyle(.black)
                                .bold()
                                .background(RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.white)
                                    .opacity(0.6))
                        }
                        Spacer()
                        if answerChoices.indices.contains(1) {  // Check if the second element exists
                            let secondAnswer = answerChoices[1]
                            
                            Button("\(secondAnswer)") {
                                userAnswer = secondAnswer
                                didUserAnswer = true
                                if(secondAnswer == correctAnswerChoice) {
                                    userScore += 1
                                }
                                nextQuestion = "Next"
                            }
                            .font(.title3)
                            .padding(.all, max(CGFloat(textLength), 16))
                            .frame(minWidth: max(CGFloat(textLength * 10), 150))
                            .foregroundStyle(.black)
                            .bold()
                            .background(RoundedRectangle(cornerRadius: 5)
                                .fill(Color.white)
                                .opacity(0.6))
                        }
                        Spacer()
                        
                        if answerChoices.indices.contains(1) {  // Check if the second element exists
                            let thirdAnswer = answerChoices[2]
                            Button("\(thirdAnswer)") {
                                didUserAnswer = true
                                userAnswer = thirdAnswer
                                if(thirdAnswer == correctAnswerChoice) {
                                    userScore += 1
                                }
                                nextQuestion = "Next"
                            }
                            .font(.title3)
                            .padding(.all, max(CGFloat(textLength), 16))
                            .frame(minWidth: max(CGFloat(textLength * 10), 150))
                            .foregroundStyle(.black)
                            .bold()
                            .background(RoundedRectangle(cornerRadius: 5)
                                .fill(Color.white)
                                .opacity(0.6))
                        }
                        Spacer()
                        if let lastAnswer = answerChoices.last{
                            Button("\(lastAnswer)") {
                                didUserAnswer = true
                                userAnswer = lastAnswer
                                if "\(lastAnswer)" == correctAnswerChoice {
                                    userScore += 1
                                }
                                nextQuestion = "Next"
                            }.font(.title3)
                                .padding(.all, max(CGFloat(textLength), 16))
                                .frame(minWidth: max(CGFloat(textLength * 10), 150))
                                .foregroundStyle(.black)
                                .bold()
                                .background(RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.white)
                                    .opacity(0.6))
                        }
                        Spacer()
                    }.multilineTextAlignment(.center)
//                        VStack{
//                            Spacer()
//                            if answerChoices.indices.contains(1) {  // Check if the second element exists
//                                let thirdAnswer = answerChoices[2]
//                                Button("\(thirdAnswer)") {
//                                    didUserAnswer = true
//                                    userAnswer = thirdAnswer
//                                    if(thirdAnswer == correctAnswerChoice) {
//                                        userScore += 1
//                                    }
//                                    nextQuestion = "Next"
//                                }
//                                .font(.title3)
//                                .padding(.all, max(CGFloat(textLength), 16))
//                                .frame(minWidth: max(CGFloat(textLength * 10), 150))
//                                .foregroundStyle(.black)
//                                .bold()
//                                .background(RoundedRectangle(cornerRadius: 5)
//                                    .fill(Color.white)
//                                    .opacity(0.6))
//                            }
//                            Spacer()
//                            if let lastAnswer = answerChoices.last{
//                                Button("\(lastAnswer)") {
//                                    didUserAnswer = true
//                                    userAnswer = lastAnswer
//                                    if "\(lastAnswer)" == correctAnswerChoice {
//                                        userScore += 1
//                                    }
//                                    nextQuestion = "Next"
//                                }.font(.title3)
//                                    .padding(.all, max(CGFloat(textLength), 16))
//                                    .frame(minWidth: max(CGFloat(textLength * 10), 150))
//                                    .foregroundStyle(.black)
//                                    .bold()
//                                    .background(RoundedRectangle(cornerRadius: 5)
//                                        .fill(Color.white)
//                                        .opacity(0.6))
//                            }
//                            Spacer()
//                        }.multilineTextAlignment(.center)
                        
//                        let firstAnswer = "\(answerChoices.first)"
//                        Button("\(firstAnswer)"){
//                            didUserAnswer = true
//                            if(firstAnswer as! String == correctAnswerChoice){
//                                userScore += 1
//                            }
//                        }.background(RoundedRectangle(cornerRadius: 10)
//                            .fill(Color.white)
//                            .opacity(0.3)
//                        )
                        
                    }else if(didUserAnswer){
                            VStack{
                                Spacer()
                                if let firstAnswer = answerChoices.first {
                                    Text("\(firstAnswer)").font(.title3)
                                        .padding(.all, max(CGFloat(textLength), 16))
                                        .frame(minWidth: max(CGFloat(textLength * 10), 150))
                                        .foregroundStyle(.black)
                                        .bold()
                                        .background(RoundedRectangle(cornerRadius: 5)
                                            .fill(firstAnswer == correctAnswerChoice ? Color.green : (firstAnswer == userAnswer ? Color.red : Color.white))
                                            .opacity(0.6))
                                }
                                Spacer()
                                if answerChoices.indices.contains(1) {  // Check if the second element exists
                                    let secondAnswer = answerChoices[1]
                                   Text("\(secondAnswer)")
                                    .font(.title3)
                                    .padding(.all, max(CGFloat(textLength), 16))
                                    .frame(minWidth: max(CGFloat(textLength * 10), 150))
                                    .foregroundStyle(.black)
                                    .bold()
                                    .background(RoundedRectangle(cornerRadius: 5)
                                        .fill(secondAnswer == correctAnswerChoice ? Color.green : (secondAnswer == userAnswer ? Color.red : Color.white))
                                        .opacity(0.6))
                                }
                                Spacer()
                                
                                if answerChoices.indices.contains(1) {  // Check if the second element exists
                                    let thirdAnswer = answerChoices[2]
                                    Text("\(thirdAnswer)")
                                    .font(.title3)
                                    .padding(.all, max(CGFloat(textLength), 16))
                                    .frame(minWidth: max(CGFloat(textLength * 10), 150))
                                    .foregroundStyle(.black)
                                    .bold()
                                    .background(RoundedRectangle(cornerRadius: 5)
                                        .fill(thirdAnswer == correctAnswerChoice ? Color.green : (thirdAnswer == userAnswer ? Color.red : Color.white))
                                        .opacity(0.6))
                                }
                                Spacer()
                                if let lastAnswer = answerChoices.last{
                                    Text("\(lastAnswer)").font(.title3)
                                        .padding(.all, max(CGFloat(textLength), 16))
                                        .frame(minWidth: max(CGFloat(textLength * 10), 150))
                                        .foregroundStyle(.black)
                                        .bold()
                                        .background(RoundedRectangle(cornerRadius: 5)
                                            .fill(lastAnswer == correctAnswerChoice ? Color.green : (lastAnswer == userAnswer ? Color.red : Color.white))
                                            .opacity(0.6))
                                }
                                Spacer()
                            }.multilineTextAlignment(.center)
//                        VStack{
//                            Spacer()
//                            if answerChoices.indices.contains(1) {  // Check if the second element exists
//                                let thirdAnswer = answerChoices[2]
//                                Text("\(thirdAnswer)")
//                                .font(.title3)
//                                .padding(.all, max(CGFloat(textLength), 16))
//                                .frame(minWidth: max(CGFloat(textLength * 10), 150))
//                                .foregroundStyle(.black)
//                                .bold()
//                                .background(RoundedRectangle(cornerRadius: 5)
//                                    .fill(thirdAnswer == correctAnswerChoice ? Color.green : (thirdAnswer == userAnswer ? Color.red : Color.white))
//                                    .opacity(0.6))
//                            }
////                            Spacer()
//                            if let lastAnswer = answerChoices.last{
//                                Text("\(lastAnswer)").font(.title3)
//                                    .padding(.all, max(CGFloat(textLength), 16))
//                                    .frame(minWidth: max(CGFloat(textLength * 10), 150))
//                                    .foregroundStyle(.black)
//                                    .bold()
//                                    .background(RoundedRectangle(cornerRadius: 5)
//                                        .fill(lastAnswer == correctAnswerChoice ? Color.green : (lastAnswer == userAnswer ? Color.red : Color.white))
//                                        .opacity(0.6))
//                            }
//                            Spacer()
//                        }.multilineTextAlignment(.center)
                        Spacer()
//                        Spacer()
//                        Spacer()
//                        Spacer()
                        
                        }
                    
                }.multilineTextAlignment(.center)
                
               
//                Spacer(minLength: 50)
//                if(didUserAnswer && inGame){
//                    Spacer(minLength: 230)
//                }
//                
                if(userAnswer == correctAnswerChoice && didUserAnswer){
                    Text("\n")
                    Text("Correct!").font(.title3)
                        .padding(.all, max(CGFloat(textLength), 16))
                        .frame(minWidth: max(CGFloat(textLength * 10), 150))
                        .foregroundStyle(.green)
                        .bold()
                        .background(RoundedRectangle(cornerRadius: 5)
                            .fill(Color.white)
                            .opacity(0.6))
                }
                else if (didUserAnswer){
                    Text("\n")
                    Text("Incorrect!").font(.title3)
                        .padding(.all, max(CGFloat(textLength), 16))
                        .frame(minWidth: max(CGFloat(textLength * 10), 150))
                        .foregroundStyle(.red)
                        .bold()
                        .background(RoundedRectangle(cornerRadius: 5)
                            .fill(Color.white)
                            .opacity(0.6))
                }
                
                
            }
            if (!didUserAnswer){
                Spacer()
            }
//            if(didUserAnswer && similarityScore! > 0.48 || didUserAnswer && similarityScore2! > 0.47){
//                Text("Correct!").font(.title3)
//                    .background(RoundedRectangle(cornerRadius: 4)
//                        .fill(Color.white)
//                        .opacity(0.6))
//                    .foregroundColor(.green)
//                    .bold()
//                
//            }else if (didUserAnswer){
//                Text("Incorrect!").font(.title3)
//                    .background(RoundedRectangle(cornerRadius: 4)
//                        .fill(Color.white)
//                        .opacity(0.6))
//                    .foregroundStyle(.red)
//                    .bold()
//                    
////                Text("Correct Answer: ")
//                Text(jokepunchline).bold()
//                    .font(.title3)
//                    
//            }
            if(inGame){
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                
            }
            
            if (!didUserAnswer){
                Spacer()
                Spacer()
            }
            
            HStack{
                if(!inGame){
                    VStack{
                        
                        if(gameLost){
                            Spacer()
                            Spacer()
                                Text("Score \(userScore)").font(.title3)
                                    .bold()
                                Text("\(theLevel)").font(.title2)
                                    .background(RoundedRectangle(cornerRadius: 3)
                                        .fill(Color.yellow)
                                        .opacity(0.6))
                                    .bold()
                            if(theLevel == "easy"){
                                Text("High Score \(UserDefaults.standard.integer(forKey: "highScoreEasy"))").font(.title3)
                                    .bold()
                            } else if(theLevel == "medium"){
                                Text("High Score \(UserDefaults.standard.integer(forKey: "highScoreMedium"))").font(.title3)
                                    .bold()
                            }else if(theLevel == "hard"){
                                Text("High Score \(UserDefaults.standard.integer(forKey: "highScoreHard"))").font(.title3)
                                    .bold()
                            }
                            Spacer()
                        }
//                        if(settingSelected){
//                            Spacer()
//                        }
                        Button("New Game", systemImage: "plus.square.fill"){
                            print(seletedLevel)
                            categorySelected = categorySelected.lowercased().replacingOccurrences(of: " ", with: "_").replacingOccurrences(of: "&", with: "and")
                            print()
                            print(categorySelected)
                            print()
                            didUserAnswer = false
                            inGame = true
                            userAnswer = ""
                            gameLost = false
                            questionsAnswered = 0
                            userScore = 0
                            textLength = 0
                            settingSelected = false
                            if(seletedLevel == "easy"){
                                SkipsRemaining = 5
                                totalQuestions = 10
                            }else if(seletedLevel == "medium"){
                                SkipsRemaining = 3
                                totalQuestions = 15
                            }else if (seletedLevel == "hard"){
                                SkipsRemaining = 1
                                totalQuestions = 20
                            }
                            theLevel = seletedLevel
                            Task {
//                                newJoke = await fetchJoke()
//                                jokeSetup = newJoke?.setup ?? "No joke"
//                                jokepunchline = newJoke?.punchline ?? "No joke"
//                                print(jokepunchline)
                                
                                newTrivia = await fetchTrivias()
//                                newTrivia?.append(thenewTrivia?[questionsAnswered])
//                                let thenewtrivia = await fetchTrivias()
//                                print("\(newTrivia!)")
//                                print()
//                                print(newTrivia?[questionsAnswered].correctAnswer)
//                                print()
//                                print("\(newTrivia![questionsAnswered].incorrectAnswers)")
//                                print()
                                quesT = "\(newTrivia![questionsAnswered].question)"
                                answerChoices.removeAll()
                                answerChoices.append("\(newTrivia![questionsAnswered].incorrectAnswers[0])")
                                answerChoices.append("\(newTrivia![questionsAnswered].incorrectAnswers[1])")
                                answerChoices.append("\(newTrivia![questionsAnswered].incorrectAnswers[2])")
                                answerChoices.append("\(newTrivia![questionsAnswered].correctAnswer)")
                                correctAnswerChoice = "\(newTrivia![questionsAnswered].correctAnswer)"
                                answerChoices.shuffle()
                                if(textLength < answerChoices[0].count){
                                    textLength = answerChoices[0].count
                                }
                                if(textLength < answerChoices[1].count){
                                    textLength = answerChoices[1].count
                                }
                                if(textLength < answerChoices[2].count){
                                    textLength = answerChoices[2].count
                                }
                                if(textLength < answerChoices[3].count){
                                    textLength = answerChoices[3].count
                                }
                                
                                answerChoices[0] = answerChoices[0] + String(repeating: " ", count: textLength - answerChoices[0].count)
                                answerChoices[1] = answerChoices[1] + String(repeating: " ", count: textLength - answerChoices[1].count)
                                answerChoices[2] = answerChoices[2] + String(repeating: " ", count: textLength - answerChoices[2].count)
                                answerChoices[3] = answerChoices[3] + String(repeating: " ", count: textLength - answerChoices[3].count)
                                
                                correctAnswerChoice = correctAnswerChoice + String(repeating: " ", count: textLength - correctAnswerChoice.count)
                                
                                print()
                                
                            }
                            
                            
                            
                        }.padding()
                            .bold()
//                        
//                            .background(RoundedRectangle(cornerRadius: 10)
//                                .fill(Color.white)
//                                .opacity(0.3)
//                            )
                            .background(.ultraThinMaterial)
                            .cornerRadius(10)
                        
                            .foregroundColor(.white)
//                            .frame(width: .infinity, height: 100)
                        
//                        if(settingSelected){
//                            Spacer()
//                            Spacer()
//                            Spacer()
//                            Spacer()
//                            Spacer()
//                            Spacer()
//                        }
                        
                    }
                }else{
                    
                    Button(nextQuestion, systemImage: "arrowshape.bounce.forward.fill"){
                        print("Questions answered ")
                        print("\(questionsAnswered+1)")
                        print(quesT)
                        didUserAnswer = false
                        userAnswer = ""
                        if(nextQuestion == "Skip"){
                            didUserAnswer = false
                            SkipsRemaining -= 1
                            if(SkipsRemaining < 0 || questionsAnswered == totalQuestions-1){
                                
                                gameLost = true
                                
                                
                                inGame = false
                                if(seletedLevel == "easy"){
                                    SkipsRemaining = 5
                                    totalQuestions = 10
                                }else if(seletedLevel == "medium"){
                                    SkipsRemaining = 3
                                    totalQuestions = 15
                                }else if (seletedLevel == "hard"){
                                    SkipsRemaining = 1
                                    totalQuestions = 20
                                }
                                jokepunchline = ""
                                jokeSetup = ""
                                questionsAnswered = 0
                                textLength = 0
                                if(seletedLevel == "easy"){
                                    if(userScore > UserDefaults.standard.integer(forKey: "highScoreEasy")){
                                        UserDefaults.standard.set(userScore, forKey: "highScoreEasy")
                                    }
                                }else if (seletedLevel == "medium"){
                                    if(userScore > UserDefaults.standard.integer(forKey: "highScoreMedium")){
                                        UserDefaults.standard.set(userScore, forKey: "highScoreMedium")
                                    }
                                }else if (seletedLevel == "hard"){
                                    if(userScore > UserDefaults.standard.integer(forKey: "highScoreHard")){
                                        UserDefaults.standard.set(userScore, forKey: "highScoreHard")
                                    }
                                }
                            }else{
                                Task {
//                                    newJoke = await fetchJoke()
                                    questionsAnswered += 1
                                    quesT = "\(newTrivia![questionsAnswered].question)"
                                    answerChoices.removeAll()
                                    answerChoices.append("\(newTrivia![questionsAnswered].incorrectAnswers[0])")
                                    answerChoices.append("\(newTrivia![questionsAnswered].incorrectAnswers[1])")
                                    answerChoices.append("\(newTrivia![questionsAnswered].incorrectAnswers[2])")
                                    answerChoices.append("\(newTrivia![questionsAnswered].correctAnswer)")
                                    correctAnswerChoice = "\(newTrivia![questionsAnswered].correctAnswer)"
                                    answerChoices.shuffle()
                                    if(textLength < answerChoices[0].count){
                                        textLength = answerChoices[0].count
                                    }
                                    if(textLength < answerChoices[1].count){
                                        textLength = answerChoices[1].count
                                    }
                                    if(textLength < answerChoices[2].count){
                                        textLength = answerChoices[2].count
                                    }
                                    if(textLength < answerChoices[3].count){
                                        textLength = answerChoices[3].count
                                    }
                                    
                                    answerChoices[0] = answerChoices[0] + String(repeating: " ", count: textLength - answerChoices[0].count)
                                    answerChoices[1] = answerChoices[1] + String(repeating: " ", count: textLength - answerChoices[1].count)
                                    answerChoices[2] = answerChoices[2] + String(repeating: " ", count: textLength - answerChoices[2].count)
                                    answerChoices[3] = answerChoices[3] + String(repeating: " ", count: textLength - answerChoices[3].count)
                        
                                    correctAnswerChoice = correctAnswerChoice + String(repeating: " ", count: textLength - correctAnswerChoice.count)
//                                    jokeSetup = newJoke?.setup ?? "No joke"
//                                    jokepunchline = newJoke?.punchline ?? "No joke"
//                                    print(jokepunchline)
//                                    
                                }
                            }
                        }
                        else if(questionsAnswered == totalQuestions-1){
                            gameLost = true
                            didUserAnswer = false
                            
                            inGame = false
                            if(seletedLevel == "easy"){
                                SkipsRemaining = 5
                                totalQuestions = 10
                            }else if(seletedLevel == "medium"){
                                SkipsRemaining = 3
                                totalQuestions = 15
                            }else if (seletedLevel == "hard"){
                                SkipsRemaining = 1
                                totalQuestions = 20
                            }
                            jokepunchline = ""
                            jokeSetup = ""
                            questionsAnswered = 0
                            textLength = 0
                            if(seletedLevel == "easy"){
                                if(userScore > UserDefaults.standard.integer(forKey: "highScoreEasy")){
                                    UserDefaults.standard.set(userScore, forKey: "highScoreEasy")
                                }
                            }else if (seletedLevel == "medium"){
                                if(userScore > UserDefaults.standard.integer(forKey: "highScoreMedium")){
                                    UserDefaults.standard.set(userScore, forKey: "highScoreMedium")
                                }
                            }else if (seletedLevel == "hard"){
                                if(userScore > UserDefaults.standard.integer(forKey: "highScoreHard")){
                                    UserDefaults.standard.set(userScore, forKey: "highScoreHard")
                                }
                            }
//                            userScore = 0
                        }else{
                            didUserAnswer = false
                            Task {
                                questionsAnswered += 1
                                quesT = "\(newTrivia![questionsAnswered].question)"
                                answerChoices.removeAll()
                                answerChoices.append("\(newTrivia![questionsAnswered].incorrectAnswers[0])")
                                answerChoices.append("\(newTrivia![questionsAnswered].incorrectAnswers[1])")
                                answerChoices.append("\(newTrivia![questionsAnswered].incorrectAnswers[2])")
                                answerChoices.append("\(newTrivia![questionsAnswered].correctAnswer)")
                                correctAnswerChoice = "\(newTrivia![questionsAnswered].correctAnswer)"
                                answerChoices.shuffle()
                                if(textLength < answerChoices[0].count){
                                    textLength = answerChoices[0].count
                                }
                                if(textLength < answerChoices[1].count){
                                    textLength = answerChoices[1].count
                                }
                                if(textLength < answerChoices[2].count){
                                    textLength = answerChoices[2].count
                                }
                                if(textLength < answerChoices[3].count){
                                    textLength = answerChoices[3].count
                                }
                                
                                answerChoices[0] = answerChoices[0] + String(repeating: " ", count: textLength - answerChoices[0].count)
                                answerChoices[1] = answerChoices[1] + String(repeating: " ", count: textLength - answerChoices[1].count)
                                answerChoices[2] = answerChoices[2] + String(repeating: " ", count: textLength - answerChoices[2].count)
                                answerChoices[3] = answerChoices[3] + String(repeating: " ", count: textLength - answerChoices[3].count)
                                
                                correctAnswerChoice = correctAnswerChoice + String(repeating : " ", count: textLength - correctAnswerChoice.count)
                                
//                                newJoke = await fetchJoke()
//                                jokeSetup = newJoke?.setup ?? "No joke"
//                                jokepunchline = newJoke?.punchline ?? "No joke"
//                                print(jokepunchline)
                                
                                
                            }
                        }
                        
                        nextQuestion = "Skip"
                        didUserAnswer = false
                        
                        
                        
                    }.padding()
                        .bold()
                    
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .opacity(0.3)
                        )
                    
                    
                        .foregroundColor(.white)
//                        .frame(width: .infinity, height: 100)
                    
                    
                    Button("End Gane", systemImage: "xmark.circle.fill"){
                        
                        didUserAnswer = false
                        userAnswer = ""
                        inGame = false
                        if(seletedLevel == "easy"){
                            SkipsRemaining = 5
                            totalQuestions = 10
                        }else if(seletedLevel == "medium"){
                            SkipsRemaining = 3
                            totalQuestions = 15
                        }else if (seletedLevel == "hard"){
                            SkipsRemaining = 1
                            totalQuestions = 20
                        }
                        
//                        Task {
//                            newJoke = await fetchJoke()
//                            jokeSetup = newJoke?.setup ?? "No joke"
//                            jokepunchline = newJoke?.punchline ?? "No joke"
//                            print(jokepunchline)
//
//                        }
                        jokepunchline = ""
                        jokeSetup = ""
                        questionsAnswered = 0
                        userScore = 0
                        
                    }.padding()
                        .bold()
                    
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(Color.red)
                            .opacity(0.7)
                        )
                    
                    
                        .foregroundColor(.white)
//                        .frame(width: .infinity, height: 100)
                }
            }
            
            if(!inGame){
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
            
           
                
//                .border(Color.white, width: 2)
            
            
            
        }.background(Color.teal)
//            .frame(width: .infinity, height: .infinity)
//            .edgesIgnoringSafeArea(.all)
    }
    

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    
    
    // Function to compute Cosine Similarity based on Term Frequency (TF)
        func cosineSimilarity(punchline: String, userAnswer: String) -> Double {
            let punchlineTokens = tokenize(text: punchline)
            let userAnswerTokens = tokenize(text: userAnswer)
            
            // Combine unique words from both strings
            let allWords = Set(punchlineTokens + userAnswerTokens)
            
            let punchlineVector = createVector(tokens: allWords, baseTokens: punchlineTokens)
            let userAnswerVector = createVector(tokens: allWords, baseTokens: userAnswerTokens)
            
            let dotProduct = zip(punchlineVector, userAnswerVector).map(*).reduce(0, +)
            let magnitude1 = sqrt(punchlineVector.map { $0 * $0 }.reduce(0, +))
            let magnitude2 = sqrt(userAnswerVector.map { $0 * $0 }.reduce(0, +))

            return dotProduct / (magnitude1 * magnitude2)
        }

        // Tokenizes the text (splits into words)
        func tokenize(text: String) -> [String] {
            return text.lowercased().components(separatedBy: CharacterSet.whitespacesAndNewlines).filter { !$0.isEmpty }
        }

        // Create a vector for the given tokens based on the provided word set
        func createVector(tokens: Set<String>, baseTokens: [String]) -> [Double] {
            return tokens.map { word in
                Double(baseTokens.filter { $0 == word }.count)
            }
        }
    
    
    
    private func getNewJoke(){
        Task {
            await fetchJoke()
        }
        
    }
    
   
    
    private func fetchJoke() async -> Joke? {
        guard let url = URL(string: "https://official-joke-api.appspot.com/random_joke") else {
            print("Invalid URL")
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            // Using async/await with URLSession's async API
            let (data, _) = try await URLSession.shared.data(for: request)

            // Decode the JSON into a Joke object
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(Joke.self, from: data)
                
            // Return the decoded joke
            return decodedData
        } catch {
            print("Error fetching or decoding joke: \(error.localizedDescription)")
            return nil
        }
    }
    
    
    
    
    private func fetchTrivias() async -> [Trivia]? {
//        print(categorySelected = categorySelected.lowercased().replacingOccurrences(of: " ", with: ""))
//        print(seletedLevel)
//        print("https://the-trivia-api.com/api/questions?categories=\(categorySelected)&limit=\(totalQuestions)&difficulty=\(seletedLevel)")
        guard let url = URL(string: "https://the-trivia-api.com/api/questions?categories=\(categorySelected)&limit=\(totalQuestions)&difficulty=\(seletedLevel)")else {
            print("Invalid URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            // Using async/await with URLSession's async API
            let (data, _) = try await URLSession.shared.data(for: request)

            // Decode the JSON into a Joke object
            let decoder = JSONDecoder()
            let decodedTrivia = try decoder.decode([Trivia].self, from: data)
//            print(decodedTrivia)
            // Return the decoded joke
            return decodedTrivia
        } catch {
            print("Error fetching or decoding joke: \(error.localizedDescription)")
            return nil
        }
    }
    
    
    
    

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView()
}
