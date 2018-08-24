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
    public var host: NetworkEnvironment {
        return .production
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
    
    private let network: DCCJNetwork
    
    public init(net: DCCJNetwork) {
        self.network = net
    }
    
    public func send(with r: MessageCenterRequest) -> (data: Future<MessageCenterResponse>, task: URLSessionDataTask?) {
        let (d, t) = self.network.request(with: r)
        
        let unboxdata: Future<MessageCenterResponse> = d.unboxed()
        
        return (data: unboxdata, task: t)
    }
    
    public typealias ClickedType = (_ actionType: SendMessageActionTypes, _ verifyCode: String?) -> ()
    
    public func show(on showOn: UIViewController, with phoneNumber: String, then: @escaping ClickedType) {
        let sendMessageVC = SendMessageWindow(nibName: "SendMessageWindow", bundle: Bundle(for: DCCJMessageCenter.self))
        sendMessageVC.Clicked = then
        sendMessageVC.phoneNumber = phoneNumber
        sendMessageVC.modalPresentationStyle = .overCurrentContext
        showOn.present(sendMessageVC, animated: false, completion: nil)
    }
}
