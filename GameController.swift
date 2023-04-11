//
//  PlayerController.swift
//  Firefighter
//
//  Created by Abner Edgar on 16/04/23.
//

import Foundation
import SwiftUI

class GameController: ObservableObject {
    @Published var speed: Double = 0
    @Published var left: Bool = true
    @Published var spriteViewPosition: CGPoint = CGPoint(x: 1300,
                y: 610)
    @Published var number: Int = 0 
    @Published var isPressing: Bool = false
    @Published var health: Int = 3
    @Published var playerPosition: CGPoint = CGPoint(x:-2300,
                y:-900)
    @Published var floor: Int = 0
    @Published var opac: CGFloat = 0.1
    @Published var doorUpPos: CGPoint = CGPoint(x: -3345, y: 1470)
    @Published var doorDownPos: CGPoint = CGPoint(x: -3345, y: 415)
    @Published var isShooting: Bool = false
    @Published var Water: [Bullet] = []
    @Published var currentAngle: Float = 0.3
    @Published var holdDur: Int = 0
    @Published var screenWidth = UIScreen.main.bounds.width
    @Published var screenVertical = UIScreen.main.bounds.height
    @Published var waterTank = 1000
    @State var limitY: CGFloat = 8000
    @Published var Fire: [Enemy] = Enemy(enemyPos:CGPoint(x: 0, y: 0)).spawnEnemies()
    @Published var rotation: CGFloat = 90
    @Published var showDialog: Bool = false
    @Published var start: Bool = true
    @Published var dialog: String = ""
    @Published var fireTime: Bool = true
    @Published var hoseTime: Bool = true
    @Published var stairTime: Bool = true
    @Published var completeTime: Bool = true
    func doorUpPosChange() -> (){
        doorUpPos = CGPoint(x: C.Stairs.doorPos[floor][0].x + playerPosition.x,
                            y: playerPosition.y + C.Stairs.doorPos[floor][0].y)
        DispatchQueue.main.async{
            self.doorUpPosChange()
        }
    }
    func doorDownPosChange() -> (){
        doorDownPos = CGPoint(x: C.Stairs.doorPos[floor][1].x + playerPosition.x,
                              y: playerPosition.y + C.Stairs.doorPos[floor][1].y)
        DispatchQueue.main.async{
            self.doorDownPosChange()
        }
    }
    
    func reduceRotation() -> (){
        rotation = rotation > 0 ? rotation-5 : 0
        DispatchQueue.main.async{
            self.reduceRotation()
        }
    }
    
    func updateEnemyPos(){
        for i in 0..<Fire.count{
            if Fire[i].health > 0{
                Fire[i].enemyPos = CGPoint(x:C.Fire.fire_coor[i].x+playerPosition.x,
                                           y:C.Fire.fire_coor[i].y+playerPosition.y)
            }
        }
        DispatchQueue.main.async {
            self.updateEnemyPos()
        }
    }
    
