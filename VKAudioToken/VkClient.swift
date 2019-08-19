//
//  VkClient.swift
//  VKAudioToken
//
//  Created by Михаил Луцкий on 19/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation

public class VkClient {
    private var userAgent: String!
    private var clientSecret: String!
    private var clientId: Int!
    
    public init(userAgent: String, clientSecret: String, clientId: Int) {
        self.userAgent = userAgent
        self.clientSecret = clientSecret
        self.clientId = clientId
    }
    
    public func getUserAgent() -> String {
        return userAgent
    }
    
    public func getClientSecret() -> String {
        return clientSecret
    }
    
    public func getClientId() -> Int {
        return clientId
    }
}
