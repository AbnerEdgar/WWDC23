//
//  DialogView.swift
//  Firefighter
//
//  Created by Abner Edgar on 20/04/23.
//

import SwiftUI

struct DialogView: View {
    @ObservedObject var viewModel: GameController
    var body: some View {
        Button{
        }label: {
            ZStack{
                Background()
                Text(viewModel.dialog)
                    .foregroundColor(.white)
            }
            .frame(width: 250,height: 120)
            .position(x:viewModel.spriteViewPosition.x-550, y: viewModel.spriteViewPosition.y-285)
            .onAppear{
                viewModel.reduceRotation()
            }
            .rotationEffect(Angle(degrees: Double(viewModel.rotation)))
            .animation(.easeInOut(duration: 0.8),
                       value:  viewModel.rotation)
            
        }
    }
}

struct Background: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.orange)
    }
}
