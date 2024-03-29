//
//  Color.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/06/26.
//

import UIKit

extension UIColor {
    
    @nonobjc class var white: UIColor {
        return UIColor(white: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var btnwhite: UIColor {
        return UIColor(white: 1.0, alpha: 0.35)
    }
    
    @nonobjc class var black: UIColor {
        return UIColor(white: 25.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var grayscales50: UIColor {
        return UIColor(white: 251.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var grayscales100: UIColor {
        return UIColor(red: 241.0 / 255.0, green: 243.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var grayscales200: UIColor {
        return UIColor(red: 233.0 / 255.0, green: 236.0 / 255.0, blue: 239.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var grayscales300: UIColor {
        return UIColor(red: 222.0 / 255.0, green: 226.0 / 255.0, blue: 230.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var grayscales400: UIColor {
        return UIColor(red: 206.0 / 255.0, green: 212.0 / 255.0, blue: 218.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var grayscales500: UIColor {
        return UIColor(red: 173.0 / 255.0, green: 181.0 / 255.0, blue: 189.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var grayscales600: UIColor {
        return UIColor(red: 134.0 / 255.0, green: 142.0 / 255.0, blue: 150.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var grayscales700: UIColor {
        return UIColor(red: 73.0 / 255.0, green: 80.0 / 255.0, blue: 87.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var grayscales800: UIColor {
        return UIColor(red: 52.0 / 255.0, green: 58.0 / 255.0, blue: 64.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var grayscales900: UIColor {
        return UIColor(red: 33.0 / 255.0, green: 37.0 / 255.0, blue: 41.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var yelloMain500: UIColor {
        return UIColor(red: 251.0 / 255.0, green: 1.0, blue: 62.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var yelloMain100: UIColor {
        return UIColor(red: 1.0, green: 1.0, blue: 244.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var yelloMain200: UIColor {
        return UIColor(red: 254.0 / 255.0, green: 1.0, blue: 222.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var yelloMain300: UIColor {
        return UIColor(red: 253.0 / 255.0, green: 1.0, blue: 168.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var yelloMain400: UIColor {
        return UIColor(red: 252.0 / 255.0, green: 1.0, blue: 126.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var yelloMain600: UIColor {
        return UIColor(red: 241.0 / 255.0, green: 245.0 / 255.0, blue: 19.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var yelloMain700: UIColor {
        return UIColor(red: 231.0 / 255.0, green: 235.0 / 255.0, blue: 26.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var yelloMain800: UIColor {
        return UIColor(red: 209.0 / 255.0, green: 212.0 / 255.0, blue: 18.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var yelloMain900: UIColor {
        return UIColor(red: 184.0 / 255.0, green: 188.0 / 255.0, blue: 23.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var purpleSub500: UIColor {
        return UIColor(red: 100.0 / 255.0, green: 55.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var purpleSub50: UIColor {
        return UIColor(red: 245.0 / 255.0, green: 243.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var purpleSub100: UIColor {
        return UIColor(red: 230.0 / 255.0, green: 226.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var purpleSub200: UIColor {
        return UIColor(red: 199.0 / 255.0, green: 194.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var purpleSub300: UIColor {
        return UIColor(red: 167.0 / 255.0, green: 153.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var purpleSub400: UIColor {
        return UIColor(red: 131.0 / 255.0, green: 100.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var purpleSub600: UIColor {
        return UIColor(red: 88.0 / 255.0, green: 55.0 / 255.0, blue: 220.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var purpleSub700: UIColor {
        return UIColor(red: 75.0 / 255.0, green: 37.0 / 255.0, blue: 184.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var purpleSub800: UIColor {
        return UIColor(red: 64.0 / 255.0, green: 19.0 / 255.0, blue: 159.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var purpleSub900: UIColor {
        return UIColor(red: 51.0 / 255.0, green: 17.0 / 255.0, blue: 124.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var semanticStatusRed100: UIColor {
        return UIColor(red: 1.0, green: 241.0 / 255.0, blue: 241.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var semanticStatusRed500: UIColor {
        return UIColor(red: 240.0 / 255.0, green: 70.0 / 255.0, blue: 70.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var semanticStatusYellow100: UIColor {
        return UIColor(red: 254.0 / 255.0, green: 247.0 / 255.0, blue: 231.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var semanticStatusYellow500: UIColor {
        return UIColor(red: 1.0, green: 216.0 / 255.0, blue: 77.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var semanticStatusGreen100: UIColor {
        return UIColor(red: 246.0 / 255.0, green: 1.0, blue: 243.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var semanticStatusGreen500: UIColor {
        return UIColor(red: 104.0 / 255.0, green: 212.0 / 255.0, blue: 76.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var semanticGenderF300: UIColor {
        return UIColor(red: 1.0, green: 186.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var semanticGenderF500: UIColor {
        return UIColor(red: 242.0 / 255.0, green: 98.0 / 255.0, blue: 193.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var semanticGenderM300: UIColor {
        return UIColor(red: 172.0 / 255.0, green: 206.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var semanticGenderM500: UIColor {
        return UIColor(red: 87.0 / 255.0, green: 154.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var voteEllipseE01: UIColor {
        return UIColor(red: 168.0 / 255.0, green: 146.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var voteEllipseE02: UIColor {
        return UIColor(red: 165.0 / 255.0, green: 254.0 / 255.0, blue: 194.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var voteEllipseE03: UIColor {
        return UIColor(red: 1.0, green: 135.0 / 255.0, blue: 179.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var voteEllipseE04: UIColor {
        return UIColor(red: 110.0 / 255.0, green: 229.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var voteEllipseE05: UIColor {
        return UIColor(red: 239.0 / 255.0, green: 142.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var voteEllipseE06: UIColor {
        return UIColor(red: 111.0 / 255.0, green: 195.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var voteEllipseE07: UIColor {
        return UIColor(red: 1.0, green: 149.0 / 255.0, blue: 146.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var voteEllipseE08: UIColor {
        return UIColor(red: 132.0 / 255.0, green: 248.0 / 255.0, blue: 229.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var voteEllipseE09: UIColor {
        return UIColor(red: 1.0, green: 114.0 / 255.0, blue: 142.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var voteEllipseE10: UIColor {
        return UIColor(red: 161.0 / 255.0, green: 155.0 / 255.0, blue: 252.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var voteEllipseE11: UIColor {
        return UIColor(red: 112.0 / 255.0, green: 182.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var voteEllipseE12: UIColor {
        return UIColor(red: 252.0 / 255.0, green: 114.0 / 255.0, blue: 179.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var semanticGenderF700: UIColor {
        return UIColor(red: 123.0 / 255.0, green: 36.0 / 255.0, blue: 94.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var semanticGenderM700: UIColor {
        return UIColor(red: 29.0 / 255.0, green: 73.0 / 255.0, blue: 142.0 / 255.0, alpha: 1.0)
    }
    
}
