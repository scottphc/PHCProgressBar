//
//  UIColorExtension.swift
//  FBSnapshotTestCase
//
//  Created by Scott Chou on 2018/7/5.
//

import Foundation

extension UIColor {

    var darker: UIColor {
        var fRed: CGFloat = 0
        var fGreen: CGFloat = 0
        var fBlue: CGFloat = 0
        var fAlpha: CGFloat = 0
        getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha)

        return UIColor(red: fRed / 2, green: fGreen / 2, blue: fBlue / 2, alpha: fAlpha)
    }
}
