//
//  OtpVC.swift
//  RFP
//
//  Created by LP on 06/01/22.
//

import UIKit

import ActiveLabel
class OtpVC: BaseViewController {
    
    @IBOutlet weak var txtHiddenOtp: OTPTextField!
    @IBOutlet weak var txtFistOtp: OTPTextField!
    @IBOutlet weak var txtSecondOtp: OTPTextField!
    @IBOutlet weak var txtTherdOtp: OTPTextField!
    @IBOutlet weak var txtForthOtp: OTPTextField!
    @IBOutlet weak var viewFistOtp: ShadowView!
    @IBOutlet weak var viewSecondOtp: ShadowView!
    @IBOutlet weak var viewTherdOtp: ShadowView!
    @IBOutlet weak var viewForthOtp: ShadowView!
    @IBOutlet weak var lblResend: UILabel!
    @IBOutlet weak var btnResend: UIButton!
    @IBOutlet weak var btnTC: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var resendTimer: UILabel!
    
    let customType = ActiveType.custom(pattern: "\\sResend\\b")
    var countdownTimer: Timer!
    var totalTime = 59
    var strPhoneNumber: String = ""
    var strCCode: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupVC()
        
        nextBtn.layer.cornerRadius = self.nextBtn.frame.height/2
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func btnTCWebClicked(_ sender:Any) {
        /*let obj = UIStoryboard.WebView()
         obj.strTitle = "Terms & Conditions"
         obj.strUrl = CONSTANTS.BASE_TERMS_URL
         self.present(obj, animated: true, completion:nil)*/
    }
    
    @IBAction func btnTCClicked(_ sender:Any) {
        if(self.btnTC.isSelected) {
            self.btnTC.isSelected = false
        } else {
            self.btnTC.isSelected = true
        }
    }
    
    @IBAction func btnBackClicked(_ sender:Any) {
        self.navigationController?.popViewController(animated:true)
    }
    
    @IBAction func btnNextClicked(_ sender:Any) {
        let finalCode = txtFistOtp.text! + txtSecondOtp.text! + txtTherdOtp.text! + txtForthOtp.text!
        if(finalCode.count < 4){
            showNotificationAlert(title:appName, withMessage:kAlertMsg.otpCode)
            return
        }
        self.verifyAPI(strCode:finalCode)
    }
    
    @IBAction func btnResendClicked(_ sender: UIButton) {
        var dictParams:[String:String] = [:]
        dictParams["phone"] = self.strPhoneNumber
        dictParams["country_code"] = strCCode
        
        UserManager.sharedManager().userLogin(params:dictParams) { response, message in
            if(response) {
                self.startTimer()
                self.lblResend.isHidden = true
                self.btnResend.isHidden = true
                self.resendTimer.isHidden = false
            } else {
                self.showAlertViewWithMessage(appName, message:message)
            }
        }
    }
    
    func setupVC() {
        self.setClerColorNavBar()
        self.startTimer()
        self.txtFistOtp.delegate = self
        self.txtSecondOtp.delegate = self
        self.txtTherdOtp.delegate = self
        self.txtForthOtp.delegate = self
        self.txtFistOtp.otpTextFieldDelegate = self
        self.txtSecondOtp.otpTextFieldDelegate = self
        self.txtTherdOtp.otpTextFieldDelegate = self
        self.txtForthOtp.otpTextFieldDelegate = self
    }
    
    func setTextBackGround(tag: Int, isBack: Bool) {
        if(isBack) {
            if(tag == 1) {
                self.viewFistOtp.borderColor = UIColor.clear
            } else if(tag == 2) {
                self.viewSecondOtp.borderColor = UIColor.clear
            } else if(tag == 3) {
                self.viewTherdOtp.borderColor = UIColor.clear
            } else if(tag == 4) {
                self.viewForthOtp.borderColor = UIColor.clear
            }
        } else {
            if(tag == 1) {
                self.viewFistOtp.borderColor = UIColor.white
            } else if(tag == 2) {
                self.viewSecondOtp.borderColor = UIColor.white
            } else if(tag == 3) {
                self.viewTherdOtp.borderColor = UIColor.white
            } else if(tag == 4) {
                self.viewForthOtp.borderColor = UIColor.white
            }
        }
    }
    
