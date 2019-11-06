//
//  DataStorage.swift
//  BalinaSoft <testTask>
//
//  Created by Ivan Myrza on 01/11/2019.
//  Copyright © 2019 Ivan Myrza. All rights reserved.
//

import Foundation

struct JsonBase : Codable {
    
    var page : Int?
    var pageSize : Int?
    var totalPages : Int?
    var totalElements : Int?
    var content : [Content]
}

struct Content : Codable {
   
    var id : Int
    var name : String
}
