//
//  Operator.swift
//  CountOnMe
//
//  Created by Thomas Bouges on 2019-01-17.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation
// enum for each Operator
enum Operator {
    case plus, minus, equal, multiplicator, division
    var display: String {
        switch self {
        case .plus:
            return "+"
        case .minus:
            return "-"
        case .equal:
            return "="
        case .multiplicator:
            return "x"
        case .division:
            return "/"
            // perso: break default is not an obligation if we are doing an enum
        }
    }
    
}
