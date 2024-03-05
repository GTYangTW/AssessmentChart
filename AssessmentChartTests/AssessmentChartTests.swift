//
//  AssessmentChartTests.swift
//  AssessmentChartTests
//
//  Created by 10362 on 2024/2/27.
//

import XCTest
@testable import AssessmentChart
class ColorBlockLegend: UIView {
    var color: CGColor!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    convenience init(frame: CGRect, color: CGColor) {
         self.init(frame: frame)
         self.color = color
         setupView()
     }
    
    private func setupView() {
        layer.backgroundColor = color
        layer.cornerRadius = 10
        layer.borderWidth = 0.1
        layer.masksToBounds = true
    }
}
final class AssessmentChartTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        ColorBlockLegend(frame: CGRect(x: 0, y: 0, width: 80, height: 60), color: CGColor(red: 255, green: 255, blue: 255, alpha: 1.0))
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
