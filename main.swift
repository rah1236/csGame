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

enum direction {
    case Up
    case Down
    case Left
    case Right
}
         

class Player {
    var playerPos : Point
    var direction : direction
    var velocity : [Int]
    let player = mainWindow.cursor
    init(playerPos:Point, direction:direction, velocity:[Int]){
      self.playerPos = playerPos
      self.direction = direction.Right
      self.velocity = [0,0]
    }

    func setPlayerPos(){
        player.position = Point(x:playerPos.x + velocity[0], y:playerPos.y + velocity[1])
    }

    func changeVelocity(keyPressed:key.keyPressed){
        
        switch (keyPressed) {
        case .arrowDown: playerPos = Point(x:playerPos.x, y:playerPos.y + 1)
        case .arrowUp: playerPos = Point(x:playerPos.x, y:playerPos.y - 1)
        case .arrowRight: playerPos = Point(x:playerPos.x + 1, y:playerPos.y)
        case .arrowLeft: playerPos = Point(x:playerPos.x - 1, y:playerPos.y)
        default: do {}
        }
    }
}


func main() {
    // Start up
    screen.startUp(handler:Handler())

    let mainWindow = screen.window    
    let keyboard = Keyboard.shared
    let player = Player(playerPos:Point(x:0, y:0), direction:direction.Right, velocity:[0,0])
    while (true) {
        
        player.setPlayerPos()
        player.changeVelocity(keyPressed:keyboard.getKey(window:mainWindow).keyType)
        mainWindow.refresh()
    }
    
    // Wait forever, or until the user presses ^C
    screen.wait() //this keeps terminal safe
}



main()

