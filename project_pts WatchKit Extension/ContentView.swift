//
//  ContentView.swift
//  project_pts WatchKit Extension
//
//  Created by John Perez on 12/28/21.
//

import SwiftUI


struct ContentView: View {
    
    @State var inGame: Bool = false
    @State var scoreLimit: Int = 11
    @State var servingFirst: Bool = true
    @AppStorage("redWins") var redWins: Int = 0
    @AppStorage("blueWins") var blueWins: Int = 0
    
    func reset_match() {
        blueWins = 0
        redWins = 0
    }
    
    var body: some View {

        NavigationView {
            ScrollView {
                VStack() {
                    Text("playing to:")
                    HStack() {
                        Button(action: {scoreLimit = 11}) {
                            Text("11")
                        }
                            .background(scoreLimit == 11 ? Color.blue : Color.black)
                            .cornerRadius(15)
                        Button(action: {scoreLimit = 21}) {
                            Text("21")
                        }
                            .background(scoreLimit == 21 ? Color.blue : Color.black)
                            .cornerRadius(15)
                    }
                    Text("serving first:")
                    HStack() {
                        Button(action: {servingFirst = true}) {
                            Text("you")
                        }
                            .background(servingFirst ? Color.blue : Color.black)
                            .cornerRadius(15)
                        Button(action: {servingFirst = false}) {
                            Text("them")
                        }
                            .background(servingFirst ? Color.black : Color.blue)
                            .cornerRadius(15)
                    }
                    NavigationLink("start game", destination: GameView(
                        scoreLimit: $scoreLimit,
                        serving: $servingFirst,
                        blueWins: $blueWins,
                        redWins: $redWins))
                        .padding(.vertical, 5.0)
                    Text("current match: " + String(blueWins) + "-" + String(redWins) )
                    Button(action: {reset_match()}, label: {Text("reset match")})
                }
            }
                .navigationBarTitle("ScoreKeeper")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}


