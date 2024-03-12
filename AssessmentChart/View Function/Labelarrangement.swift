//
//  Labelarrangement.swift
//  AssessmentChart
//
//  Created by 10362 on 2024/3/11.
//

import Foundation
import UIKit

class Labelarrangement{
    func stringToArray(strings: [String]) -> [UILabel]{
        var arrayTemp = [UILabel]()
        for string in strings{
            let lbtemp = UILabel()
            lbtemp.text = string
            lbtemp.numberOfLines = 1
            arrayTemp.append(lbtemp)
        }
        return arrayTemp
    }
}
