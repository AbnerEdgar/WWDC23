//
//  PlayerView.swift
//  Firefighter
//
//  Created by Abner Edgar on 16/04/23.
//

import SwiftUI

struct PlayerView: View {
    @ObservedObject var viewModel: GameController
    var body: some View {
        if viewModel.showDialog{
            DialogView(viewModel: viewModel)
        }
        
        Image(viewModel.getPlayerImage())
            .resizable()
            .frame(width: viewModel.getPlayerWidth(),
                   height: C.Player.height)
            .rotation3DEffect(
                .degrees(C.Player.rotation),
                axis: (x: C.Player.rotationX,
                       y: viewModel.getRotationYAxis(),
                       z: C.Player.rotationZ))
            .position(x:viewModel.getSpritePosition().x,
                      y: viewModel.getSpritePosition().y)
        if !viewModel.withinRange() && !viewModel.start{
            Button{
                if viewModel.showDialog{
                    viewModel.showDialog = false
                }
            }label: {
                if !viewModel.isPressing{
                    Image(C.Player.Hose.hose)
                        .resizable()
                        .frame(width:C.Player.Hose.width,
                               height: C.Player.Hose.height)
                        .position(x:viewModel.getHosePos().x,
                                  y:viewModel.getHosePos().y)
                        .rotation3DEffect(
                            .degrees(C.Player.rotation),
                            axis: (x: C.Player.rotationX,
                                   y: viewModel.getRotationYAxis(),
                                   z: C.Player.rotationZ))
                }
            }
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if !viewModel.isShooting && !viewModel.isPressing{
                            viewModel.isShooting = true
                            if viewModel.left {
                                viewModel.shootLeft()
                            }else{
                                viewModel.shootRight()
                            }
                        }
                    }
                    .onEnded { _ in
                        viewModel.isShooting = false
                        viewModel.holdDur = 0
                        viewModel.currentAngle = 0.3
                    }
            )
        }else if !viewModel.isPressing{
            Image(C.Player.Hose.hose)
                .resizable()
                .frame(width:C.Player.Hose.width,
                       height: C.Player.Hose.height)
                .position(x:viewModel.getHosePos().x,
                          y:viewModel.getHosePos().y)
                .rotation3DEffect(
                    .degrees(C.Player.rotation),
                    axis: (x: C.Player.rotationX,
                           y: viewModel.getRotationYAxis(),
                           z: C.Player.rotationZ))
        }
        StairsView(viewModel: viewModel)
        PlayerLivesView(viewModel: viewModel)
        
    } 
}
