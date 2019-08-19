//
//  TokenReceiverOfficial.swift
//  VKAudioToken
//
//  Created by Михаил Луцкий on 19/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

public class TokenReceiverOfficial {
    private var params: CommonParams!
    private var login: String!
    private var pass: String!
    private var scope: String!
    private var id: Int!
    private var client: VkClient!
    
    public init(login: String, pass: String, params: CommonParams = CommonParams(), scope: String = "nohttps,all") {
        self.params = params
        self.login = login
        self.pass = pass
        self.scope = scope
        self.client = SupportedClients.VkOfficial()
    }
    
    public func getToken(success: @escaping(_ token: String, _ secret: String, _ deviceId: String) -> Void, fail: @escaping(_ error: Any) -> Void) {
        getNonRefreshed(success: { (token, secret, deviceId) in
            self.refreshToken(token: token, secret: secret, deviceId: deviceId, success: {
                t in
                success(t, secret, deviceId)
            }, error: {
                err in
                fail(err)
            })
        }) { (error) in
            fail(error)
        }
    }
    
    private func getNonRefreshed(success: @escaping(_ token: String, _ secret: String, _ deviceId: String) -> Void, fail:@escaping(_ err: Any) -> Void) {
        let deviceId = generateRandomString(length: 16, characters: "0123456789abcdef")
        
        let parameters: Parameters = [
            "grant_type": "password",
            "client_id": client.getClientId(),
            "client_secret": client.getClientSecret(),
            "username": login ?? "",
            "password": pass ?? "",
            "v": 5.93,
            "scope": scope ?? "",
            "lang": "en",
            "fa_supported": 1,
            "device_id": deviceId
        ]
        
        params.setCommonVK()
        
        let headers = [
            "User-Agent": params.ua
        ]
        
        Alamofire.request("https://oauth.vk.com/token", method: .get, parameters: parameters, headers: headers).responseJSON { (response) in
            let model = Mapper<TokenModel>().map(JSONObject: response.value)
            if let model = model, let _ = model.user_id {
                success(model.access_token, model.secret, deviceId)
            } else {
                fail(response.result.value!)
            }
        }
    }
    
    private func refreshToken(token: String, secret: String, deviceId: String, success: @escaping(_ token: String) -> Void, error: @escaping(_ error: Any) -> Void) {
        performRequest(method: "execute.getUserInfo", postFields:
            [
                "v": 5.93,
                "https": 1,
                "androidVersion": 19,
                "androidModel": "Android SDK built for x86",
                "info_fields": "audio_ads,audio_background_limit,country,discover_design_version,discover_preload,discover_preload_not_seen,gif_autoplay,https_required,inline_comments,intro,lang,menu_intro,money_clubs_p2p,money_p2p,money_p2p_params,music_intro,audio_restrictions,profiler_settings,raise_to_record_enabled,stories,masks,subscriptions,support_url,video_autoplay,video_player,vklive_app,community_comments,webview_authorization,story_replies,animated_stickers,community_stories,live_section,playlists_download,calls,security_issue,eu_user,wallet,vkui_community_create,vkui_profile_edit,vkui_community_manage,vk_apps,stories_photo_duration,stories_reposts,live_streaming,live_masks,camera_pingpong,role,video_discover",
                "device_id": deviceId,
                "lang": "en",
                "func_v": 11,
                "androidManufacturer": "unknown",
                "fields": "photo_100,photo_50,exports,country,sex,status,bdate,first_name_gen,last_name_gen,verified,trending",
                "access_token": token
            ], secret: secret, success: { _ in
                self.performRequest(method: "auth.refreshToken", postFields:
                    [
                        "v": 5.93,
                        "https:": 1,
                        "timestamp": 0,
                        "receipt2": "",
                        "device_id": deviceId,
                        "receipt": "",
                        "lang": "en",
                        "nonce": "",
                        "access_token": token
                    ], secret: secret, success: {
                        response in
                        let token = Mapper<ResponseModel>().map(JSONObject: response)
                        success(token!.response.token)
                }, fail: {
                    err in
                    error(err)
                })

        }, fail: {
            err in
            error(err)
        })
        
    }
    
    private func performRequest(method: String, postFields: Parameters, secret: String, success: @escaping(_ model: Any) -> Void, fail: @escaping(_ error: Any) -> Void) {
        params.setCommonVK()
        
        let headers = [
            "User-Agent": params.ua
        ]
        
        let url = "https://api.vk.com/method/" + method
        
        var parameters: Parameters = postFields
        let sortedKeys = Array(parameters.keys).sorted(by: <)

        var stringForMD5 = "/method/\(method)?"
        for key in sortedKeys {
            stringForMD5 = stringForMD5 + key + "=\(parameters[key] ?? "")&"
        }
        if stringForMD5.last! == "&" {
            stringForMD5.remove(at: stringForMD5.index(before: stringForMD5.endIndex))
        }
        stringForMD5 = stringForMD5 + secret
        parameters["sig"] = MD5.MD5(stringForMD5)
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            let error = Mapper<ErrorModel>().map(JSONObject: response.result.value)
            if let errorModel = error, let _ = errorModel.error {
                fail(response.result.value!)
            } else {
                success(response.result.value!)
            }
        }
    }
    
    private func generateRandomString(length: Int, characters: String) -> String {
        let charactersLength = characters.count
        var randomString = ""
        for _ in 0...length {
            let index = characters.index(characters.startIndex, offsetBy: Int.random(in: 0..<charactersLength))
            randomString = randomString + String(characters[index])
        }
        return randomString
    }
}
