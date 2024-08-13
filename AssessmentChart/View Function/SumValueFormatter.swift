//
//  SumValueFormatter.swift
//  AssessmentChart
//
//  Created by 10362 on 2024/3/22.
//
// TODO: 修改成能顯示正確

import Foundation
import DGCharts

class SumValueFormatter: ValueFormatter {
    func stringForValue(_ value: Double,
                        entry: ChartDataEntry,
                        dataSetIndex: Int,
                        viewPortHandler: ViewPortHandler?) -> String {
        guard let barEntry = entry as? BarChartDataEntry,
              let nonEmpty = barEntry.yValues?.filter({ $0 > 0 }) else { return ""}
        let sum = nonEmpty.reduce(0, +)
        let matchingElements = nonEmpty.filter { $0 == value }.count
        // 去除多值重複情況
        guard matchingElements == 1,
              nonEmpty.last == value else { return ""}
        // 多值，且最後一個值的情況
//        guard Set(nonEmpty).count < nonEmpty.count,
//              entry.y == value else { return  }
        return String(sum)
    }
}
