//
//  Presenter.swift
//  AssessmentChart
//
//  Created by 10362 on 2024/3/7.
//

import Foundation

class ChartPresenter{
    weak var mainView: ChartDataProtocol?
    
    init(mainView: ChartDataProtocol? = nil) {
        self.mainView = mainView
    }
    func getJSON() {
        guard let fileURL = Bundle.main.url(forResource: "JSONData", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: fileURL)
            let tppData = try JSONDecoder().decode(TPPData.self, from: data)
            let pageData = tppData.data.page.compactMap { $0 }
            self.mainView?.chartData(pageData)
        } catch {
            fatalError("Error parsing JSON: \(error)")
        }
    
        /*
     // 串API，沒成功
    func getJSON(){
        //let url = URL(string: "https://demo.srgeo.com.tw/TP_PROJECT_SV/api/v1/BGC/Search_PROJECT_Detail")!
        let url = URL(string: "https://demo.srgeo.com.tw/TP_PROJECT_SV/api/v1/BGC/Search_PROJECT")!
        //let url = URL(string: "https://demo.srgeo.com.tw")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //request.setValue("TP_PROJECT_SV/api/v1/BGC", forHTTPHeaderField: "Search_PROJECT")
        //request.setValue("AccessToken", forHTTPHeaderField: "$2y$10$RAeoDq3X8IcpsZvJGIos3eyKHJzggiq/BMUDYZzOG5Bg4BIm78Tua")
        request.setValue("aum_id", forHTTPHeaderField: "969")
        
        print(url)
        // 創建 data task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
            }
            if let data = data {
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Response data: \(responseString)")
                }
            }
        }
        task.resume()
     */
     
        /*
         // 改寫法，沒成功
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                let decoder = JSONDecoder()
                let createUserResponse = try decoder.decode(TPPData.self, from: data)
                print(createUserResponse)
            } catch {
                print(error)
            }
        }
        */
        
        /*
        let task = URLSession.shared.dataTask(with: url!) { [weak self] (data, response , error) in
            print(response)
            guard let httpResponse = response as? HTTPURLResponse,
                     (200...299).contains(httpResponse.statusCode) else {
                   print("Invalid response")
                   return
               }
            if let data = data {
                
                do {
                    let tppData = try JSONDecoder().decode(TPPData.self, from: data)
                    print(tppData)
                    let pageData = tppData.data.page.compactMap{ $0 }
                    self?.mainView?.chartData(pageData)
                } catch {
                    fatalError("Error parsing JSON: \(error)")
                }
            }
            print("No data received")
        }
        task.resume()
         */
    }
}

protocol ChartDataProtocol: AnyObject {
    func chartData(_ chartData: [Page])
}
