//
//  MessageCenterResponse.swift
//  DCCJMessageCenter
//
//  Created by 龚欢 on 2018/7/23.
//

import Foundation

public struct MessageCenterResponse: Codable {
    public let resultCode: String
    public let resultMessage: String
    public let success: Bool
    public let data: MessageDetailResponseData?
}

public struct MessageDetailResponseData: Codable {
    public let token: String
}
