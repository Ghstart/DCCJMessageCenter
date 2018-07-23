//
//  DCCJMessageCenter.swift
//  DCCJMessageCenter
//
//  Created by 龚欢 on 2018/7/23.
//

import Foundation
import DCCJNetwork

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
        case .sendMessage(let type, _), .verifyMessage(let type, _, _):
            switch type {
            case .login:
                return ""
            case .regist:
                return ""
            case .thirdBind:
                return ""
            case .loginPassWord:
                return ""
            case .payPassWord:
                return ""
            }
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
    
    public func send(r: MessageCenterRequest, callBack: @escaping (MessageCenterResponse?, Error?) -> Void) {
        DCCJNetwork.shared.requestBy(r) { (result: Result<MessageCenterResponse, DataManagerError>) in
            switch result {
            case .success(let data):
                callBack(data, nil)
            case .failure(let e):
                callBack(nil, e)
            }
        }
    }
}
