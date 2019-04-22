import Foundation
import Curses

let screen = Screen.shared

class Handler : CursesHandlerProtocol {
    func interruptHandler() {
        screen.shutDown()
        print("Good bye!")
        exit(0)
    }

    func windowChangedHandler() {
    }
}

enum Direction {
    case up
    case down
    case left
    case right
}
         

class Player {
    var position : Point
    var direction : Direction
    var velocity : [Int]
    let window : Window
    
    init(playerPos:Point, direction:Direction, velocity:[Int], window:Window){
      self.position = playerPos
      self.direction = Direction.right
      self.velocity = [0,0] //x Velocity, y Velocity
      self.window = window
    }

    func setPlayerPos(){
        position = Point(x:position.x + velocity[0], y:position.y + velocity[1])
    }

    func changeVelocity(keyPressed:Key.KeyType){

           self.position = Point(x:position.x, y:position.y + 1)
        switch (keyPressed) {
        case .arrowDown:

            self.position = Point(x:position.x, y:position.y + 1)
        case .arrowUp:
            self.position = Point(x:position.x, y:position.y - 1)
        case .arrowRight:
            self.position = Point(x:position.x + 1, y:position.y)
        case .arrowLeft:
            self.position = Point(x:position.x - 1, y:position.y)
        default: do {}
        }
        /*
switch (keyPressed) {
        case .arrowDown:
            velocity[1] = -1
        case .arrowUp:
            velocity[1] = 1
        case .arrowRight:
            velocity[0] = 1
        case .arrowLeft:
            velocity[0] = -1
        default:
            velocity[0] = 0
            velocity[1] = 0
        }
        */
        window.refresh()
    }
}


func main() {
    // Start up
    screen.startUp(handler:Handler())

    let mainWindow = screen.window    
    let keyboard = Keyboard.shared
    let player = Player(playerPos:Point(x:0, y:0), direction:Direction.right, velocity:[0,0], window:mainWindow)
    while (true) {
        let key = keyboard.getKey(window:mainWindow)
        
        player.setPlayerPos()
        //      player.changeVelocity(keyPressed:key.keyType)
  
        switch (key.keyType) {
        case .arrowDown:
            player.position = Point(x:position.x, y:position.y + 1)
        case .arrowUp:
            self.position = Point(x:position.x, y:position.y - 1)
        case .arrowRight:
            self.position = Point(x:position.x + 1, y:position.y)
        case .arrowLeft:
            self.position = Point(x:position.x - 1, y:position.y)
        default: do {}
        }
  
  
        mainWindow.refresh()
    }
    
    // Wait forever, or until the user presses ^C
    screen.wait() //this keeps terminal safe
}



main()

