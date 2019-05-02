import Foundation


class Grid {
    let possibleElements = ["█", " "," "," ", " ", " "] //Possible elements that can be held in the grid (the more " " the more will be ranodmly chosen
    var gridArray : Array<Array<String>> //An Array that holds Arrays that hold strings
    let width : Int
    let height : Int
    
    init(w:Int, h:Int){
        gridArray = Array(repeating: [], count: h)
        
        for _ in gridArray{
            for i in 0..<w{
                gridArray[i].append((possibleElements.randomElement()!))
            }
        }
        width = w - 1
        height = h - 1
    }

    func printGrid(player:Player){
        for y in 0..<gridArray.count{
            for x in 0..<gridArray[y].count{
                
                if (player.position[0] == x && player.position[1] == y){
                    print(player.playerCharacter, terminator:"")                          //PLAYER PRINT HANDLING 
                }

                else if (
                else{
                    print(gridArray[y][x], terminator:"")
                }
            }
            print(terminator:"\n")
        }
    }

    func gridRefresh(player:Player){
        system("clear")
        printGrid(player:player)
    }
}

class NPC {
    var position : Array<Int>
    let playerCharacter: String
    init(grid:Grid, playerChar:String = "X"){
        position = [Int.random(in: 0..<grid.width), Int.random(in: 0..<grid.height)]
        playerCharacter = playerChar
    }

    func updatePosition(grid:Grid){
        position[0] += Int.random(in: 0...1)
        position[1] += Int.random(in: 0...1)
    }
}

class Player {
    var position : Array<Int>
    let playerCharacter: String
    init(grid:Grid, playerChar:String = "░"){
        position = [Int.random(in: 0..<grid.width), Int.random(in: 0..<grid.height)]
        playerCharacter = playerChar
    }

    func updatePosition(grid:Grid){
        print("Move your character by inputting 'up', 'left', 'right' or 'down'")
        let playerInput = String(readLine()!)
       
        switch (playerInput){
        case "up":
            position = [position[0], position[1] - 1]
            grid.gridRefresh(player:self)
        case "down":
            position = [position[0], position[1] + 1]
            grid.gridRefresh(player:self)
        case "left":
            position = [position[0] - 1, position[1]]
            grid.gridRefresh(player:self)
        case "right":
            position = [position[0] + 1, position[1]]
            grid.gridRefresh(player:self)
        default:
            grid.gridRefresh(player:self)
            print("Can't do that! Please enter another input.")
       
        }
       
    }
}




func main(){
    
    let grid = Grid(w:10, h:10)
    let player = Player(grid:grid, playerChar:"U")
    let enemyOne = NPC(grid:grid)
    let enemyTwo = NPC(grid:grid)
    grid.gridRefresh(player:player)
    while true{
        enemyOne.updatePosition(grid:grid)
        enemyTwo.updatePosition(grid:grid)
        player.updatePosition(grid:grid)
    }
}

main()

