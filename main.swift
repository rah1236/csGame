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

class Bullet {
    var position : Point
    var direction : Direction
    var velocity : [Int]
    

    init(position:Point, direction:Direction){
        self.position = position
        switch (direction){
        case Direction.up:
            self.velocity = [0,-2]
        case Direction.down:
            self.velocity = [0,2]
        case Direction.right:
            self.velocity = [2,0]
        case Direction.left:
            self.velocity = [-2,0]
        default:
            self.velocity = [0,0]
        }
        self.direction = direction
    }

    func updatePosition(){
        position = Point(x:position.x + velocity[0], y:position.y + velocity[1])
        
    }
        
}

class Player {
    var position : Point
    var direction : Direction
    var velocity : [Int]
    let window : Window
    let cursor : Cursor
    
    init(playerPos:Point, direction:Direction, velocity:[Int], window:Window){
      self.position = playerPos
      self.direction = Direction.right
      self.velocity = [0,0] //x Velocity, y Velocity
      self.window = window
      self.cursor = window.cursor
    }

    func updatePosition(keyPressed:Key){
       


//        print(keyPressed)
        
        switch (keyPressed.keyType) {
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

        cursor.position = position
        print(".")
        
        window.refresh()
        window.clear()
    }
}


func main() {
    // Start up
    screen.startUp(handler:Handler())

    let mainWindow = screen.window    
    
    let player = Player(playerPos:Point(x:0, y:0), direction:Direction.right, velocity:[0,0], window:mainWindow)
    
    let keyboard = Keyboard.shared
    keyboard.setBufferingDelayed(tenthsOfSecond:1)

    
    while (true) {
        let key = keyboard.getKey(window:mainWindow)
        
        player.updatePosition(keyPressed:key)
  
//        print(key.keyType)
  
        mainWindow.refresh()
    }
    
    // Wait forever, or until the user presses ^C
    screen.wait() //this keeps terminal safe
}



main()

