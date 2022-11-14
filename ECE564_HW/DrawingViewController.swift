//
//  DrawingViewController.swift
//  ECE564_HW
//
//  Created by 曹畅 on 2021/10/18.
//  Copyright © 2021 ECE564. All rights reserved.
//

import UIKit

class DrawingViewController: UIViewController {
    let label = UILabel(frame: CGRect(x:100, y:10, width:200, height:50))

    let flipButton = UIButton(frame:CGRect(x:15, y:400, width:70, height:30))

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        flipButton.setTitle("Flip", for: .normal)
        flipButton.backgroundColor = UIColor(red: 1/255, green: 33/255, blue: 105/255, alpha: 1)
        flipButton.setTitleColor(.white, for: .normal)
        flipButton.layer.cornerRadius = 5
        flipButton.layer.masksToBounds = true
        flipButton.addTarget(self, action: #selector(flipAction), for: .touchUpInside)
        
        let multipleAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 1/255, green: 33/255, blue: 105/255, alpha: 1),
            NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 24)!]
        let nameAttributed = NSAttributedString(string: "Watch movies", attributes: multipleAttributes)
        label.attributedText = nameAttributed
        
        view.addSubview(flipButton)
        view.addSubview(label)
        
        setImageAnimationView()
        setGraphicContext()
        setViewAnimationView()
    }
    
    @objc func flipAction() {
        dismiss(animated: true, completion: nil)
    }
    
    func setImageAnimationView() {
        let iav = UIImageView()
        iav.frame = CGRect(x: 50, y: 480, width: 100, height: 100)
        
        let i1 = UIImage(named: "1.png")!
        let i2 = UIImage(named: "2.png")!
        let i3 = UIImage(named: "3.png")!
        iav.animationImages = [i1, i2, i3, i2]
        iav.animationDuration = 1
        iav.startAnimating()
        view?.addSubview(iav)
    }
    
    func setGraphicContext() {
        // Draw the two rectangles at the bottom of the scene
        let gcv2Frame = CGRect(x: 10, y: 70, width: 355, height: 315)
        
        UIGraphicsBeginImageContextWithOptions(gcv2Frame.size, false, 0.0)
        let color:UIColor = UIColor.gray
        let bpath:UIBezierPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 355, height: 315))
        bpath.lineWidth = 5
        color.set()
        bpath.stroke()
        let saveImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let iv = UIImageView()
        iv.frame = gcv2Frame
        iv.image = saveImage
        view?.addSubview(iv)
    }
    
    func setViewAnimationView() {
        let projector = Projector()
        projector.backgroundColor = UIColor(white: 1, alpha: 0)
        projector.frame = CGRect(x: 80, y: 140, width: 200, height: 220)
        view?.addSubview(projector)
        
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = 2 * Double.pi
        anim.duration = 5.0
        anim.repeatCount = MAXFLOAT
        anim.isRemovedOnCompletion = false
                        
        let dial1 = Dial()
        dial1.backgroundColor = UIColor(white: 1, alpha: 0)
        dial1.frame = CGRect(x: 100, y: 100, width: 48, height: 48)
        dial1.layer.add(anim, forKey: nil)
        view?.addSubview(dial1)
        
        let dial2 = Dial()
        dial2.backgroundColor = UIColor(white: 1, alpha: 0)
        dial2.frame = CGRect(x: 150, y: 100, width: 48, height: 48)
        dial2.layer.add(anim, forKey: nil)
        view?.addSubview(dial2)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
