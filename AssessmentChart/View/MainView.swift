//
//  ViewController.swift
//  AssessmentChart
//
//  Created by 10362 on 2024/2/27.
//

import UIKit
import SnapKit
import DGCharts

class MainView: UIViewController {
    let mainScrollview = UIScrollView()
    lazy var uvDiscription = BorderWithLeftBold(frame: CGRect(x: 0, y: 0, width: view.safeAreaLayoutGuide.layoutFrame.width * 0.9, height: 100), color: color.customYellow)
    var color: ColorReferance!
    let svLegend = UIStackView()
    let legendDiscription = UIView()
    lazy var legendBlock = LegendViewBlock(text: "未發包工程", color: .darkGray)
    lazy var legendBlock1 = LegendViewBlock(text: "在建工程", color: color.customYellow)
    lazy var legendBlock2 = LegendViewBlock(text: "完工驗收中工程", color: color.customGreen)
    lazy var legendBlock3 = LegendViewBlock(text: "保固中工程", color: color.customRed)
    lazy var legendBlock4 = LegendViewBlock(text: "結案（保固期滿）", color: color.customBlue)
    lazy var arrayLegend: [LegendViewBlock] = [legendBlock, legendBlock1, legendBlock2, legendBlock3, legendBlock4]
    
    var chartData: [Page]!
    lazy var presenter = ChartPresenter(mainView: self)
    
    let lbTitleChart = UILabel()
    var barChart = BarChartView()
    
