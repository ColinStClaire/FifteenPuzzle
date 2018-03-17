//
//  ViewController.swift
//  FifteenPuzzle
//
//  Created by Colin St. Claire on 2/19/18.
//  Copyright © 2018 Colin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    NotificationCenter.default.addObserver(self, selector: #selector(ViewController.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
  }
  
  override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
  
  @IBOutlet weak var boardView: BoardView!
  
  @IBOutlet var allButtons: Array<UIButton>?
  
  @IBOutlet var title2: UIImageView?
  
  private var showNumbers: Bool = true
  
  @IBAction func tileSelected(_ sender: UIButton) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let board = appDelegate.board!
    let pos = board.getRowAndColumn(forTile: sender.tag)
    let buttonBounds = sender.bounds
    var buttonCenter = sender.center
    var slide = true
    
    if board.canSlideTileUp(atRow: pos!.row, Column: pos!.column) {
      buttonCenter.y -= buttonBounds.size.height
    } else if board.canSlideTileDown(atRow: pos!.row, Column: pos!.column) {
      buttonCenter.y += buttonBounds.size.height
    } else if board.canSlideTileLeft(atRow: pos!.row, Column: pos!.column) {
      buttonCenter.x -= buttonBounds.size.width
    } else if board.canSlideTileRight(atRow: pos!.row, Column: pos!.column) {
      buttonCenter.x += buttonBounds.size.width
    } else {
      slide = false
    }
    if slide {
      if (board.slideTile(atRow: pos!.row, Column: pos!.column)) {
        UIView.animate(withDuration: 0.4, animations:
          { sender.center = buttonCenter })
        if (board.isSolved()) {
          handleWin()
        }
      }
    }
  }
  
  @IBAction func shuffleTiles(_ sender: UIBarButtonItem) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let board = appDelegate.board!
    board.scramble(numTimes: appDelegate.numShuffles)
    self.boardView.setNeedsLayout()
  }
  
  @IBAction func solvePuzzle(_ sender: UIBarButtonItem) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let board = appDelegate.board!
    board.solve()
    self.boardView.setNeedsLayout()
    handleWin()
  }
  
  @IBAction func hideNumbers(_ sender: UIBarButtonItem) {
    showNumbers = !showNumbers
    allButtons?.forEach({ button in
      UIView.animate(withDuration: 0.4, animations:
        { button.titleLabel?.alpha = (self.showNumbers) ? 1 : 0 })
    })
  }

  @objc private func rotated() {
    toggleTitle(
      show: UIDevice.current.orientation == UIDeviceOrientation.portrait)
  }
  
  private func handleWin() {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let board = appDelegate.board!
    
    // thanks to Jason Willmore for showing me this
    let alert = UIAlertController(
      title: "Ha ha ha ha! You solved the puzzle!",
      message: "Now my spirit is free to haunt this mansion once more!",
      preferredStyle: .actionSheet)
    
    alert.addAction(UIAlertAction(
      title: "Unleash my spirit again?",
      style: .default,
      handler:
      { action in
        board.scramble(numTimes: appDelegate.numShuffles)
        self.boardView.setNeedsLayout()
    }
    ))
    self.present(alert, animated: true, completion: nil)
  }
  
  private func toggleTitle(show: Bool) {
    title2?.isHidden = !show
    print((show) ? "toggled to: portrait" : "toggled to: not portrait")
    self.boardView.setNeedsLayout()
  }
  
}
