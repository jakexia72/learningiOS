//
//  cardView.swift
//  Set!
//
//  Created by Jake Xia on 2019-01-07.
//  Copyright © 2019 Jake Xia. All rights reserved.
//

import UIKit

class CardView: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 10)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
    }
    
    

}
