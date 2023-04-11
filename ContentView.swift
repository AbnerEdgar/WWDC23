import SwiftUI
struct ContentView: View {
    @State var number: Int = 0
    @State var isPressing: Bool = false
    @State var playerPosition: CGPoint = CGPoint(x:-2800,y:-700)
    @State var speed: Double = 0
    var body: some View {
        ZStack{
            VStack {
                Image(C.BG)
                    .resizable()
                    .frame(width: 8578, height: 3764)
                    .position(playerPosition)
                Text("\(number)")
                    .font(.largeTitle)
                    .padding()
            }
            .animation(.easeInOut(duration: 1), value: playerPosition.x)
            Image(C.player)
                .resizable()
                .frame(width: 800, height: 800)
                .position(x:640, y:910) 
            Button("Left") {
                number -= 1
            }
            .padding()
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if !isPressing {
                            isPressing = true
                            speed = 30
                            self.decrementNumber()
                        }
                    }
                    .onEnded { _ in
                        isPressing = false
                        speed = 0
                        
                    }
            )
        }
        
    }
    
    func decrementNumber() {
            guard isPressing else { return }
            playerPosition.x += CGFloat(speed)
            withAnimation(Animation.linear(duration: 0.1)) {
                playerPosition = CGPoint(x: playerPosition.x, y: playerPosition.y)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.decrementNumber()
            }
        }
}



