//
//  PlayerLivesView.swift
//  Firefighter
//
//  Created by Abner Edgar on 16/04/23.
//

import SwiftUI

struct PlayerLivesView: View {
    @ObservedObject var viewModel: GameController
    var body: some View {
        HeartView(live: 2, offset: 0, viewModel: viewModel)
        HeartView(live: 1, offset: 70, viewModel: viewModel)
        HeartView(live: 3, offset: -70, viewModel: viewModel)
    }
}

struct HeartView: View {
    let live: Int
    let offset: CGFloat
    @ObservedObject var viewModel: GameController
    var body: some View {
        Image(viewModel.isMoreThan(live: live))
            .position(x:viewModel.getXPosLive(offset: offset),
                      y: viewModel.getYPosLive())
            .opacity(viewModel.getOpacityLive(live: live))
    }
}
