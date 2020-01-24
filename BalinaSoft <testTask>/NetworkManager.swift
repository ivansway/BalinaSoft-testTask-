//
//  NetworkManager.swift
//  BalinaSoft <testTask>
//
//  Created by Ivan Myrza on 01/11/2019.
//  Copyright © 2019 Ivan Myrza. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkManagerDelegate {
    func passContent(_ content: [Content])
}

class NetworkManager {
    
    var delegate: NetworkManagerDelegate?
    var jsonObject: JsonBase?
    var emptyContent = [Content]()
    
    func fetchData(_ pageId: Int) {
        
        guard let url = URL(string: "https://junior.balinasoft.com/api/v2/photo/type/?page=\(pageId)") else { return }
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if response != nil, error == nil {
                DispatchQueue.main.async {
                    do {
                        self?.jsonObject = try JSONDecoder().decode(JsonBase.self, from: data!)
                        
                        if let dataContent = self?.jsonObject?.content {
                            self!.emptyContent += dataContent
                            self?.delegate?.passContent(self!.emptyContent)
                        }
                    } catch {
                        print("REQUEST ERROR:", error)
                    }
                }
            }
        }.resume()
    }
        
    func uploadData(_ picture: Picture) {
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(picture.image, withName: "photo", fileName: "Test image", mimeType: "image/png")
            multipartFormData.append(picture.developerName, withName: "name")
            multipartFormData.append(picture.id, withName: "typeId")
        }, to: "https://junior.balinasoft.com/api/v2/photo", method: .post)
            .responseJSON { response in
                if let data = response.data {
                    print("Data:", data)
                }
        }
    }
}
