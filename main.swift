import Foundation


class Grid {
    let possibleElements = ["█", " "] //Possible elements that can be held in the grid
    var gridArray : Array<Array<String>> //An Array that holds Arrays that hold strings

    init(width:Int, height:Int){
        gridArray = Array(repeating: [], count: height)
        
        for _ in gridArray{
            for i in 0..<width{
                gridArray[i].append((possibleElements.randomElement()!))
            }
        }  
    }
}

//class Player {
  //  var position : Array<Int>
    

//}


//grid[4][4] = "░"

var grid = Grid(width:50, height:50)

//system("clear")
for i in 0..<grid.gridArray.count{
    for ii in 0..<grid.gridArray[i].count{
        print(grid.gridArray[i][ii], terminator:"")
    }
    print(terminator:"\n")
}


    
    

