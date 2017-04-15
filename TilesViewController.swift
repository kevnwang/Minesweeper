//
//  TilesViewController.swift
//  Minesweeper
//
//  Created by Kevin Wang on 4/15/17.
//  Copyright © 2017 Kevin Wang. All rights reserved.
//

import UIKit

class TilesViewController: UIViewController, TileViewDelegate {
    
    var tiles = [[TileView]]()
    var gameOver = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        drawTiles()
        
        let newGameButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        newGameButton.center = CGPoint(x: view.center.x, y: view.center.y + 100)
        newGameButton.setTitle("New Game", for: .normal)
        newGameButton.setTitleColor(.blue, for: .normal)
        newGameButton.addTarget(self, action: #selector(newGame), for: .touchUpInside)
        view.addSubview(newGameButton)
    }
    
    func drawTiles() {
        for row in 0...7 {
            var arr = [TileView]()
            for col in 0...7 {
                let tile = TileView(frame: CGRect(x: 10 + row * 50, y: 35 + col * 50, width: 45, height: 45))
                tile.position = [row, col]
                tile.delegate = self
                tile.backgroundColor = .lightGray
                tile.isMine = arc4random() % 100 < 25 ? true : false
                view.addSubview(tile);
                arr.append(tile)
            }
            tiles.append(arr)
        }
    }
    
    func tileViewTouched(position: [Int], tileView: TileView) {
        if (gameOver) {
            return
        }
        let row = position[0]
        let col = position[1]
        let tileTouched = tiles[row][col]
        if (tileTouched.isMine) {
            let mineImage = UIImageView(frame: tileTouched.frame)
            mineImage.image = #imageLiteral(resourceName: "mine")
            mineImage.backgroundColor = .red
            view.addSubview(mineImage)
            tileTouched.removeFromSuperview()
            gameOver = true
            return
        }
        let surroundingTiles = [[row - 1, col - 1], [row, col - 1], [row + 1, col - 1], [row - 1, col], [row + 1, col], [row - 1, col + 1], [row, col + 1], [row + 1, col + 1]]
        var surroundingMines = 0
        for point in surroundingTiles {
            let r = point[0]
            let c = point[1]
            if (r >= 0 && r <= 7 && c >= 0 && c <= 7) {
                if (tiles[r][c].isMine) {
                    surroundingMines += 1
                }
            }
        }
        let numberLabel = UILabel(frame: tileTouched.frame)
        if (surroundingMines > 0) {
            numberLabel.text = "\(surroundingMines)"
            numberLabel.textColor = .cyan
            numberLabel.textAlignment = .center
        }
        numberLabel.backgroundColor = .darkGray
        view.addSubview(numberLabel)
        tileTouched.removeFromSuperview()
    }
    
    func newGame() {
        self.view.subviews.forEach({
            if !($0 is UIButton) {
                $0.removeFromSuperview()
            }
        })
        gameOver = false
        tiles = [[TileView]]()
        drawTiles()
    }
}
