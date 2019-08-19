//
//  TokenModel.swift
//  VKAudioToken
//
//  Created by Михаил Луцкий on 19/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class TokenModel: Mappable {
    var access_token: String!
    var expires_in: Int!
    var https_required: Bool!
    var secret: String!
    var user_id: Int!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        access_token <- map["access_token"]
        expires_in <- map["expires_in"]
        https_required <- map["https_required"]
        secret <- map["secret"]
        user_id <- map["user_id"]
    }
}
