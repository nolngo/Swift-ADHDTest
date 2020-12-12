//
//  ContentView.swift
//  ADHDTest
//
//  Created by Nolan on 12/11/20.
//

import SwiftUI

enum ColorOption {
    case blue
    case red
    case yellow
    case green
    case purple
    
    
    var meaning: String{
        switch self{
        case .blue:
            return "blue"
        case .red:
            return "red"
        case .yellow:
            return "yellow"
        case .green:
            return "green"
        case .purple:
            return "purple"
        }
    }
    
    var textColor: Color{
        switch self{
        case .blue:
            return Color(red: 0, green: 0, blue: 200)
        case .red:
            return Color(red: 200, green: 0, blue: 0)
        case .yellow:
            return Color(red: 100, green: 100, blue: 0)
        case .green:
            return Color(red: 0, green: 200, blue: 0)
        case .purple:
            return Color(red: 100, green: 0, blue: 100)
        }
    }
    init() {
        self = ColorOption.allCases[Int(arc4random_uniform(UInt32(ColorOption.allCases.count)))]
    }
}
extension ColorOption: CaseIterable {
    mutating func getRandomColor(){
        self = ColorOption.allCases[Int(arc4random_uniform(UInt32(ColorOption.allCases.count)))]
    }
}



struct ContentView: View {
    @State var topColor = ColorOption()
    @State var bottomColor = ColorOption()
    @State var displayColor = ColorOption()
    
    @State var answer: Bool = false
    @State var score: Int = 0
    
    @State var timeLeft: Int = 90
    
    //    var currentScore =
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(alignment: .center, spacing: 40 ){
            
            Text("\(timeLeft)s left").onReceive(timer) { input in
                if self.timeLeft > 0 {
                    self.timeLeft -= 1
                }
            }
            .foregroundColor(.yellow)
            .frame(alignment: .leading)
            
            Text("Your Score: \(score)")
                .fontWeight(.heavy)
                .foregroundColor(.green)
                .font(.system(size: 40))
            
            
            Text("Does the bottom word+color match the definition?")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .font(.system(size: 25))
            
            Text("\(topColor.meaning)")
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .font(.system(size: 30))
            
            Text("\(bottomColor.meaning)")
                .fontWeight(.heavy)
                .foregroundColor(bottomColor.textColor)
                .font(.system(size: 30))
            
            HStack(alignment: .center, spacing: 20) {
                Button(action: {
                    answer = false
                    checkAnswers()
                }) {
                    Text("Nay")
                        .fontWeight(.heavy)
                        .font(.system(size: 70))
                }
                Button(action: {
                    answer = true
                    checkAnswers()
                }) {
                    Text("Yay")
                        .fontWeight(.heavy)
                        .font(.system(size: 70))
                }
            }
            .disabled(timeLeft == 0)
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                Button(action: {restartGame()}, label: {
                    Text("Restart")
                        .fontWeight(.heavy)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                        .background(Color.yellow)
                        .cornerRadius(5)
                })
            }
        }
        .frame(width: 420, height: 1000)
        .background(Color.red)
    }
    func checkAnswers(){
        if topColor == bottomColor && answer{
            score += 5
        }else if topColor != bottomColor && !answer{
            score += 5
        }else if topColor == bottomColor && !answer{
            score -= 5
        }else if topColor != bottomColor && answer{
            score -= 5
        }
        mixColors()
    }
    
    func mixColors() {
        topColor = ColorOption()
        bottomColor = ColorOption()
        displayColor = ColorOption()
    }
    
    func restartGame() {
        timeLeft = 90
        score = 0
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
