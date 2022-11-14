//
//  BackViewController.swift
//  ECE564_HW
//
//  Created by 曹畅 on 2021/10/11.
//  Copyright © 2021 ECE564. All rights reserved.
//

import UIKit

class BackViewController: UIViewController {
    let flipButton = UIButton(frame:CGRect(x:15, y:400, width:70, height:30))
    
    let nameLabel = UILabel(frame: CGRect(x:50, y:100, width:175, height:100))

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
            NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 32)!]
        let nameAttributed = NSAttributedString(string: "Welcome!", attributes: multipleAttributes)
        nameLabel.attributedText = nameAttributed
        
        view.addSubview(flipButton)
        view.addSubview(nameLabel)
    }
    
    @objc func flipAction() {
        dismiss(animated: true, completion: nil)
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
