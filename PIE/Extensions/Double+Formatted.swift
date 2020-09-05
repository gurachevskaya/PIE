//
//  Double+Formatted.swift
//  PIE
//
//  Created by Karina on 9/1/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import Foundation

extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16
        return formatter.string(from: number)!
    }
}
