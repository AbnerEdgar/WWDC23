import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = GameController()
    let timer = Timer.publish(every: C.Water.Animate.refreshRate, on: .main, in: .common).autoconnect()
    let timer2  = Timer.publish(every: C.Fire.Animate.refreshRate, on: .main, in: .common).autoconnect()
    @State var page: Int = 1
    var body: some View {
        if page == 1{
            HomeView(page: $page)
                
        }else if page == 2{
            GameView(viewModel: viewModel)
                .onReceive(timer){ _ in
                    viewModel.updateBullets()
                }
                .onReceive(timer2){ _ in
                    viewModel.updateEnemies()
                }
            
        }
        
        
    }
}

struct HomeView: View{
    @Binding var page: Int
    @State var rotation: CGFloat = 180
    @State var titlePos: CGFloat = 0
    @State var buttonPos: CGFloat = UIScreen.main.bounds.height
    @State var opas: CGFloat = 0
    var body: some View{
        VStack{
            Spacer()
            HStack{
                Text("FIREFIGHTER.")
                    .foregroundColor(.brown)
                    .font(.system(size: 60, weight: .light))
                    .position(x:UIScreen.main.bounds.width/2, y:titlePos)
                    .animation(.easeInOut(duration: 0.5),
                               value: titlePos)
            }
            Spacer()
            HStack{
                Spacer()
                Button{
                    page = 2
                }label: {
                    HStack{
                        Text("LET'S PLAY!")
                            .foregroundColor(.white)
                            .font(.system(size: 30, weight: .light))
                    }
                    .frame(width:200,height:50)
                    .background(.orange)
                    .padding(.all,5)
                    .cornerRadius(20)
                    .rotationEffect(Angle(degrees: Double(rotation)))
                    .position(x: UIScreen.main.bounds.width/2, y: buttonPos)
                    .animation(.easeInOut(duration: 1.2),
                               value:  rotation)
                    .animation(.easeInOut(duration: 0.8),
                               value:  buttonPos)
                }
                Spacer()
            }
            Spacer()
            HStack{
                VStack{
                    Text("WWDC 23")
                        .foregroundColor(.white)
                        .font(.system(size: 50, weight: .ultraLight))
                    Text("ABNER EDGAR")
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .light))
                }
            }
            .frame(width:300,height:150)
            .cornerRadius(100)
            .padding(.all,5)
            .onAppear{
                withAnimation(Animation.linear(duration: 0.6)
                    .repeatForever(autoreverses: true)) {
                        opas += 0.8
                    }
            }
            .opacity(opas)
            Spacer()
        }
        .onAppear{
            animate()
        }
    }
    func animate() -> (){
        rotation = rotation > 0 ? rotation-2 : 0
        titlePos = titlePos <= 300 ? 300 : titlePos-5
        buttonPos = buttonPos <= 100 ? 100 : buttonPos-5
        DispatchQueue.main.async{
            self.animate()
        }
    }
}

struct GameView: View{
    @ObservedObject var viewModel: GameController
    var body: some View{
        ZStack{
            BackgroundView(viewModel: viewModel)
            EffectsView(viewModel: viewModel)
            PlayerView(viewModel: viewModel)
            BulletView(viewModel: viewModel)
            FireView(viewModel: viewModel)
//            Text("\(viewModel.playerPosition.x) \("Test") \(viewModel.Fire[0].limitRight(playerPosition: viewModel.playerPosition))")
//                .font(.largeTitle)
//                .padding(.top, 900)
            PlayerControlView(viewModel: viewModel)
            Rectangle()
                .frame(width:viewModel.screenWidth,height: 100)
                .position(x:viewModel.screenWidth/2,y:viewModel.screenVertical)
        }
        .frame(width: C.width,
               height: C.height)
        .onAppear{
            if viewModel.start{
                viewModel.dialog = C.Text.firstTime
                viewModel.showDialog = true
            }
        }
    }
}

struct BackgroundView: View{
    @ObservedObject var viewModel: GameController
    var body: some View{
        VStack {
            Image(C.Background.BG)
                .resizable()
                .frame(width: C.Background.width,
                       height: C.Background.height)
                .position(viewModel.playerPosition)
        }
        .animation(.easeInOut(duration: C.Background.Animate.ease),
                   value:  viewModel.playerPosition)
    }
}

struct BulletView: View{
    @ObservedObject var viewModel: GameController
    var body: some View{
        ForEach(viewModel.Water){ water in
            Image(water.getImage())
                .position(water.getPos())
                .animation(.easeInOut(duration: C.Water.Animate.ease),
                           value:water.getXPos())
        }
    }
}
 
  
struct FireView: View{
    @ObservedObject var viewModel: GameController
    var body: some View{
        ForEach(viewModel.Fire){ fire in
            if fire.isStillAlive() {
                Image(fire.getImage())
                    .resizable()
                    .onAppear{
                        viewModel.updateEnemyPos()
                    }
                    .frame(width: viewModel.getFrameWidth(fire: fire),
                           height: viewModel.getFrameHeight(fire: fire))
                    .position(fire.getPos())
                    .animation(.easeInOut(duration: C.Fire.Animate.ease),
                               value: fire.getXPos())
            }
        }
    }
}
