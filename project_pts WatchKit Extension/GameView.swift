//
//  GameView.swift
//  project_pts WatchKit Extension
//
//  Created by John Perez on 2/6/22.
//

import SwiftUI

struct GameView: View {
    @Binding var scoreLimit: Int
    @Binding var serving: Bool
    @Binding var blueWins: Int
    @Binding var redWins: Int
    @State var redPoints: Int = 0
    @State var bluePoints: Int = 0
    @State var firstServe: Bool = false
    
    // function to increment score and swap the server when needed
    func update_score(blueWin: Bool) -> () {
        if (redPoints == 0 && bluePoints == 0) {
            firstServe = serving
        }
        
        if (blueWin) {
            bluePoints += 1
        } else {
            redPoints += 1
        }
        
        if (scoreLimit == 11) {
            if ((redPoints + bluePoints) % 2 == 0) {
                serving = !serving
            }
        } else {
            if ((redPoints + bluePoints) % 5 == 0) {
                serving = !serving
            }
        }
        
        if (redPoints >= scoreLimit && redPoints-2 >= bluePoints) {
            update_wins(blueWin: false)
        } else if (bluePoints >= scoreLimit && bluePoints-2 >= redPoints) {
            update_wins(blueWin: true)
        }
    }
    
    // increment wins
    func update_wins(blueWin: Bool) -> () {
        if (blueWin) {
            blueWins += 1
        } else {
            redWins += 1
        }
    }
    
    //resets game scores
    func reset_score() -> () {
        redPoints = 0
        bluePoints = 0
        serving = !firstServe
    }
    
    var body: some View {
        //3 options, blue win screen, red win screen, game going on 
        if (redPoints >= scoreLimit && redPoints-2 >= bluePoints) {
            VStack() {
                Text("You lost :(")
                Text(String(blueWins) + " - " + String(redWins))
                Button(action: {reset_score()}, label: {Text("New Game")}).padding(.top, 5.0)
            }
            
        } else if (bluePoints >= scoreLimit && bluePoints-2 >= redPoints) {
            VStack() {
                Text("You won!")
                Text(String(blueWins) + " - " + String(redWins))
                Button(action: {reset_score()}, label: {Text("New Game")}).padding(.top, 5.0)
            }
           
        } else {
            VStack(spacing: 5) {
                ZStack() {
                    Button(action: {update_score(blueWin: false)}) {
                        Text(String(redPoints))
                            .padding(.vertical, 30.0)
                            .frame(width: 170.0)
                            .background(Color.red)
                            .cornerRadius(20)
                    }
                        .padding(.top, 20)
                        .buttonStyle(PlainButtonStyle())
                    if (!serving) {
                        Circle()
                            .frame(width: 15, height: 15)
                            .padding(.trailing, 120.0)
                            .padding(.top, 20.0)
                    }
                }
                ZStack() {
                    Button(action: {update_score(blueWin: true)}) {
                        Text(String(bluePoints))
                            .padding(.vertical, 30.0)
                            .frame(width: 170.0)
                            .background(Color.blue)
                            .cornerRadius(20)
                    }
                        .buttonStyle(PlainButtonStyle())
                    if (serving) {
                        Circle()
                            .frame(width: 15, height: 15)
                            .padding(.trailing, 120.0)
                    }
                }
            }
                .navigationTitle("ScoreKeeper")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(scoreLimit: .constant(11), serving: .constant(true), blueWins: .constant(69), redWins: .constant(27))
    }
}
