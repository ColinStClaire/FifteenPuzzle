//
//  BoardView.swift
//  FifteenPuzzle
//
//  Created by Colin St. Claire on 2/19/18.
//  Copyright © 2018 Colin. All rights reserved.
//

//PLIST FOR DATA PERSISTANCE!!!!!!!!!!

import UIKit

class BoardView: UIView {
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let board = appDelegate.board
    
    let boardSquare = boardRect()  // determine region to hold tiles (see below)
    let tileSize = boardSquare.width / 4.0
    let tileBounds = CGRect(x: 0, y: 0, width: tileSize, height: tileSize)
    
    for r in 0..<4 {
      for c in 0..<4 {
        let tile = board!.getTile(atRow: r, atColumn: c)
        if tile > 0 {
          let button = self.viewWithTag(tile)
          button!.bounds = tileBounds
          button!.center =
            CGPoint(x: boardSquare.origin.x + (CGFloat(c) + 0.5)*tileSize,
                    y: boardSquare.origin.y + (CGFloat(r) + 0.75)*tileSize)
        }
      }
    }
  }
  
  func boardRect() -> CGRect { // get square for holding 4x4 tiles buttons
    let W = self.bounds.size.width
    let H = self.bounds.size.height
    let margin : CGFloat = 10
    let size = ((W <= H) ? W : H) - 2*margin
    let boardSize : CGFloat = CGFloat((Int(size) + 7)/8)*8.0 // next multiple of 8
    let leftMargin = (W - boardSize)/2
    let topMargin = (H - boardSize)/2
    return CGRect(x: leftMargin, y: topMargin, width: boardSize, height: boardSize)
  }
  
}
