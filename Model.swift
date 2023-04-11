//
//  Model.swift
//  Firefighter
//
//  Created by Abner Edgar on 16/04/23.
//

import Foundation

struct Bullet: Identifiable{
    let id: UUID = UUID()
    let speed: CGFloat = 20
    var bulletPos: CGPoint
    var stage: Int = 0
    var mult: Float = 0.08
    var inverse: CGFloat = 1
    var image: String {
        return C.Water.Animate.water_animate[stage]
    }
    mutating func move(nangle: Float = 0.35) -> (){
        bulletPos.x -= speed*inverse
        bulletPos.y += speed * CGFloat(mult)
        mult += mult*nangle
    }
    func realPosL(playerPos: CGPoint) -> CGPoint{
        return CGPoint(x:(playerPos.x+400)-bulletPos.x,y:0)
    }
    func realPosR(playerPos: CGPoint) -> CGPoint{
        return CGPoint(x:(playerPos.x+600)-bulletPos.x,y:0)
    }
    func getImage() -> String{
        return image
    }
    func getPos() -> CGPoint{
        return bulletPos
    }
    func getXPos() -> CGFloat{
        return bulletPos.x
    }
    func getYPos() -> CGFloat{
        return bulletPos.y
    }
} 
 
struct Enemy: Identifiable{
    let id: UUID = UUID()
    var health: Float = 100
    var enemyPos: CGPoint
    var stage: Int = 0
    var image: String {
        return C.Fire.Animate.fire_animate[stage]
    }
    func spawnEnemies() -> [Enemy]{
        var temp: [Enemy] = []
        for i in 0..<C.Fire.fire_coor.count {
            temp.append(Enemy(enemyPos: C.Fire.fire_coor[i]))
        }
        return temp
    }
    func limitLeft(playerPosition: CGPoint) -> CGFloat{
        return playerPosition.x-enemyPos.x + 1200 + (100*CGFloat(health)/100)
    }
    func limitRight(playerPosition: CGPoint) -> CGFloat{
        return playerPosition.x-enemyPos.x + 700
    }
    func isStillAlive() -> Bool {
        return health>0
    }
    func getXPos() -> CGFloat{
        return enemyPos.x
    }
    func getYPos() -> CGFloat{
        return enemyPos.y
    }
    func getPos() -> CGPoint{
        return enemyPos
    }
    func getImage() -> String{
        return image
    }
}
