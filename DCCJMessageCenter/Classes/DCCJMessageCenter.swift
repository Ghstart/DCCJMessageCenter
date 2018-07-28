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
    
    public func send(_ r: MessageCenterRequest, handler: @escaping (Result<MessageCenterResponse, NSError>) -> Void) -> URLSessionDataTask? {
        return DCCJNetwork.shared.requestBy(r, completion: { (result: Result<MessageCenterResponse, DataManagerError>) -> Void in
            switch result {
            case .success(let v):
                handler(Result.success(v))
            case .failure(let e as NSError):
                handler(Result.failure(e))
            }
        })
    }
}
