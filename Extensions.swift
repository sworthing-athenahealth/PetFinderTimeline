//
//  Extensions.swift
//  PetFinderTimeline
//
//  Created by alvarezblue on 6/7/16.
//  Copyright © 2016 Sarah Worthing. All rights reserved.
//

import UIKit

public extension CALayer {
    var borderUIColor: UIColor {
        set {
            self.borderColor = newValue.CGColor
        }
        
        get {
            return UIColor(CGColor: self.borderColor!)
        }
    }
}

// from: http://stackoverflow.com/questions/35895154/decimal-to-fraction-conversion-in-swift
typealias Rational = (num : Int, den : Int)

func rationalApproximationOf(x0 : Double, withPrecision eps : Double = 1.0E-6) -> Rational {
    var x = x0
    var a = floor(x)
    var (h1, k1, h, k) = (1, 0, Int(a), 1)
    
    while x - a > eps * Double(k) * Double(k) {
        x = 1.0/(x - a)
        a = floor(x)
        (h1, k1, h, k) = (h, k, h1 + Int(a) * h, k1 + Int(a) * k)
    }
    return (h, k)
}

// from: http://stackoverflow.com/questions/25050309/swift-random-float-between-0-and-1
extension IntervalType {
    public func random() -> Bound {
        let range = (self.end as! Double) - (self.start as! Double)
        let randomValue = (Double(arc4random_uniform(UINT32_MAX)) / Double(UINT32_MAX)) * range + (self.start as! Double)
        return randomValue as! Bound
    }
}