//
//  ResponseModel.swift
//  VKAudioToken
//
//  Created by Михаил Луцкий on 19/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class ResponseModel: Mappable {
    var response: RefreshTokenModel!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        response <- map["response"]
    }
}

class RefreshTokenModel: Mappable {
    var token: String!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        token <- map["token"]
    }
}
