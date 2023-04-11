//
//  EnemyView.swift
//  Firefighter
//
//  Created by Abner Edgar on 18/04/23.
//

import SwiftUI

struct EnemyView: View {
    let enemyPos:CGPoint
    var enemyA: Enemy { Enemy(enemyPos: enemyPos, stage: 0) }
    var body: some View {
        Image(enemyA.image)
    }
}

struct EnemyView_Previews: PreviewProvider {
    static var previews: some View {
        EnemyView(enemyPos: CGPoint(x: 100, y: 100))
    }
}
