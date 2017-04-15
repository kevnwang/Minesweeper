//
//  TileView.swift
//  Minesweeper
//
//  Created by Kevin Wang on 4/15/17.
//  Copyright © 2017 Kevin Wang. All rights reserved.
//

import UIKit

protocol TileViewDelegate {
    func tileViewTouched(position: [Int], tileView: TileView)
}

class TileView: UIView {

    var delegate: TileViewDelegate!
    var position: [Int]!
    var isMine: Bool!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (touches.first?.location(in: self)) != nil {
            delegate?.tileViewTouched(position: position, tileView: self)
        }
    }
}