    func startTimer() {
        if(self.countdownTimer == nil) {
            self.lblResend.isHidden = true
            self.btnResend.isHidden = true
            self.resendTimer.isHidden = false
            countdownTimer = Timer.scheduledTimer(timeInterval:1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        }
    }
    
    @objc func updateTime() {
        self.resendTimer.text = "Resend Code in \(timeFormatted(totalTime))"
        if totalTime != 0 {
            totalTime -= 1
        } else {
            self.totalTime = 59
            self.lblResend.isHidden = false
            self.btnResend.isHidden = false
            self.resendTimer.isHidden = true
            endTimer()
        }
    }
    
    func endTimer() {
        if(countdownTimer != nil) {
            self.countdownTimer.invalidate()
            self.countdownTimer = nil
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func verifyAPI(strCode:String) {
        var dictParams:[String:String] = [:]
        dictParams["code"] = strCode
        dictParams["phone"] = self.strPhoneNumber
        dictParams["device_type"] = deviceType
        dictParams["device_id"] = Device_ID
        dictParams["country_code"] = self.strCCode
        
        UserAPIManager.codeVerify(dictParams) { success, response in
            if success == true {
                if let objResponse = response as? [String:AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    let strMessage = objResponse["msg"] as? String ?? ""
                    if(status == 200) {
                        if let objData = objResponse["data"] as? [String:AnyObject] {
                            UserManager.sharedManager().activeUser = ModelMapper<User_Data>.map(objData)!
                            UserManager.sharedManager().saveActiveUser()
                            UserManager.sharedManager().updateProfile()
                            if UserManager.sharedManager().activeUser.need_profile_update == 1 {
                                let vc = UIStoryboard.EditProfileVC()
                                vc.screenNameCheck = "CreateProfile"
                                vc.hidesBottomBarWhenPushed = true
                                self.navigationController?.pushViewController(vc, animated: true)
                            } else {
                                let tabBarController = UIStoryboard.TabBar()
                                appDelegate.window?.rootViewController = tabBarController
                                appDelegate.window?.makeKeyAndVisible()
                            }
                        } else {
                            self.showAlertViewWithMessage(appName, message:strMessage)
                        }
                        
                    } else {
                        self.showAlertViewWithMessage(appName, message:strMessage)
                    }
                } else {
                    self.showAlertViewWithMessage(appName, message:serverError.errorMsgGeneral)
                }
                
            } else {
                self.showAlertViewWithMessage(appName, message:serverError.errorMsgGeneral)
            }
        }
    }
}

extension OtpVC:UITextFieldDelegate,OTPTextFieldDelegate {
    func textFieldDidDelete(textfield: OTPTextField) {
        let previousTag = textfield .tag - 1
        var previousResponder:UITextField?
        if(previousTag == 1) {
            previousResponder = self.txtFistOtp
        } else if(previousTag == 2) {
            previousResponder = self.txtSecondOtp
        } else if(previousTag == 3) {
            previousResponder = self.txtTherdOtp
        } else if(previousTag == 4) {
            previousResponder = self.txtForthOtp
        }
        
        if (previousResponder == nil) {
            previousResponder = self.txtFistOtp
        }
        textfield.text = ""
        previousResponder?.becomeFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == UIPasteboard.general.string {
            if string.count == 4 {}
            return true
            
        } else {
            if textField.text!.count < 1  && string.count > 0 {
                textField.textColor = UIColor.white
                let nextTag = textField.tag + 1
                var nextResponder:UITextField?
                
                if(nextTag == 1) {
                    nextResponder = self.txtFistOtp
                } else if(nextTag == 2) {
                    nextResponder = self.txtSecondOtp
                } else if(nextTag == 3) {
                    nextResponder = self.txtTherdOtp
                } else if(nextTag == 4) {
                    nextResponder = self.txtForthOtp
                }
                
                if (nextResponder == nil) {
                    textField.text = string
                    textField.resignFirstResponder()
                    return false
                } else {
                    textField.text = string
                    nextResponder?.becomeFirstResponder()
                    return false
                }
                
            } else if textField.text!.count >= 1  && string.count == 0 {
                let previousTag = textField.tag - 1
                var previousResponder:UITextField?
                
                if(previousTag == 1) {
                    previousResponder = self.txtFistOtp
                } else if(previousTag == 2) {
                    previousResponder = self.txtSecondOtp
                } else if(previousTag == 3) {
                    previousResponder = self.txtTherdOtp
                } else if(previousTag == 4) {
                    previousResponder = self.txtForthOtp
                }
                
                if (previousResponder == nil) {
                    previousResponder = self.txtFistOtp
                }
                textField.text = ""
                previousResponder?.becomeFirstResponder()
                return false
                
            } else if(string.count == 0 && textField.text!.count == 0) {
                let previousTag = textField.tag - 1
                var previousResponder:UITextField?
                
                if(previousTag == 1) {
                    previousResponder = self.txtFistOtp
                } else if(previousTag == 2) {
                    previousResponder = self.txtSecondOtp
                } else if(previousTag == 3) {
                    previousResponder = self.txtTherdOtp
                } else if(previousTag == 4) {
                    previousResponder = self.txtForthOtp
                }
                
                if (previousResponder == nil){
                    previousResponder = self.txtFistOtp
                }
                textField.text = ""
                previousResponder?.becomeFirstResponder()
                return false
                
            } else if(textField.text!.count >= 1  && string.count > 0) {
                textField.textColor = UIColor.white
                let nextTag = textField.tag + 1
                var nextResponder:UITextField?
                
                if(nextTag == 1) {
                    nextResponder = self.txtFistOtp
                } else if(nextTag == 2) {
                    nextResponder = self.txtSecondOtp
                } else if(nextTag == 3) {
                    nextResponder = self.txtTherdOtp
                } else if(nextTag == 4) {
                    nextResponder = self.txtForthOtp
                }
                
                if (nextResponder == nil) {
                    textField.text = string
                    textField.resignFirstResponder()
                    return false
                } else {
                    textField.text = string
                    nextResponder?.becomeFirstResponder()
                    return false
                }
            }
            return true
        }
    }
}

protocol OTPTextFieldDelegate: AnyObject {
    func textFieldDidDelete(textfield: OTPTextField)
}

class OTPTextField: UITextField {
    
    weak var otpTextFieldDelegate: OTPTextFieldDelegate!
    var backspaceCalled: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Methods
    override func deleteBackward() {
        super.deleteBackward()
        otpTextFieldDelegate.textFieldDidDelete(textfield: self)
    }
}
