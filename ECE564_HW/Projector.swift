//
//  Projector.swift
//  ECE564_HW
//
//  Created by 曹畅 on 2021/10/18.
//  Copyright © 2021 ECE564. All rights reserved.
//

import Foundation
import UIKit

class Projector: UIView {
    override func draw(_ rect: CGRect) {        
        let bodyPath = UIBezierPath(rect: CGRect(x: 20, y: 0, width: 100, height: 70))
        UIColor.gray.setFill()
        bodyPath.fill()
        
        let leftConnectionPath = UIBezierPath(rect: CGRect(x: 10, y: 10, width: 10, height: 10))
        UIColor.black.setFill()
        leftConnectionPath.fill()
        
        let leftLensPath = UIBezierPath()
        leftLensPath.move(to: CGPoint(x: 0, y: 0))
        leftLensPath.addLine(to: CGPoint(x: 10, y: 10))
        leftLensPath.addLine(to: CGPoint(x: 10, y: 20))
        leftLensPath.addLine(to: CGPoint(x: 0, y: 30))
        UIColor.gray.setFill()
        leftLensPath.fill()
        
        let rightConnectionPath = UIBezierPath(rect: CGRect(x: 120, y: 20, width: 10, height: 30))
        UIColor.black.setFill()
        rightConnectionPath.fill()
        
        let rightLensPath = UIBezierPath()
        rightLensPath.move(to: CGPoint(x: 130, y: 20))
        rightLensPath.addLine(to: CGPoint(x: 150, y: 0))
        rightLensPath.addLine(to: CGPoint(x: 150, y: 70))
        rightLensPath.addLine(to: CGPoint(x: 130, y: 50))
        UIColor.gray.setFill()
        rightLensPath.fill()
        
        let basePath = UIBezierPath(rect: CGRect(x: 40, y: 70, width: 60, height: 20))
        UIColor.black.setFill()
        basePath.fill()
        
        let leftLegPath = UIBezierPath()
        leftLegPath.move(to: CGPoint(x: 60, y: 90))
        leftLegPath.addLine(to: CGPoint(x: 20, y: 220))
        leftLegPath.addLine(to: CGPoint(x: 70, y: 90))
        UIColor.brown.setFill()
        leftLegPath.fill()
        
        let rightLegPath = UIBezierPath()
        rightLegPath.move(to: CGPoint(x: 80, y: 90))
        rightLegPath.addLine(to: CGPoint(x: 120, y: 220))
        rightLegPath.addLine(to: CGPoint(x: 70, y: 90))
        UIColor.brown.setFill()
        rightLegPath.fill()
    }
}