    let mainScrollView = UIScrollView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.color = ColorReferance()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainScrollview.delegate = self
        barChart.delegate = self
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        setupScrollView()
        setupDescription()
        setupLegend()
        setuplbTitle()
        presenter.getJSON()
        setupChart()
//        uvDiscription.isUserInteractionEnabled = true
//        mainScrollview.isUserInteractionEnabled = true
//        mainScrollview.delaysContentTouches = true
    }
    func setupScrollView() {
        view.addSubview(mainScrollview)
        //mainScrollview.backgroundColor = .green
        mainScrollview.snp.makeConstraints { make in
            // ScrollView 需要設置 content size 與 constraints
            make.right.left.bottom.equalToSuperview()
            make.top.equalToSuperview().inset(70)
        }
        mainScrollview.contentSize = CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: 800)
    }
    func setuplbTitle() {
        lbTitleChart.text = "工程標案依工程狀態統計"
        lbTitleChart.font = UIFont.boldSystemFont(ofSize: 20)
        mainScrollview.addSubview(lbTitleChart)
        lbTitleChart.snp.makeConstraints { make in
            make.top.equalTo(svLegend.snp.bottom).offset(50)
            make.left.equalToSuperview().inset(10)
        }
    }
    
    // frame 與 constranint 先後順序？？
    //TODO: Check height
    func setupLegend() {
        let svSpilt = splitArrayToStackview(array: arrayLegend)
        svLegend.addArrangedSubview(svSpilt)
        mainScrollview.addSubview(legendDiscription)
        legendDiscription.addSubview(svLegend)
        svLegend.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.height.equalTo(svSpilt.snp.height).offset(10)
        }
        legendDiscription.snp.makeConstraints { make in
            make.top.equalTo(uvDiscription.snp.bottom).offset(10)
//            make.left.right.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(svLegend.snp.bottom).offset(-10)
        }
    }
    func splitArrayToStackview(array: [UIView]) -> UIStackView {
        let halfCount: Int
        if array.count % 2 == 0 {
            halfCount = array.count / 2
        } else {
            halfCount = (array.count + 1) / 2
        }
        let firstHalf = Array(arrayLegend.prefix(halfCount))
        let secondHalf = Array(arrayLegend.suffix(from: halfCount))
        let svVerFirst = createVerticalStackView(arrangedSubviews: firstHalf)
        let svVerSecond = createVerticalStackView(arrangedSubviews: secondHalf)
        let svAll = createHorizontalStackView(arrangedSubviews: [svVerFirst, svVerSecond])
        return svAll
    }
    func setupDescription(){
        let lbDiscription: UILabel = {
            let label = UILabel()
            label.text = "提醒您"
            label.textColor = color.customYellow
            label.font = UIFont.boldSystemFont(ofSize: 20)
            return label
        }()
        let lbSubdiscription: UILabel = {
            let label = UILabel()
            label.text = "點擊長條圖可檢視各處標案不同狀態之詳細件數。"
            label.numberOfLines = 0
            return label
        }()
        uvDiscription.addSubview(lbDiscription)
        uvDiscription.addSubview(lbSubdiscription)
        mainScrollview.addSubview(uvDiscription)
        uvDiscription.snp.makeConstraints { make in
            // ScrollView 貼上 UIView, 需要約束成 centerY，約束成leading、trailing、left、right 都會導致不能滑動。
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.lessThanOrEqualToSuperview()
            make.height.equalTo(100)
        }
        lbDiscription.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(15)
//            make.right.lessThanOrEqualToSuperview().offset(15)
            make.height.equalTo(labelSize(label: lbDiscription).height)
        }
        lbSubdiscription.snp.makeConstraints { make in
            make.top.equalTo(lbDiscription.snp.bottomMargin).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.lessThanOrEqualTo(50)
        }
    }
    func labelSize(label: UILabel) -> CGSize {
        let labelWidth = view.frame.width - 40
        let maxSize = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
        let labelBounds = label.text?.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: label.font], context: nil)
        return labelBounds?.size ?? CGSize.zero
    }
    
    func createVerticalStackView(arrangedSubviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        return stackView
    }
    
    func createHorizontalStackView(arrangedSubviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }
    func setupChart() {
        let frameWidth = mainScrollview.snp.width
        barChart.frame = CGRect(x: 0,
                                y: 0,
                                width: self.view.frame.size.width,
                                height: self.view.frame.size.width)
        mainScrollview.addSubview(barChart)
        barChart.snp.makeConstraints { make in
            make.top.equalTo(lbTitleChart.snp.bottomMargin).offset(10)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(frameWidth)
        }
    }
    // TODO: 三元運算子修正
    func importCharData(data: [Page]) {
        var entries = [BarChartDataEntry]()
        /*
        for x in 0...10{
            entries.append(BarChartDataEntry(x: Double(x),
                                             y: Double(x)
                                            )
            )
        }
         */
        
        let dictForChart = calculateAliasAndStatus(datas: self.chartData)
        /*
        let plate = ["新工處"]
        let arrayData: [Double] = [110.0, 100.1, 11.2, 19.3, 200.4]
        for i in 0..<1 {
            entries.append(BarChartDataEntry(x: Double(i), yValues: arrayData))
        }
         */
        
        var tempX = [Double]()
        var tempY = [Double]()
        for (keys, values) in dictForChart {
            print("Values:\(values)")
            for (key , value) in values {
                tempX.append(Double(key))
                tempY.append(values[key] ?? 0)
                print("Value:\(value)")
            }
        }
        for i in 0..<dictForChart.count {
            entries.append(BarChartDataEntry(x: tempX[Int(i)],
                                             yValues: tempY))
        }
        
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: Array(dictForChart.keys))
//        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: plate)
        let set = BarChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.colorful()
        let data = BarChartData(dataSet: set)
        barChart.data = data
    }
    
    // 計算總數
    func calculateAliasAndStatus(datas: [Page]) -> [String: [Int: Double]] {
        var tempDict = [String: [Int: Double]]()
        
        for data in datas {
            let alias = data.projunitAliasname
            let status = data.projStatus
            let value = Int(status.rawValue)
            if tempDict.keys.contains(alias.rawValue){
                tempDict[alias.rawValue]?[value ?? 0, default: 0] += 1
            } else {
                tempDict[alias.rawValue] = [value ?? 0: 0]
            }
        }
        return tempDict
    }
}

extension MainView: UIScrollViewDelegate{
    
}

enum number{
    case oddNumber
    case evenNumber
}

extension MainView: ChartDataProtocol{
    func chartData(_ chartData: [Page]) {
        self.chartData = chartData
        calculateAliasAndStatus(datas: chartData)
        //print(self.chartData)
        DispatchQueue.main.async {
            self.importCharData(data: chartData)
        }
    }
}

extension MainView: ChartViewDelegate{
    
}
