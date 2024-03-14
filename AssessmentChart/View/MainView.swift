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
    private let mainScrollview = UIScrollView()
    lazy var uvDiscription = BorderWithLeftBold(frame: CGRect(x: 0, y: 0, width: view.safeAreaLayoutGuide.layoutFrame.width * 0.9, height: 100), color: color.customYellow)
    private var color: ColorReferance!
    private let svLegend = UIStackView()
    private let legendDiscription = UIView()
    private lazy var legendBlock = LegendViewBlock(text: "未發包工程", color: .darkGray)
    private lazy var legendBlock1 = LegendViewBlock(text: "在建工程", color: color.customYellow)
    private lazy var legendBlock2 = LegendViewBlock(text: "完工驗收中工程", color: color.customGreen)
    private lazy var legendBlock3 = LegendViewBlock(text: "保固中工程", color: color.customRed)
    private lazy var legendBlock4 = LegendViewBlock(text: "結案（保固期滿）", color: color.customBlue)
    private lazy var arrayLegend: [LegendViewBlock] = [legendBlock, legendBlock1, legendBlock2, legendBlock3, legendBlock4]
    
    private var chartData: [Page]!
    lazy var presenter = ChartPresenter(mainView: self)
    
    private let lbTitleChart = UILabel()
    private var barChart = BarChartView()
    
    private var lbDataDateRange : UILabel = {
        let label = UILabel()
        label.text = "統計區間"
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    private let viewChartInfo = UIView()
    private let btnMore : UIButton = {
        let btn = UIButton()
        btn.setTitle("檢視更多", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitleColor(ColorReferance().customBlue, for: .highlighted)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.backgroundColor = ColorReferance().customBlue
        btn.layer.cornerRadius = 10
        return btn
    }()
    private var dictForChart: [String: [Int: Double]]!
    private let userDefault = UserDefaults()
    
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
        setupBtnMore()
    }
    func setupScrollView() {
        view.addSubview(mainScrollview)
        mainScrollview.snp.makeConstraints { make in
            // ScrollView 需要設置 content size 與 constraints
            make.right.left.bottom.equalToSuperview()
            make.top.equalToSuperview().inset(70)
        }
        mainScrollview.contentSize = CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: 1000)
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
        let svVerFirst = createVerticalStackView(arrangedSubviews: firstHalf, saping: 30)
        let svVerSecond = createVerticalStackView(arrangedSubviews: secondHalf, saping: 30)
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
    
    func createVerticalStackView(arrangedSubviews: [UIView], saping: CGFloat) -> UIStackView {
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
        barChart.fitBars = true
        barChart.scaleXEnabled = false 
        barChart.scaleYEnabled = false
        barChart.xAxis.drawGridLinesEnabled = false
        barChart.rightAxis.drawZeroLineEnabled = false
        // 設置左右情況，gridLineWidth 表示橫軸上下的厚度
        barChart.rightAxis.gridLineWidth = CGFloat(0)
        // 單次長度
        barChart.leftAxis.gridLineDashLengths = [10.0]
        // Y 起使為 0
        barChart.leftAxis.axisMinimum = 0
        barChart.legend.enabled = false
        barChart.xAxis.labelPosition = .bottom
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
        setupDataDateRange()
    }
    // TODO: 三元運算子修正
    /*
     BarChartView 四個步驟
     1. 產生 BarChartDataEntry
     2. 產生 BarChartDataSet
     3. 產生 BarChartData
     4. 利用 ChartsView 顯示 BarChartData
     */
    func importCharData(data: [Page]) {
        var entries = [BarChartDataEntry]()
//        let dictForChart = calculateAliasAndStatus(datas: self.chartData)
//        print(dictForChart)
        let dictForChart: [String: [Int: Double]] = ["新工處": [10: 85.0, 110: 10.0, 0: 13.0, 130: 2.0],
                                                    "工務局": [10: 25.0, 110: 17.0, 0: 93.0, 130: 22.0],
                                                    "水利處": [10: 15.0, 110: 16.0, 0: 83.0, 130: 23.0],
                                                    "公園處": [10: 45.0, 110: 15.0, 0: 73.0, 130: 21.0],
                                                    "衛工處": [10: 55.0, 110: 12.0, 0: 53.0, 130: 25.0],
                                                    "大地處": [10: 50.0, 110: 50.0, 0: 50.0, 130: 50.0, 140: 50.0]
                                                    ]
        self.dictForChart = dictForChart
        let arrayAlias = ProjunitAliasname.allCases
        for i in 0..<dictForChart.keys.count {
            let alias = arrayAlias[i]
            guard dictForChart.keys.contains(alias.rawValue) else { return }
            let dictStatusCount: [Int: Double] = dictForChart[alias.rawValue]!

            var tempY = [Double]()
            for (status , count) in dictStatusCount {
                tempY.append(count)
            }
            entries.append(BarChartDataEntry(x: Double(i),
                                             yValues: tempY))
        }
        
        let set = BarChartDataSet(entries: entries, label: "圖例")
        set.colors = [Page.ProjStatus.contractingPj.color,
                      Page.ProjStatus.uncontractedPj.color,
                      Page.ProjStatus.completionPj.color,
                      Page.ProjStatus.finishPj.color,
                      Page.ProjStatus.warrantyPj.color]
        let data = BarChartData(dataSet: set)
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: Array(dictForChart.keys))
        barChart.data = data
        // 調整 bar width，從 barData 改
        guard barChart.barData != nil else { return }
        barChart.barData?.barWidth = 0.1
        // 調整 x 座標的數量
        barChart.xAxis.labelCount = dictForChart.values.count
    }
    func setupDataDateRange(){
        let dateFormatterMin = DateFormatter()
        dateFormatterMin.dateFormat = "yyyy-MM-dd"
        let dateFormatterMax = DateFormatter()
        dateFormatterMax.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateRange = calculateDateRange()
        mainScrollview.addSubview(lbDataDateRange)
        guard let dateMin = dateRange["min"],
              let dateMax = dateRange["max"] else { return }
        let dateStringMin = dateFormatterMin.string(from: dateMin)
        let dateStringMax = dateFormatterMax.string(from: dateMax)
        lbDataDateRange.text = "統計區間：\(dateStringMin)至\(dateStringMax)"
        let width = (lbDataDateRange.text?.width(withConstrainedHeight: 12, font: lbDataDateRange.font))! + 5
        lbDataDateRange.snp.makeConstraints { make in
            make.top.equalTo(barChart.snp.bottom)
            make.right.equalTo(barChart.snp.right)
            make.width.equalTo(width).priority(.required)
        }
    }
    
    func calculateDateRange() -> [String: Date]{
        var dictTemp = [String: Date]()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        let date = chartData.compactMap { item in
            return dateFormatter.date(from: item.cDate)
        }
        dictTemp["min"] = date.min()
        dictTemp["max"] = date.max()
        return dictTemp
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
    func setupBtnMore() {
        mainScrollview.addSubview(btnMore)
        btnMore.snp.makeConstraints { make in
            make.top.equalTo(lbDataDateRange.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(50)
        }
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
        //print(self.chartData)
        DispatchQueue.main.async {
            self.importCharData(data: chartData)
        }
    }
}

extension MainView: ChartViewDelegate{
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        // 點選功能 .entryIndex(entry: entry) 可以指向數據，需要配合 unwrappedEntry
        guard let unwrappedEntry = chartView.data?.dataSets.first as? BarChartDataSet else { return }
        // 獲取點選位置，highlight 指示點選位置
        let gesture = UITapGestureRecognizer()
        let pointInChart = CGPoint(x: highlight.xPx, y: highlight.yPx)
        // Tapped column function
        let index = unwrappedEntry.entryIndex(entry: entry)
        removeInfoView(chartView: chartView)
        
        if index != userDefault.integer(forKey: "tappedColumn") {
            updateChartViewConstraint()
            let arrayInfoData = updateInfoViewData(index: index)
            setupInfoView(intProjectCount: arrayInfoData, pointInChart: pointInChart)
        } else {
            updateInfoViewData(index: index)
        }
        userDefault.setValue(index, forKey: "tappedColumn")
    }
    func updateInfoViewData(index: Int) -> [Int] {
        let arrayAlias = ProjunitAliasname.allCases
        let currentAlias = arrayAlias[index]
        guard dictForChart.keys.contains(currentAlias.rawValue) ,
              ((dictForChart[currentAlias.rawValue]) != nil) else { return []}
        let currentStatusAndCount: [Int: Double] = dictForChart[currentAlias.rawValue]!
        let arrayStatusString = Page.ProjStatus.allCases
        let arrayStatusInt = arrayStatusString.map { Int($0.rawValue) }
        var arrayTemp = [Int]()
        
        for i in 0..<arrayStatusInt.count {
            guard let index = arrayStatusInt[i] else { return []}
            if currentStatusAndCount.keys.contains(index){
                arrayTemp.append(Int(currentStatusAndCount[index] ?? 0))
            } else {
                arrayTemp.append(0)
            }
        }
        return arrayTemp
    }
    
    func setupInfoView(intProjectCount: [Int], pointInChart: CGPoint) {
        let frameSize = CGRect(x: 0, y: 0, width: 360, height: 180)
        let chartInfoLabelView = ChartInfoLabelView(frame: frameSize, intProjectCount: intProjectCount, pointInChart: pointInChart)
        chartInfoLabelView.tag = 1
        viewChartInfo.addSubview(chartInfoLabelView)
        viewChartInfo.tag = 2
        mainScrollview.addSubview(viewChartInfo)
        viewChartInfo.snp.makeConstraints { make in
            make.top.equalTo(lbTitleChart.snp.bottomMargin).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(360)
            make.height.equalTo(180)
        }
    }
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        disableUpdateChartViewConstraint()
        removeInfoView(chartView: chartView)
    }
    func removeInfoView(chartView: ChartViewBase){
        guard let subview = mainScrollview.viewWithTag(2),
              let subChartInfoLabelview = mainScrollview.viewWithTag(1) else { return }
        subview.removeFromSuperview()
        subChartInfoLabelview.removeFromSuperview()
    }
    func updateChartViewConstraint() {
        barChart.snp.updateConstraints { make in
            make.top.equalTo(lbTitleChart.snp.bottomMargin).offset(200)
        }
    }
    func disableUpdateChartViewConstraint() {
        barChart.snp.updateConstraints { make in
            make.top.equalTo(lbTitleChart.snp.bottomMargin).offset(10)
        }
    }
}
extension String {
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}
