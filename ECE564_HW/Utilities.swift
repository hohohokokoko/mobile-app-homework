//
//  Utilities.swift
//  ECE564_HW
//
//  Created by 曹畅 on 2021/9/14.
//  Copyright © 2021 ECE564. All rights reserved.
//

import Foundation
import UIKit

// This function is used to get gender UISegmentedControl's index from enum
func showGender(gender: Gender) -> Int {
    var index: Int {
        switch gender {
            case .Male: return 0
            case .Female: return 1
            case .NonBinary: return 2
            case .Unknown: return -1
        }
    }
    return index
}

// This function is used to get role UISegmentatedControl's index from enum
func showRole(role: DukeRole) -> Int {
    var index: Int {
        switch role {
            case .Student: return 0
            case .Professor: return 1
            case .TA: return 2
            case .Other: return -1
            case .Unknown: return -1
        }
    }
    return index
}

// This function is used to print arrays in textfields as type string
func printArray(array: [String]) -> String {
    var str = ""
    for item in array {
        str = str + ", " + item
    }
    str.remove(at: str.startIndex)
    str.remove(at: str.startIndex)
    return str
}

// get image using name
func imageFromName(_ imageName: String) -> UIImage {
    return UIImage(named: imageName)!
}

// encode an image to a string
func stringFromImage(_ imagePic: UIImage) -> String {
    let picImageData: Data = imagePic.jpegData(compressionQuality: 1)!
    let picBased64 = picImageData.base64EncodedString()
    return picBased64
}

extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}
