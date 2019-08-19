//
//  SupportedClients.swift
//  VKAudioToken
//
//  Created by Михаил Луцкий on 19/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation

public class SupportedClients {
    public static func VkOfficial() -> VkClient {
        return VkClient(userAgent: "VKAndroidApp/5.23-2978 (Android 4.4.2; SDK 19; x86; unknown Android SDK built for x86; en; 320x240)", clientSecret: "hHbZxrka2uZ6jB1inYsH", clientId: 2274003)
    }
}
