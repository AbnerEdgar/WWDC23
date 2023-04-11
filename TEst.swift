//
//  TEst.swift
//  Firefighter
//
//  Created by Abner Edgar on 09/04/23.
//

import SwiftUI

struct TEst: View {
    @State private var ballPosition = CGPoint(x: 50, y: 50)
        @State private var isMoving = false // to track if the ball should be moving or not

        var body: some View {
            VStack {
                Circle()
                    .fill(Color.red)
                    .frame(width: 50, height: 50)
                    .position(ballPosition)

                Button(action: {
                    withAnimation(.easeInOut(duration: 1)) {
                        // toggle the value of isMoving to start or stop the animation
                        isMoving.toggle()
                    }
                }, label: {
                    Text(isMoving ? "Stop" : "Start") // change the label of the button based on whether the ball is moving or not
                })
            }
            .animation(.easeInOut(duration: 1), value: ballPosition) // apply the animation to the ball's position
            .onAppear {
                // start the animation when the view appears
                withAnimation(.easeInOut(duration: 1)) {
                    isMoving = true
                }
            }
            .onChange(of: isMoving) { newValue in
                // when the isMoving value changes, update the ball's position accordingly
                if newValue {
                    ballPosition = CGPoint(x: 50, y: 50) // move the ball back to its starting position
                } else {
                    ballPosition = CGPoint(x: 200, y: 200) // move the ball to a new position
                }
            }
        }
}

struct TEst_Previews: PreviewProvider {
    static var previews: some View {
        TEst()
    }
}
