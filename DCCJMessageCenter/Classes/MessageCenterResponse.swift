//
//  MessageCenterResponse.swift
//  DCCJMessageCenter
//
//  Created by 龚欢 on 2018/7/23.
//

import Foundation

public struct MessageCenterResponse: Codable {
    let resultCode: String
    let resultMessage: String
    let success: Bool
    let data: MessageDetailResponseData?
}

public struct MessageDetailResponseData: Codable {
    let token: String
}
