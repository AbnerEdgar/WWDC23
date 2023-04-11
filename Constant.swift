//
//  Constant.swift
//  Firefighter
//
//  Created by Abner Edgar on 08/04/23.
//

import Foundation

struct C{ 
    
    struct Background{
        static let BG: String = "Game_1"
        static let width: CGFloat = 8578
        static let height: CGFloat = 3764
        struct Animate{
            static let ease: CGFloat = 0.19
        }
    }
    
    static let width: CGFloat = 214.9
    static let height: CGFloat = 280.6
    
    struct Player{
        static let rotation: CGFloat = 180
        static let rotationX: CGFloat = 0
        static let rotationZ: CGFloat = 0
        static let height:CGFloat = 700
        struct Hose{
            static let hose: String = "Firefighter_WH"
            static let width: CGFloat = 1100
            static let height: CGFloat = 530
        }
        struct Animate{
            static let idle: String = "Firefighter_IdleWH"
            static let sprint: [String] = ["Firefighter_1",
                                           "Firefighter_2",
                                           "Firefighter_3",
                                           "Firefighter_4",
                                           "Firefighter_5"]
            static let sprintSize: [CGPoint] = [CGPoint(x: 350, y: 700),
                                                CGPoint(x: 400, y: 700),
                                                CGPoint(x: 460, y: 700),
                                                CGPoint(x: 450, y: 750),
                                                CGPoint(x: 450, y: 720)]
        }
    }
    struct Live{
        static let live_alive: String = "Live_Alive"
        static let live_dead: String = "Live_Dead"
    }
    struct Water{
        struct Animate{
            static let water_animate: [String] = ["Water_Small",
                                                  "Water_Medium",
                                                  "Water_Big"]
            static let refreshRate: CGFloat = 0.009
            static let ease: CGFloat = 0.8
        }
    }
    struct Fire{
        static let fire_coor: [CGPoint] = [CGPoint(x: -2010, y: 1600),
                                           CGPoint(x: -1570, y: 1600),
                                           CGPoint(x: -1025, y: 545),
                                           CGPoint(x: -440, y: 545),
                                           CGPoint(x: 8, y: 545),
                                           CGPoint(x: -65, y: -505),
                                           CGPoint(x: -1415, y: -505),
                                           CGPoint(x: -1850, y: -505),
                                           CGPoint(x: -2640, y: -505)]
        struct Animate{
            static let fire_animate: [String] = ["Fire_1","Fire_2","Fire_3"]
            static let refreshRate: CGFloat = 0.12
            static let ease: CGFloat = 0.2
        }
    }
    struct Stairs{
        static let stairWidth: CGFloat = 365
        static let stairHeight: CGFloat = 740
        
        static let opacity: CGFloat = 0.1
        static let doorPos: [[CGPoint]] = [[CGPoint(x:-3345,y:1470),CGPoint(x:-3345,y:412)],
                                           [CGPoint(x:2010,y:427),CGPoint(x:-3345,y:427)],
                                           [CGPoint(x:2010,y:427),CGPoint(x:1970,y:-620)]]
        struct Animate{
            static let ease: CGFloat = 0.2
        }
    }
    struct Text{
        static let ouch: String = "Ouch! That hurts!\nBe careful!"
        static let firstTime: String = "Hello there, I'm Mike! \nCan you assist me in putting \nout all the fires inside the building?"
        static let moveTime: String = "Use the left and right edges of \nthe screen to navigate and move around!"
        static let fireTime: String = "Be cautious, there are fires ahead!"
        static let hoseTime: String = "Tap and hold the hose in my hand, to release water!"
        
        static let stairTime: String = "Hey, look! There's a staircase. Let's hurry and ascend to the next floor!"
        static let completeTime: String = "Well Done! \nI think all the fires are extinguished! \nLet's head back to base!"
        static let fireAnother: String = "Nice! Let's continue extinguishing!"
    }
}
