//
//  DownloadDataManager.swift
//  BalinaSoft <testTask>
//
//  Created by Ivan Myrza on 11/11/2019.
//  Copyright © 2019 Ivan Myrza. All rights reserved.
//

import Foundation


/*
extension MainViewController {
        
    func fetchData(_ pageId: Int) {
        guard let url = URL(string: "https://junior.balinasoft.com/api/v2/photo/type/?page=\(pageId)") else { return }
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if response != nil, error == nil {
                DispatchQueue.main.async {
                    do {
                        self?.jsonObject = try JSONDecoder().decode(JsonBase.self, from: data!)
                        self?.tableView.reloadData()
                        //print("succ response: ", self?.jsonObject as Any)
                    } catch {
                        //print("REQUEST ERROR:", error)
                    }
                    self?.refreshControl?.endRefreshing()
                }
            }
        }.resume()
    }
}
*/
