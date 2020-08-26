//
//  Time.swift
//  PIE
//
//  Created by Karina on 8/25/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import Foundation

extension Int {
    var convertIntToTime: String {
        let hrs = self / 60
        let min = self % 60
        return hrs > 0 ? String(format: "%1dh%02d mn", hrs, min) : String(format: "%1d mn", min)
    }
}
