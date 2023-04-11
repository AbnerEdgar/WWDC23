//
//  StairsView.swift
//  Firefighter
//
//  Created by Abner Edgar on 18/04/23.
//

import SwiftUI

struct StairsView: View {
    @ObservedObject var viewModel: GameController
    var body: some View {
        Text("\(viewModel.floor+1)\(viewModel.floor==0 ? "st":viewModel.floor==1 ? "nd":"rd") Floor")
            .font(.system(size: 20,weight: .light))
            .position(x:viewModel.doorUpPos.x,
                      y:viewModel.doorUpPos.y-395)
            .foregroundColor(.white)
            .animation(.easeInOut(duration: C.Stairs.Animate.ease),
                       value: viewModel.doorUpPos.x)
        Text("\(viewModel.floor+1)\(viewModel.floor==0 ? "st":viewModel.floor==1 ? "nd":"rd") Floor")
            .font(.system(size: 20,weight: .light))
            .position(x:viewModel.doorDownPos.x,
                      y:viewModel.doorDownPos.y-395)
            .foregroundColor(.white)
            .animation(.easeInOut(duration: C.Stairs.Animate.ease),
                       value: viewModel.doorDownPos.x)
        Button{
            viewModel.toggleUpStair()
        }label: {
            RectangleView()
        }
        .frame(width:C.Stairs.stairWidth,
               height:C.Stairs.stairHeight)
        .opacity(C.Stairs.opacity)
        .onAppear {
            viewModel.doorUpPosChange()
        }
        .position(viewModel.doorUpPos)
        .animation(.easeInOut(duration: C.Stairs.Animate.ease),
                   value: viewModel.doorUpPos.x)
        
        Button{
            viewModel.toggleDownStair()
        }label: {
            RectangleView()
        }
        .frame(width:C.Stairs.stairWidth,
               height:C.Stairs.stairHeight)
        .opacity(C.Stairs.opacity)
        .onAppear {
            viewModel.doorDownPosChange()
        }
        .position(viewModel.doorDownPos)
        .animation(.easeInOut(duration: C.Stairs.Animate.ease),
                   value: viewModel.doorDownPos.x)
    }
}


struct RectangleView: View {
    var body: some View {
        Rectangle().fill(.white)
    }
}
