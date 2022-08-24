//
//  Colors.swift
//  POMacArch
//
//  Created by Mohamed gamal on 05/05/2021.
//  Copyright © 2021 POMac. All rights reserved.
//
import UIKit

extension UIColor {
    
    public enum AppMainColors {
        static let appColor = UIColor.rgb(red: 55, green: 182, blue: 115)
        static let allTask = UIColor.rgb(red: 234, green: 234, blue: 234)
        static let newTask = UIColor.rgb(red: 6, green: 185, blue: 184)
        static let pendingTask = UIColor.rgb(red: 255, green: 153, blue: 0)
        static let delayedTaks = UIColor.rgb(red: 255, green: 136, blue: 136)
        static let canceldTaks = UIColor.rgb(red: 146, green: 146, blue: 146)
        static let completedTaks = UIColor.rgb(red: 6, green: 185, blue: 73)
        static let deylayedForReplay = UIColor.rgb(red: 239, green: 190, blue: 56)
        static let TabTitleColor =  UIColor(red: 0.44, green: 0.44, blue: 0.44, alpha: 1.00)
        static let unactiveBtn = UIColor(red: 0.44, green: 0.44, blue: 0.44, alpha: 1.00)
        static let teacherAppMainGreenColor = UIColor.rgb(red: 55, green: 182, blue: 115)
        static let teacherAppMainLightGreenColor = UIColor.rgb(red: 211, green: 249, blue: 229)
        static let teacherAppMainGrayColor = UIColor.rgb(red: 177, green: 177, blue: 177)
        static let teacherAppMainViewBackgroundColor = UIColor.rgb(red: 249, green: 249, blue: 249)
        static let teacherAppMainViewBorderColor = UIColor.rgb(red: 217, green: 217, blue: 217)
    }
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}
