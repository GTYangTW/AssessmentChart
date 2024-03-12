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
    let viewChartInfo = UIView()
    let btnMore : UIButton = {
        let btn = UIButton()
        btn.setTitle("檢視更多", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitleColor(ColorReferance().customBlue, for: .highlighted)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.backgroundColor = ColorReferance().customBlue
        btn.layer.cornerRadius = 10
        return btn
    }()
    
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
            //print("Values:\(values)")
            for (key , value) in values {
                tempX.append(Double(key))
                tempY.append(values[key] ?? 0)
                //print("Value:\(value)")
            }
        }
        for i in 0..<dictForChart.count {
            entries.append(BarChartDataEntry(x: tempX[Int(i)],
                                             yValues: tempY))
        }
        
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: Array(dictForChart.keys))
//        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: plate)
        let set = BarChartDataSet(entries: entries, label: "圖例")
        set.colors = ChartColorTemplates.colorful()
        let data = BarChartData(dataSet: set)
        barChart.data = data
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
            //print("isonDate:\(formatterDate)") // 印出轉換後的 Date 對象
        }
        //print(date)
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
        calculateAliasAndStatus(datas: chartData)
        //print(self.chartData)
        DispatchQueue.main.async {
            self.importCharData(data: chartData)
        }
    }
}

extension MainView: ChartViewDelegate{
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        updateChartViewConstraint()
        let ints = [1, 2, 4, 5]
        setupInfoView(intProjectCount: ints)
    }
    func setupInfoView(intProjectCount: [Int]) {
        let frameSize = CGRect(x: 0, y: 0, width: 360, height: 180)
        let chartInfoLabelView = ChartInfoLabelView(frame: frameSize, intProjectCount: intProjectCount)
        viewChartInfo.addSubview(chartInfoLabelView)
        viewChartInfo.tag = 10
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
        if let subviewWithTag = mainScrollview.viewWithTag(10) as? UIView {
            subviewWithTag.removeFromSuperview()
        }
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
