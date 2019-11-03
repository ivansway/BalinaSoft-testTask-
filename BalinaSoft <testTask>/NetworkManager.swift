//
//  NetworkManager.swift
//  BalinaSoft <testTask>
//
//  Created by Ivan Myrza on 01/11/2019.
//  Copyright © 2019 Ivan Myrza. All rights reserved.
//

import Foundation

class NetworkManager {
    
    var jsonObject: JsonBase!
    
    func fetchData() {
                
        guard let url = URL(string: "https://junior.balinasoft.com/api/v2/photo/type") else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if response != nil, error == nil {
                do {
                    self.jsonObject = try? JSONDecoder().decode(JsonBase.self, from: data!)
                    print(self.jsonObject as Any)
                }
            }
        }.resume()
    }
}