    func decrementNumber() -> (){
        guard isPressing else { return }
        playerPosition.x = playerPosition.x >= 4500 ?
            4500 : playerPosition.x + CGFloat(speed)
        number += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.085) {
            self.decrementNumber()
        }
    }
    
    func incrementNumber() -> (){
        guard isPressing else { return }
        playerPosition.x = playerPosition.x <= -2300 ?
            -2300 : playerPosition.x - CGFloat(speed)
        number += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.085) {
            self.incrementNumber()
        }
    }
    
    func shootLeft() -> (){
        guard isShooting else { return }
        Water.append(Bullet(bulletPos: CGPoint(x:spriteViewPosition.x-640,y:spriteViewPosition.y-40)))
        holdDur += 1
        if holdDur > 3 {
            currentAngle = currentAngle <= 0.1 ? 0.1 : currentAngle-0.05
        } 
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.018) {
            self.shootLeft()
        }
    }
    func shootRight() -> (){
        guard isShooting else { return }
        Water.append(Bullet(bulletPos: CGPoint(x:spriteViewPosition.x-160,y:spriteViewPosition.y-40),inverse: -1))
        holdDur += 1
        if holdDur > 3 {
            currentAngle = currentAngle <= 0.1 ? 0.1 : currentAngle-0.05
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.018) {
            self.shootRight()
        }
    }
    
    func updateBullets() -> (){
        for i in 0..<Water.count {
            Water[i].move(nangle: currentAngle)
            for j in 0..<Fire.count {
                guard Fire[j].health > 0 else { continue }
                if(checkCollision(water: Water[i],fire: Fire[j]) && C.Fire.fire_coor[j].y == getLimitFloor()){
                    Fire[j].health = Fire[j].health < 0 ? 0 : Fire[j].health - 1
                    Water[i].bulletPos.y = limitY
                }
            }
        }
        if floor == 0 {
            limitY = 8000
        }else if floor == 1 {
            limitY = 5000
        }
        Water = Water.filter { bullet in
            return bullet.bulletPos.y < limitY && (bullet.realPosL(playerPos: playerPosition).x < 4650)
            }
    }
    
    func getLimitFloor() -> CGFloat{
        return floor == 0 ? 1600 : floor == 1 ? 545 : -505
    }
    
    func updateEnemies() -> (){
        for i in 0..<Fire.count {
            Fire[i].stage = Fire[i].stage >= 2 ? 0 : Fire[i].stage+1
            if C.Fire.fire_coor[i].y == getLimitFloor() && checkCollision(player: playerPosition, fire: Fire[i]){
                health -= 1
                resetPlayerPos()
                if health < 1 {
                    resetGame()
                }
            }
        }
    }
    
    func resetPlayerPos() -> (){
        if floor == 0{
            playerPosition.x = -2300
            dialog = C.Text.ouch
            rotation = 90
            showDialog = true
        }else if floor == 1 {
            playerPosition.x = 4200
            dialog = C.Text.ouch
            rotation = 90
            showDialog = true
        }else if floor == 2 {
            playerPosition.x = -1100
            dialog = C.Text.ouch
            rotation = 90
            showDialog = true
        }
    }
    
    func resetGame(){
        speed = 0
        left = true
        spriteViewPosition = CGPoint(x: 1300,
                                     y: 610)
        number = 0
        isPressing = false
        health = 3
        playerPosition = CGPoint(x:-2300,
                                 y:-900)
        floor = 0
        opac = 0.1
        doorUpPos = CGPoint(x: -3345, y: 1470)
        doorDownPos = CGPoint(x: -3345, y: 415)
        isShooting = false
        Water = []
        currentAngle = 0.3
        holdDur = 0
        waterTank = 1000
        limitY = 8000
        Fire = Enemy(enemyPos:CGPoint(x: 0, y: 0)).spawnEnemies()
        rotation = 90
        showDialog = false
        start = true
        dialog = ""
        fireTime = true
        hoseTime = true
        stairTime = true
        completeTime = true
    }
    
    func checkCollision(water: Bullet, fire: Enemy) -> Bool{
        if left {
            return water.realPosL(playerPos: playerPosition).x > fire.limitRight(playerPosition: playerPosition) && water.realPosL(playerPos: playerPosition).x+200 < fire.limitLeft(playerPosition: playerPosition)
        }else {
            return water.realPosR(playerPos: playerPosition).x > fire.limitRight(playerPosition: playerPosition) && water.realPosR(playerPos: playerPosition).x < fire.limitLeft(playerPosition: playerPosition)
        }
        
    }
    
    func checkCollision(player: CGPoint, fire: Enemy) -> Bool{
        return (player.x+200 > fire.limitRight(playerPosition: playerPosition) && player.x+200 < fire.limitLeft(playerPosition: playerPosition))
    }
    
    func getFrameWidth(fire: Enemy) -> CGFloat{
        return CGFloat(4 * fire.health)
    }
    
    func getFrameHeight(fire: Enemy) -> CGFloat{
        return CGFloat(5 * fire.health)
    }
        
    func getPlayerImage() -> String{
        return !isPressing ? C.Player.Animate.idle : C.Player.Animate.sprint[number%5]
    }
    
    func getPlayerWidth() -> CGFloat{
        return !isPressing ? 350 : C.Player.Animate.sprintSize[number%5].x
    }
    
    func getRotationYAxis() -> CGFloat{
        return left ? 0 : 1
    }
    
    func getSpritePosition() -> CGPoint{
        return CGPoint(x:spriteViewPosition.x - 400, y:spriteViewPosition.y)
    }
    
    func isLobby() -> Bool{
        return floor == 0
    }
    
    func isFirstFloor() -> Bool{
        return floor == 1
    }
    
    func isSecondFloor() -> Bool{
        return floor == 2
    }
    
    func gotoLobby() -> (){
        floor = 0
        playerPosition.y = -900
    }
    
    func gotoFirstFloor() -> (){
        floor = 1
        playerPosition.y = 145
    }
    
    func gotoSecondFloor() -> (){
        floor = 2
        playerPosition.y = 1190
    }
    
    func toggleDownStair() -> (){
        if isFirstFloor() && playerPosition.x < 4500 && playerPosition.x > 4000{
            gotoLobby()
        }else if isSecondFloor() && playerPosition.x < -700 && playerPosition.x > -1400{
            gotoFirstFloor()
        }
    }
    
    func toggleUpStair() -> (){
        if isLobby() && playerPosition.x < 4500 && playerPosition.x > 4000{
            gotoFirstFloor()
        }else if isFirstFloor() && playerPosition.x < -700 && playerPosition.x > -1400{
            gotoSecondFloor()
        }
    }
    
    func withinRange() -> Bool{
        return (playerPosition.x < 4500 && playerPosition.x > 4000) || (playerPosition.x < -900 && playerPosition.x > -1400) || (playerPosition.x < -1600 && playerPosition.x > -2000)
    }
    
    func getHosePos() -> CGPoint{
        return CGPoint(x: left ? spriteViewPosition.x-80 : spriteViewPosition.x-510,
                       y: spriteViewPosition.y+165)
    }
    
    func isMoreThan(live: Int) -> String{
        return health >= live ? C.Live.live_alive : C.Live.live_dead
    }
    
    func getXPosLive(offset: CGFloat) -> CGFloat{
        return (left ? spriteViewPosition.x-(400+offset) : spriteViewPosition.x-(400+offset)) + (speed > 0 ? left ? -50 : 50 : 0)
    }
    
    func getYPosLive() -> CGFloat{
        return spriteViewPosition.y-380
    }
    
    func getOpacityLive(live: Int) -> CGFloat{
        return health >= live ? 0.9 : 0.5
    }
    
}
