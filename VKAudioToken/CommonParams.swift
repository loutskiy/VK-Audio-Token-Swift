//
//  CommonParams.swift
//  VKAudioToken
//
//  Created by Михаил Луцкий on 19/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

//    VKAudioToken - Token generate for access to VKontakte official audio.
//    Copyright (C) 2019  LUTSKII MIKHAIL
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <https://www.gnu.org/licenses/>.

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
