//
//  DataStorage.swift
//  BalinaSoft <testTask>
//
//  Created by Ivan Myrza on 01/11/2019.
//  Copyright © 2019 Ivan Myrza. All rights reserved.
//

import Foundation
import UIKit

struct JsonBase : Codable {
    
    var page : Int?
    var pageSize : Int?
    var totalPages : Int?
    var totalElements : Int?
    var content : [Content]
}
struct Content : Codable {
    var id : Int?
    var name : String?
}

struct Picture {
    
    var developerName: Data
    var id: Data
    var image: Data
    
    init(developerName: String, id: Int, image: UIImage) {
        
        self.developerName = Data(developerName.utf8)
        self.id = Data("\(id)".utf8)
        self.image = image.pngData()!
    }
}
