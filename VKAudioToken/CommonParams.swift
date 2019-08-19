//
//  CommonParams.swift
//  VKAudioToken
//
//  Created by Михаил Луцкий on 19/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation

public class CommonParams {
    public var vk_ua: String!
    public var ua = ""
    
    public init(vk_ua: String? = nil) {
        if let userAgent = vk_ua {
            self.vk_ua = userAgent
        } else {
            self.vk_ua = SupportedClients.VkOfficial().getUserAgent()
        }
    }
    
    public func setCommonVK() {
        self.ua = self.vk_ua
    }
}
