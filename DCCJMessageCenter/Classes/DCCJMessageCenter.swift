//
//  DCCJMessageCenter.swift
//  DCCJMessageCenter
//
//  Created by 龚欢 on 2018/7/23.
//

import Foundation
import DCCJNetwork
import DCCJConfig

public enum MessageBusinessType: Int {
    case login
    case regist
    case thirdBind
    case loginPassWord
    case payPassWord
}

public enum MessageCenterRequest {
    case sendMessage(type: MessageBusinessType, phone: String)
    case verifyMessage(type: MessageBusinessType, phone: String, code: String)
}

extension MessageCenterRequest: Request {
    public var host: String {
        return DCCJNetwork.shared.hostMaps[.production]!
    }
    
    public var path: String {
        switch self {
        case .sendMessage:
            return "api/app/User/verifyCode"
        case .verifyMessage:
            return "api/app/User/checkCode"
        }
    }
    
    public var method: HTTPMethod {
        return .POST
    }
    
    public var paramters: [String : Any] {
        switch self {
        case .sendMessage(let type, let phone):
            return ["phoneNumber": phone, "type": type.rawValue]
        case .verifyMessage(let type, let phone, let code):
            return ["phoneNumber": phone, "type": type.rawValue, "code": code]
        }
    }
}

public class DCCJMessageCenter {
    
    public init() {}
    
    public func send(with r: MessageCenterRequest) -> (data: Future<MessageCenterResponse>, task: URLSessionDataTask?) {
        let (d, t) = DCCJNetwork.shared.request(with: r)
        
        let unboxdata: Future<MessageCenterResponse> = d.unboxed()
        
        return (data: unboxdata, task: t)
    }
}
