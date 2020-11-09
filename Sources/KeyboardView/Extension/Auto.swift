//
//  Double.swift
//  
//
//  Created by 方林威 on 2020/11/7.
//

import UIKit

extension Double {

    func auto() -> Double {
        guard UIDevice.current.userInterfaceIdiom == .phone else {
            return self
        }
        let base = 375.0
        let screenWidth = Double(UIScreen.main.bounds.width)
        let screenHeight = Double(UIScreen.main.bounds.height)
        let width = min(screenWidth, screenHeight)
        
        let result = self * (width / base)
        let scale = Double(UIScreen.main.scale)
        return (result * scale).rounded(.up) / scale
    }
}

extension BinaryInteger {

    func auto() -> Double {
        let temp = Double("\(self)") ?? 0
        return temp.auto()
    }
    func auto<T>() -> T where T : BinaryInteger {
        let temp = Double("\(self)") ?? 0
        return temp.auto()
    }
    func auto<T>() -> T where T : BinaryFloatingPoint {
        let temp = Double("\(self)") ?? 0
        return temp.auto()
    }
}

extension BinaryFloatingPoint {
    
    func auto() -> Double {
        let temp = Double("\(self)") ?? 0
        return temp.auto()
    }
    func auto<T>() -> T where T : BinaryInteger {
        let temp = Double("\(self)") ?? 0
        return T(temp.auto())
    }
    func auto<T>() -> T where T : BinaryFloatingPoint {
        let temp = Double("\(self)") ?? 0
        return T(temp.auto())
    }
}

extension Double {
    
    var string: String { String(self) }
}
