//
//  ErrorModel.swift
//  VKAudioToken
//
//  Created by Михаил Луцкий on 19/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class ErrorModel: Mappable {
    var error: String!

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        error <- map["error"]
    }
}
