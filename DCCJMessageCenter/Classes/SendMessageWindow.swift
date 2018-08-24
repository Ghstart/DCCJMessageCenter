//
//  SendMessageWindow.swift
//  DCCJConfig
//
//  Created by 龚欢 on 2018/8/23.
//

import UIKit

public enum SendMessageActionTypes {
    case sendMessage
    case close
    case sure
}

class SendMessageWindow: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var space: NSLayoutConstraint!
    @IBOutlet weak var centerY: NSLayoutConstraint!
    
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var verifyCode: UIButton!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var sureBtn: UIButton!
    
    
    public var phoneNumber: String!
    public typealias ClickedType = (_ actionType: SendMessageActionTypes, _ verifyCode: String?) -> ()
    public var Clicked: ClickedType = {_,_  in }
    private var timer: DispatchSourceTimer?
    private var totalTime = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if phoneNumber.count == 11 { self.hideMiddleContent() }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.height.constant = UIScreen.main.bounds.size.width == 320 ? 277 : 312
        self.space.constant = UIScreen.main.bounds.size.width == 320 ? 15 : 30
        self.view.layoutIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.codeTextField.becomeFirstResponder()
        self.countingSeconds()
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }

    //MARK: - getKayboardHeight
    
    @objc func keyboardWillHide(notification: Notification) {
        self.centerY.constant = 0
        self.view.layoutIfNeeded()
    }
    
    @objc func keyboardWillChange(notification: Notification) {
       self.handleKeyBoard(notification: notification)
    }
    
    deinit {
        timer?.cancel()
        timer = nil
    }

    @IBAction func closeMessageSendWindow(_ sender: Any) {
        self.Clicked(.close, nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        if let t = sender.text, t.count > 0 {
            self.placeholderLabel.isHidden = true
        } else {
            self.placeholderLabel.isHidden = false
        }
        
        if let t = sender.text, t.count == 6 {
            self.sureBtn.backgroundColor = UIColor(red: 190/255.0, green: 164/255.0, blue: 115/255.0, alpha: 1)
            self.sureBtn.isUserInteractionEnabled = true
        } else {
            self.sureBtn.backgroundColor = UIColor(red: 221/255.0, green: 221/255.0, blue: 221/255.0, alpha: 1)
            self.sureBtn.isUserInteractionEnabled = false
        }
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.length == 1 && string.count == 0 {
            return true
        } else if let t = textField.text, t.count < 6 {
            return true
        } else {
            return false
        }
    }
    
    @IBAction func sendMessageTapped(_ sender: UIButton) {
        countingSeconds()
        self.Clicked(.sendMessage, nil)
    }
    
    @IBAction func sureTapped(_ sender: UIButton) {
        if let t = self.codeTextField.text, t.count == 6 {
            self.Clicked(.sure, t)
        } else {
            self.Clicked(.sure, nil)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}

private extension SendMessageWindow {
    private func countingSeconds() {
        verifyCode.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)
        let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.default)
        timer?.cancel()
        timer = DispatchSource.makeTimerSource(queue: queue)
        timer?.schedule(deadline: .now(), repeating: .seconds(1))
        timer?.setEventHandler { [weak self] in
            DispatchQueue.main.async {
                if var t = self?.totalTime {
                    if t <= 0 {
                        self?.verifyCode.setTitle("获取验证码", for: .normal)
                        self?.verifyCode.setTitleColor(UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1), for: .normal)
                        self?.verifyCode.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)
                        self?.verifyCode.isUserInteractionEnabled = true
                        self?.timer?.cancel()
                        self?.timer = nil
                        self?.totalTime = 60
                    } else {
                        self?.verifyCode.setTitle("重新发送\n\(t)秒", for: .normal)
                        self?.verifyCode.setTitleColor(UIColor(red: 199/255.0, green: 199/255.0, blue: 199/255.0, alpha: 1), for: .normal)
                        self?.verifyCode.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)
                        self?.verifyCode.titleLabel?.textAlignment = .center
                        self?.verifyCode.titleLabel?.lineBreakMode = .byWordWrapping
                        self?.verifyCode.isUserInteractionEnabled = false
                        t = t - 1
                        self?.totalTime = t
                    }
                }
            }
        }
        timer?.resume()
    }
    
    private func handleKeyBoard(notification: Notification) {
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        guard keyboardHeight > 0, self.centerY.constant == 0 else { return }
        
        let bottomSpace = (UIScreen.main.bounds.size.height - height.constant)/2.0
        
        if keyboardHeight > bottomSpace {
            self.centerY.constant = self.centerY.constant - (keyboardHeight - bottomSpace)
            self.view.layoutIfNeeded()
        }
    }
    
    private func hideMiddleContent() {
        let startindex = phoneNumber.index(phoneNumber.startIndex, offsetBy: 3)
        let endIndex = phoneNumber.index(startindex, offsetBy: 4)
        let replaceRange = startindex...endIndex
        phoneNumber.replaceSubrange(replaceRange, with: "****")
        phone.text = phoneNumber
    }
}

