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
        // Do any additional setup after loading the view.
    }
    
    func drawTiles() {
        for row in 0...7 {
            var arr = [TileView]()
            for col in 0...7 {
                let tile = TileView(frame: CGRect(x: 10 + row * 50, y: 35 + col * 50, width: 45, height: 45))
                tile.position = [row, col]
                tile.delegate = self
                let random = arc4random() % 100
                tile.backgroundColor = random < 30 ? .black : .lightGray
                tile.isMine = random < 30 ? true : false
                view.addSubview(tile);
                arr.append(tile)
            }
            tiles.append(arr)
        }
    }
    
    func tileViewTouched(position: [Int], tileView: TileView) {
        print(position[0] + position[1])
        if (gameOver) {
            return
        }
        if (tiles[position[0]][position[1]].isMine) {
            let mineImage = UIImageView(frame: tiles[position[0]][position[1]].frame)
            mineImage.image = #imageLiteral(resourceName: "mine")
            mineImage.backgroundColor = .red
            view.addSubview(mineImage)
            gameOver = true
            return
        }
        tileView.backgroundColor = .darkGray
    }
}
