//
//  Helper.swift
//  o
//
//  Created by kingkong999yhirose on 2016/04/12.
//  Copyright © 2016年 Hirose.Yudai. All rights reserved.
//

import Foundation

extension String {
    var first: String {
        return String(characters.prefix(1))
    }
    var lowerFirst: String {
        return first.lowercaseString + String(characters.dropFirst())
    }
}
