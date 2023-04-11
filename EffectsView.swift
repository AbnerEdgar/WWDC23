//
//  EffectsView.swift
//  Firefighter
//
//  Created by Abner Edgar on 16/04/23.
//

import SwiftUI

struct EffectsView: View {
    @ObservedObject var viewModel: GameController
    var body: some View {
        RectangleView()
        .frame(width:C.Stairs.stairWidth,
               height:C.Stairs.stairHeight)
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 0.8)
                .repeatForever(autoreverses: true)) {
                    viewModel.opac += 0.05
                }
            viewModel.doorUpPosChange()
        }
        .opacity(viewModel.opac)
        .position(viewModel.doorUpPos)
        .animation(.easeInOut(duration: 0.19), value:  viewModel.doorUpPos.x)

        Rectangle()
            .fill(.white)
        .frame(width: 365,height: 740)
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 0.8)
                .repeatForever(autoreverses: true)) {
                    viewModel.opac += 0.05
                }
            viewModel.doorDownPosChange()
        }
        .opacity(viewModel.opac)
        .position(viewModel.doorDownPos)
        .animation(.easeInOut(duration: 0.2), value:  viewModel.doorDownPos.x)
    }
}
