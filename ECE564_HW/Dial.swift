//
//  Dial.swift
//  ECE564_HW
//
//  Created by 曹畅 on 2021/10/18.
//  Copyright © 2021 ECE564. All rights reserved.
//

import Foundation
import UIKit

class Dial: UIView {
    override func draw(_ rect: CGRect) {
        let bigCirclePath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 48, height: 48))
        UIColor.brown.setFill()
        bigCirclePath.fill()
        
        let circle1Path = UIBezierPath(ovalIn: CGRect(x: 18, y: 6, width: 12, height: 12))
        UIColor.black.setFill()
        circle1Path.fill()
        
        let circle2Path = UIBezierPath(ovalIn: CGRect(x: 30, y: 18, width: 12, height: 12))
        UIColor.black.setFill()
        circle2Path.fill()
        
        let circle3Path = UIBezierPath(ovalIn: CGRect(x: 18, y: 30, width: 12, height: 12))
        UIColor.black.setFill()
        circle3Path.fill()
        
        let circle4Path = UIBezierPath(ovalIn: CGRect(x: 6, y: 18, width: 12, height: 12))
        UIColor.black.setFill()
        circle4Path.fill()
    }
}
