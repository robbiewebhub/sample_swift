//
//  LoginVC.swift
//  RFP
//
//  Created by LP on 06/01/22.
//

import UIKit
import FittedSheets

class LoginVC:BaseViewController,selectedCountryDelegate, UITextViewDelegate {
    
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var txtViewTermsAndCond: UITextView!
    @IBOutlet weak var viewMobileBase: UIView!
    @IBOutlet weak var viewButtonBase: UIView!
    @IBOutlet weak var lblCountryCode: UILabel!
    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var mobileNumberView: UIView!
    
    var currentCountrySelected:Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupVC()
        self.setClerColorNavBar()
        nextBtn.layer.cornerRadius = self.nextBtn.frame.height/2
        
        self.view.hideKeyboardOnTapAnyView()
        mobileNumberView.layer.borderWidth = 1
        mobileNumberView.layer.borderColor = UIColor.white.cgColor
        mobileNumberView.layer.cornerRadius = self.nextBtn.frame.height/2
        
        txtPhone.attributedPlaceholder = NSAttributedString(
            string: "Enter Phone Number",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func btnCheckUnCheckClicked(_ sender: UIButton) {
        self.btnCheck.isSelected = !self.btnCheck.isSelected
    }
    
    // MARK: - @IBAction
    @IBAction func btnCountryClicked(_ sender:UIButton) {
        let objCountryPicker = UIStoryboard.CountryPicker()
        objCountryPicker.delegate = self
        let sheetController = SheetViewController(
            controller: objCountryPicker,
            sizes: [.marginFromTop(200),.marginFromTop(200.0), .fixed(500),.fullscreen])
        sheetController.dismissOnOverlayTap = true
        self.present(sheetController, animated: false, completion: nil)
    }
    
    @IBAction func btnNextClicked(_ sender:Any) {
        if(self.validationCheck()) {
            var dictParams:[String:String] = [:]
            dictParams["phone"] = self.txtPhone.text!.trim()
            dictParams["country_code"] = self.currentCountrySelected?.phoneCode!
            
            UserManager.sharedManager().userLogin(params:dictParams) { response, message in
                if(response) {
                    let obj = UIStoryboard.Otp()
                    obj.strPhoneNumber = self.txtPhone.text!
                    obj.strCCode = self.currentCountrySelected?.phoneCode ?? appDelegate.strCountryCode
                    self.navigationController?.pushViewController(obj, animated: true)
                } else {
                    self.showAlertViewWithMessage(appName, message:message)
                }
            }
        }
    }
    
    // MARK: - Navigation
    func setupVC() {
        DispatchQueue.main.async {
            self.setClerColorNavBar()
        }
        var isCountryFound = false
        for country  in appDelegate.countries {
            if(country.code == appDelegate.strCountry) {
                isCountryFound = true
                self.lblCountryCode.text = country.phoneCode
                var str = country.phoneCode!
                str = str.replacingOccurrences(of: "+", with: "")
                appDelegate.strCountryCode = str
                self.currentCountrySelected = country
            }
        }
        if(isCountryFound == false) {
            self.imgFlag.image = UIImage()
            self.lblCountryCode.text = ""
            self.currentCountrySelected = nil
        }
        self.txtViewTermsAndCond.delegate = self
        setupTermsAndConditionsTextView()
    }
    
    func setupTermsAndConditionsTextView() {
           let str = "By providing the phone number, I accept the Terms & Conditions."
           let attrStr = NSMutableAttributedString(string: str)
           let range = (str as NSString).range(of: "Terms & Conditions.")
           let url = URL(string: "http://18.116.143.150/backend/terms")!
           let fontReg = UIFont(name: kFonts.fontRegular, size: 13)!
           attrStr.setAttributes([.foregroundColor: UIColor.white, .font: fontReg], range: NSRange(location: 0, length: str.count))
           attrStr.setAttributes([.link: url, .font: fontReg, .foregroundColor: UIColor.white, .underlineStyle: NSUnderlineStyle.single.rawValue], range: range)
           let fontBold = UIFont(name: kFonts.fontSemibold, size: 13)!
           self.txtViewTermsAndCond.linkTextAttributes = [
               NSAttributedString.Key.font: fontBold,
               NSAttributedString.Key.foregroundColor: UIColor.white
           ]
           self.txtViewTermsAndCond.attributedText = attrStr
       }

       // UITextViewDelegate method to handle link interaction
       func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
           if URL.absoluteString == "http://18.116.143.150/backend/terms" {
               let obj = UIStoryboard.WebVC()
               obj.strTitle = "Terms of Use"
               let strURL = CONSTANTS.BASE_URL_PAGE_URL + "terms"
               obj.strUrl = strURL
               self.navigationController?.pushViewController(obj, animated: true)
               return false
           }
           return true
       }
    
    func selectCountryCode(country: Country) {
        self.currentCountrySelected = country
        self.lblCountryCode.text = country.phoneCode
    }
    
    func validationCheck()-> Bool {
        if(self.currentCountrySelected == nil) {
            showNotificationAlert(title:appName, withMessage:kvalidationMsg.emptyCCode)
            return false
            
        } else if(txtPhone.text!.isEmpty) {
            showNotificationAlert(title:appName, withMessage:kvalidationMsg.phoneNumberEmpty)
            return false
            
        } else if(!txtPhone.text!.isNumeric()) {
            showNotificationAlert(title:appName, withMessage:kvalidationMsg.validPhoneNumber)
            return false
            
        } else if(txtPhone.text!.length != 10) {
            showNotificationAlert(title:appName, withMessage:kvalidationMsg.phoneNumber)
            return false
            
        } else if(self.btnCheck.isSelected == false) {
            showNotificationAlert(title:appName, withMessage:kvalidationMsg.checkTermsConditions)
            return false
        }
        return true
    }
}
