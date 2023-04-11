//
//  PlayerControlView.swift
//  Firefighter
//
//  Created by Abner Edgar on 16/04/23.
//

import SwiftUI

struct PlayerControlView: View{
    @ObservedObject var viewModel: GameController
    var body: some View {
        HStack{
            Button{
                viewModel.showDialog = false
                if viewModel.start {
                    viewModel.start = false
                    viewModel.dialog = C.Text.moveTime
                    viewModel.showDialog = false
                    viewModel.rotation = 90
                    viewModel.showDialog = true
                }
                if viewModel.playerPosition.x > 1500 && viewModel.fireTime {
                    viewModel.fireTime = false
                    viewModel.dialog = C.Text.fireTime
                    viewModel.rotation = 90
                    viewModel.showDialog = true
                }else if viewModel.playerPosition.x > 1500 && !viewModel.fireTime  && viewModel.hoseTime{
                    viewModel.hoseTime = false
                    viewModel.dialog = C.Text.hoseTime
                    viewModel.rotation = 90
                    viewModel.showDialog = true
                }else if viewModel.playerPosition.x > 3300 && viewModel.stairTime {
                    viewModel.stairTime = false
                    viewModel.dialog = C.Text.stairTime
                    viewModel.rotation = 90
                    viewModel.showDialog = true
                }else if viewModel.playerPosition.x > 3300 && viewModel.floor == 2 && viewModel.completeTime && viewModel.health > 0{
                    viewModel.completeTime = false
                    viewModel.dialog = C.Text.completeTime
                    viewModel.rotation = 90
                    viewModel.showDialog = true
                }
            }label: {
                ExpandView()
            }
            .padding()
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if !viewModel.isPressing && !viewModel.isShooting{
                            viewModel.left = true
                            viewModel.isPressing = true
                            viewModel.speed = 100
                            viewModel.decrementNumber()
                        }
                    }
                    .onEnded { _ in
                        viewModel.isPressing = false
                        viewModel.speed = 0
                        viewModel.number = 0
                    }
            )
            Spacer()
            Button{
                viewModel.showDialog = false
                if viewModel.start {
                    viewModel.start = false
                    viewModel.showDialog = false
                }
                if viewModel.playerPosition.x > 1500 && viewModel.fireTime {
                    viewModel.fireTime = false
                    viewModel.dialog = C.Text.fireTime
                    viewModel.rotation = 90
                    viewModel.showDialog = true
                }else if viewModel.playerPosition.x > 1500 && !viewModel.fireTime  && viewModel.hoseTime{
                    viewModel.hoseTime = false
                    viewModel.dialog = C.Text.hoseTime
                    viewModel.rotation = 90
                    viewModel.showDialog = true
                }else if viewModel.playerPosition.x > 3300 && viewModel.stairTime {
                    viewModel.stairTime = false
                    viewModel.dialog = C.Text.stairTime
                    viewModel.rotation = 90
                    viewModel.showDialog = true
                }else if viewModel.playerPosition.x > 3300 && viewModel.floor == 2 && viewModel.completeTime && viewModel.health > 0{
                    viewModel.completeTime = false
                    viewModel.dialog = C.Text.completeTime
                    viewModel.rotation = 90
                    viewModel.showDialog = true
                }
            }label: {
                ExpandView()
            }
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if !viewModel.isPressing && !viewModel.isShooting{
                            viewModel.left = false
                            viewModel.isPressing = true
                            viewModel.speed = 100
                            viewModel.incrementNumber()
                        }
                    }
                    .onEnded { _ in
                        viewModel.isPressing = false
                        viewModel.speed = 0
                        viewModel.number = 0
                    }
            )
        }
        .frame(width: viewModel.screenWidth, height: viewModel.screenVertical)
    }
}

struct ExpandView: View {
    var body: some View {
        VStack{
            Spacer()
        }
        .frame(width: 200)
    }
    
}
