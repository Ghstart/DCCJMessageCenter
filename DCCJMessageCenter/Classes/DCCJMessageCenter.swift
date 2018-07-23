//
//  DCCJMessageCenter.swift
//  DCCJMessageCenter
//
//  Created by 龚欢 on 2018/7/23.
//

import Foundation
import DCCJNetwork

enum MessageBusinessType: Int {
    case login
    case regist
    case thirdBind
    case loginPassWord
    case payPassWord
}

enum MessageCenterRequest {
    case sendMessage(type: MessageBusinessType, phone: String)
    case verifyMessage(type: MessageBusinessType, phone: String, code: String)
}

extension MessageCenterRequest: Request {
    public var host: String {
        return DCCJNetwork.shared.hostMaps[.production]!
    }
    
    var path: String {
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
    
    var method: HTTPMethod {
        return .POST
    }
    
    var paramters: [String : Any] {
        switch self {
        case .sendMessage(let type, let phone):
            return ["phoneNumber": phone, "type": type.rawValue]
        case .verifyMessage(let type, let phone, let code):
            return ["phoneNumber": phone, "type": type.rawValue, "code": code]
        }
    }
}

class DCCJMessageCenter {
    func send() {
        let q = MessageCenterRequest.sendMessage(type: .login, phone: "110")
        DCCJNetwork.shared.requestBy(q) { (result: Result<MessageCenterResponse, DataManagerError>) in
   
        }
    }
}
