//
//  FifteenBoard.swift
//  FifteenPuzzle
//
//  Created by Colin St. Claire on 2/16/18.
//  Copyright © 2018 Colin. All rights reserved.
//

import Foundation
class FifteenBoard {
  var state: [[Int]] = [
    [1,2,3,4],
    [5,6,7,8],
    [9,10,11,12],
    [13,14,15,0]
  ]
  
  let WINNING_STATE: [[Int]] = [
    [1,2,3,4],
    [5,6,7,8],
    [9,10,11,12],
    [13,14,15,0]
  ]

  /*
   Choose one of the “slidable” tiles at random and slide it into the empty
   space; repeat n times. We use this method to start a new game using a large
   value (e.g., 150) for n.`
  */
  func scramble(numTimes n: Int) {
    var i = 0
    while (i < n) {
      if let emptyTile = getRowAndColumn(forTile: 0) {
        let randNum = arc4random_uniform(4),
          row = emptyTile.row,
          col = emptyTile.column
        switch randNum {
        case 0:
          if (slideTile(atRow: row - 1, Column: col)) {
            i += 1
          }
        case 1:
          if (slideTile(atRow: row + 1, Column: col)) {
            i += 1
          }
        case 2:
          if (slideTile(atRow: row, Column: col + 1)) {
            i += 1
          }
        case 3:
          if (slideTile(atRow: row, Column: col - 1)) {
            i += 1
          }
        default: continue
        }
      }
    }
  }
  
  /*
   Fetch the tile at the given position (0 is used for the space).
  */
  func getTile(atRow r: Int, atColumn c: Int) -> Int {
    return state[r][c]
  }
  
  /*
   Find the position of the given tile (0 is used for the space) – returns tuple
   holding row and column.
  */
  func getRowAndColumn(forTile tile: Int) -> (row: Int, column: Int)? {
    for i in 0..<state.count {
      for j in 0..<state[i].count {
        if (state[i][j] == tile) {
          return (i, j)
        }
      }
    }
    return nil
  }
  
  /*
   Determine if puzzle is in solved configuration.
  */
  func isSolved() -> Bool {
    let win = state.elementsEqual(WINNING_STATE) { $0 == $1 }
    if win {
      //print("Winner!")
    }
    return win
  }
  
  func solve() {
    state = WINNING_STATE
  }
  
  /*
   Slide the tile into the empty space, if possible.
  */
  func slideTile(atRow r : Int, Column c: Int)->Bool {
    guard (r >= 0 && c >= 0
      && r <= state.count-1 && c <= state[r].count-1)
      else {
        return false
    }
    var temp: Int = getTile(atRow: r, atColumn: c),
    didSlide: Bool = false
    if (canSlideTileUp(atRow: r, Column: c)) {
      state[r-1][c] = temp
      didSlide = true
    }
    else if (canSlideTileDown(atRow: r, Column: c)) {
      state[r+1][c] = temp
      didSlide = true
    }
    else if (canSlideTileLeft(atRow: r, Column: c)) {
      state[r][c-1] = temp
      didSlide = true
    }
    else if (canSlideTileRight(atRow: r, Column: c)) {
      state[r][c+1] = temp
      didSlide = true
    }
    state[r][c] = 0
    return didSlide
  }
  
  /*----------------------- legal move checkers ----------------------------*/
  func canSlideTileDown(atRow r :  Int, Column c :  Int) -> Bool {
    return r < state.count - 1
      && state[r+1][c] == 0
  }
  
  func canSlideTileUp(atRow r :  Int, Column c :  Int) -> Bool {
    return r > 0 && state[r-1][c] == 0
  }
  
  func canSlideTileLeft(atRow r :  Int, Column c :  Int) -> Bool {
    return c > 0 && state[r][c-1] == 0
  }
  
  func canSlideTileRight(atRow r :  Int, Column c :  Int) -> Bool {
    return c < state.count-1 && state[r][c+1] == 0
  }
  
}
