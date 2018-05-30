//
//  Extension.swift
//  ARMagic
//
//  Created by DerekMacbook on 5/30/18.
//  Copyright © 2018 DerekMacbook. All rights reserved.
//

import UIKit

enum UIUserInterfaceIdiom: Int {
    case undefined
    case phone
    case pad
}

struct ScreenSize {
    static let width = UIScreen.main.bounds.size.width
    static let heigth = UIScreen.main.bounds.size.height
    static let maxLength = max(ScreenSize.width, ScreenSize.heigth)
    static let minLength = min(ScreenSize.width, ScreenSize.heigth)
}

struct DeviceType {
    static let isiPhone40rLess = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength < 568.0
    static let isiPhone5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength < 568.0
    static let isiPhone6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength < 667.0
    static let isiPhone6Plus = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength < 736.0
    static let isiPhoneX = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength < 812.0
    static let isiPad = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength < 1024.0
    static let isiPadPro = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength < 1366.0
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}

public extension Float {
    
    public static func random() -> Float {
        return Float(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    public static func random(_ min: Float, max: Float) -> Float {
        return Float.random() * (max - min) + min
    }
}
extension Int {
    var degreesToRadians: Double { return Double(self) * .pi/180 }
}
    
    
    











