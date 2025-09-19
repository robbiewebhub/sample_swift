//
//  UserAPIManager.swift
//  Firgun
//
//  Created by LP on 28/10/21.
//

import Foundation
import Alamofire
class UserAPIManager: NSObject {
    // typealias CompletionHandler = (_ response: Bool, _ object: AnyObject) -> Void
    typealias userCompletionHandler = (_ response: Bool, _ object: AnyObject) -> Void
    
    //MARK: Login User POST Request
    //MARK: -----------------------
    
    class func loginUser(_ params:[String: Any],completionHandler: @escaping userCompletionHandler)
    {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.Register)")!
        APIManager.sharedInstance.makePostRequestToServer(apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    class func updateDevice(_ params:[String: Any],completionHandler: @escaping userCompletionHandler)
    {
        
        let url: URLConvertible = URL(string: "\(API.updateDevice)")!
        
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
        
    }
    class func checkEmail(_ params:[String: Any],completionHandler: @escaping userCompletionHandler)
    {
        
        let url: URLConvertible = URL(string: "\(API.checkEmail)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
            }
        }
        
        
    }
    
    class func CountryList(_ params:[String: Any],completionHandler: @escaping userCompletionHandler)
    {
        
        let url: URLConvertible = URL(string: "\(API.CountryList)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:false, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
            }
        }
        
        
    }
    //MARK: Register User POST Request
    //MARK: -----------------------
    
    class func registerUser(_ params:[String: Any],completionHandler: @escaping userCompletionHandler)
    {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.Register)")!
        APIManager.sharedInstance.makePostRequestToServer(apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    
    
    //MARK: codeVerify User POST Request
    //MARK: -----------------------
    class func codeVerify(_ params:[String: Any],completionHandler: @escaping userCompletionHandler)
    {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.verifyUser)")!
        APIManager.sharedInstance.makePostRequestToServer(apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    //MARK: CreatePassword User POST Request
    //MARK: -----------------------
    
    class func createPassword(_ params:[String: Any],completionHandler: @escaping userCompletionHandler)
    {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.createPassword)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
        
    }
    class func changePassword(_ params:[String: Any],completionHandler: @escaping userCompletionHandler)
    {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.changePassword)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
        
    }
    //MARK: forgotPassword User POST Request
    //MARK: -----------------------
    
    class func forgotPassword(_ params:[String: Any],completionHandler: @escaping userCompletionHandler)
    {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.forgotPassword)")!
        APIManager.sharedInstance.makePostRequestToServer(apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
        
    }
    
    class func resetPassword(_ params:[String: Any],completionHandler: @escaping userCompletionHandler)
    {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.resetPassword)")!
        /*APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }*/
        
        APIManager.sharedInstance.makePostRequestToServer(apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    class func logout(_ params:[String: Any],completionHandler: @escaping userCompletionHandler)
    {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.logout)")!
        
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    class func getProfileData(_ params:[String: Any],completionHandler: @escaping userCompletionHandler)
    {
        
        let url: URLConvertible = URL(string: "\(API.getProfile)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
            }
        }
        
        
    }
    
    
    class func updateProfile(_ params:[String: Any],completionHandler: @escaping userCompletionHandler)
    {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.updateProfile)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    class func uploadProImage(_ params:[String:String],arrObjImages:[MediaInternalModel],completionHandler: @escaping userCompletionHandler)
    {
        appDelegate.window!.showProgressHUD()
        let url:URL = URL(string: "\(API.updateProfile)")!
        APIManager.sharedInstance.makeUploadMultiImageRequestWithData(url, parameters: params, arrObjMedia: arrObjImages) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
        
    }
    
    class func pendingSubscriptionPlan(_ params:[String: Any],completionHandler: @escaping userCompletionHandler)
    {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.pendingSubscriptionPlan)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func purchaseSubscriptionPlan(_ params: [String: Any], completionHandler: @escaping userCompletionHandler) {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.purchasePlan)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow: true, apiURL: url, parameters: params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict: [String: AnyObject] = value as? Dictionary<String, AnyObject> {
                    completionHandler(true, dict as AnyObject)
                } else {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            } else {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func userIsSubscribed(_ params: [String: Any], isShowHud: Bool = false , completionHandler: @escaping userCompletionHandler) {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: API.userIsSubscribed)!
        APIManager.sharedInstance.makeGetRequestToServer(isAutomaticLoaderHide: isShowHud, isHeader: true, apiURL: url, parameters: params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    completionHandler(true, dict as AnyObject)
                } else {
                    completionHandler(false, response as AnyObject)
                    if isShowHud {
                        appDelegate.window!.dismissProgressHUD()
                    }
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            } else {
                completionHandler(false, response as AnyObject)
                if isShowHud {
                    appDelegate.window!.dismissProgressHUD()
                }
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    
    class func isNotify(_ params:[String: Any],completionHandler: @escaping userCompletionHandler)
    {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.isNotify)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            print("Here testing")
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                print("isnotify")
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    
    
    class func postList(_ params:[String: Any], isShowHud: Bool,completionHandler: @escaping userCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.postList)")!
        APIManager.sharedInstance.makeGetRequestToServer(isAutomaticLoaderHide: true, isHeader:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                    if isShowHud {
                        appDelegate.window!.dismissProgressHUD()
                    }
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    if isShowHud {
                        appDelegate.window!.dismissProgressHUD()
                    }
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                if isShowHud {
                    appDelegate.window!.dismissProgressHUD()
                }
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func statusList(_ params:[String: Any], isShowHud: Bool = false ,completionHandler: @escaping userCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        var strUrl = API.statusList
        if let userId = params["user_id"] as? Int {
            strUrl += "?userid=\(userId)"
        }
        let url: URLConvertible = URL(string: "\(strUrl)")!
        APIManager.sharedInstance.makeGetRequestToServer(isAutomaticLoaderHide: isShowHud, isHeader:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    if isShowHud {
                        appDelegate.window!.dismissProgressHUD()
                    }
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                if isShowHud {
                    appDelegate.window!.dismissProgressHUD()
                }
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func reelList(_ params:[String: Any], isShowHud: Bool = false ,completionHandler: @escaping userCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let strUrl = API.reelList
        let url: URLConvertible = URL(string: "\(strUrl)")!
        APIManager.sharedInstance.makeGetRequestToServer(isAutomaticLoaderHide: isShowHud, isHeader:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    if isShowHud {
                        appDelegate.window!.dismissProgressHUD()
                    }
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                if isShowHud {
                    appDelegate.window!.dismissProgressHUD()
                }
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func postDetails(_ params:[String: Any], isShowHud: Bool, completionHandler: @escaping userCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let strUrl = API.postDetail
        let url: URLConvertible = URL(string: "\(strUrl)")!
        APIManager.sharedInstance.makeGetRequestToServer(isAutomaticLoaderHide: true, isHeader:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func commentPost(_ params:[String: Any], completionHandler: @escaping userCompletionHandler) {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.comment)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow: false, apiURL:url, parameters: params) { (response) in
            print("Here testing")
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String: AnyObject] = value as? Dictionary<String, AnyObject> {
                    completionHandler(true, dict as AnyObject)
                } else {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            } else {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func commentLike(_ params:[String: Any],completionHandler: @escaping userCompletionHandler)
    {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.commentLike)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func radioCommentLike(_ params:[String: Any],completionHandler: @escaping userCompletionHandler)
    {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.radioCommentLike)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func candidateCommentLike(_ params:[String: Any], completionHandler: @escaping userCompletionHandler) {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.candidateCommentLike)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow: true, apiURL: url, parameters: params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    completionHandler(true, dict as AnyObject)
                } else {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title: appName, withMessage: serverError.errorMsgGeneral)
                }
            } else {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title: appName, withMessage: serverError.errorMsgGeneral)
            }
        }
    }
    
    class func postLike(_ params:[String: Any],completionHandler: @escaping userCompletionHandler)
    {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.postLike)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func getOtherUserData(_ params:[String: Any],completionHandler: @escaping userCompletionHandler) {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.otherProfile)")!
        APIManager.sharedInstance.makeGetRequestToServer(isAutomaticLoaderHide: true, isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    completionHandler(true, dict as AnyObject)
                } else {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            } else {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func followUnfollowAPI(_ params:[String: Any],completionHandler: @escaping userCompletionHandler)
    {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.followUnfollow)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func contactAPI(_ params:[String: Any],completionHandler: @escaping userCompletionHandler)
    {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.contact)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func reportAPI(_ params:[String: Any],completionHandler: @escaping userCompletionHandler)
    {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.report)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func userList(_ params:[String: Any], isShowHud: Bool, completionHandler: @escaping userCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.userList)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    if isShowHud {
                        appDelegate.window!.dismissProgressHUD()
                    }
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                if isShowHud {
                    appDelegate.window!.dismissProgressHUD()
                }
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    class func allUserList(_ params:[String: Any], isShowHud: Bool, completionHandler: @escaping userCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.alluserList)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    if isShowHud {
                        appDelegate.window!.dismissProgressHUD()
                    }
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                if isShowHud {
                    appDelegate.window!.dismissProgressHUD()
                }
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func logoutAPI(_ params:[String: Any],completionHandler: @escaping userCompletionHandler) {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.logout)")!
        APIManager.sharedInstance.makeGetRequestToServer(isAutomaticLoaderHide: true, isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    completionHandler(true, dict as AnyObject)
                } else {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            } else {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func broadcastLiveStream(_ params: [String: Any], isShowHud: Bool, completionHandler: @escaping userCompletionHandler) {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.broadcastLiveStreamApi)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    completionHandler(true, dict as AnyObject)
                } else {
                    completionHandler(false, response as AnyObject)
                    if isShowHud {
                        appDelegate.window!.dismissProgressHUD()
                    }
                }
            } else {
                completionHandler(false, response as AnyObject)
                if isShowHud {
                    appDelegate.window!.dismissProgressHUD()
                }
            }
        }
    }
    
    class func blockedUserList(_ params: [String: Any], isShowHud: Bool, completionHandler: @escaping userCompletionHandler) {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.blockedUserListApi)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    completionHandler(true, dict as AnyObject)
                } else {
                    completionHandler(false, response as AnyObject)
                    if isShowHud {
                        appDelegate.window!.dismissProgressHUD()
                    }
                }
            } else {
                completionHandler(false, response as AnyObject)
                if isShowHud {
                    appDelegate.window!.dismissProgressHUD()
                }
            }
        }
    }
    
    class func broadcastLiveStreamStop(_ params: [String: Any], isShowHud: Bool, completionHandler: @escaping userCompletionHandler) {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.broadcastLiveStreamStopApi)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    completionHandler(true, dict as AnyObject)
                } else {
                    completionHandler(false, response as AnyObject)
                    if isShowHud {
                        appDelegate.window!.dismissProgressHUD()
                    }
                }
            } else {
                completionHandler(false, response as AnyObject)
                if isShowHud {
                    appDelegate.window!.dismissProgressHUD()
                }
            }
        }
    }
    
    class func broadcastLiveStreamList(_ params: [String: Any], isShowHud: Bool, completionHandler: @escaping userCompletionHandler) {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.broadcastLiveStreamListApi)")!
        APIManager.sharedInstance.makeGetRequestToServer(isAutomaticLoaderHide: true, isHeader: true, apiURL: url, parameters: params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    completionHandler(true, dict as AnyObject)
                } else {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            } else {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func joinLiveStream(_ params: [String: Any], isShowHud: Bool, completionHandler: @escaping userCompletionHandler) {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.joinLiveStreamApi)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    completionHandler(true, dict as AnyObject)
                } else {
                    completionHandler(false, response as AnyObject)
                    if isShowHud {
                        appDelegate.window!.dismissProgressHUD()
                    }
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            } else {
                completionHandler(false, response as AnyObject)
                if isShowHud {
                    appDelegate.window!.dismissProgressHUD()
                }
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func joinLiveUserListStream(_ params: [String: Any], isShowHud: Bool, completionHandler: @escaping userCompletionHandler) {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.joinLiveStreamUserListApi)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    completionHandler(true, dict as AnyObject)
                } else {
                    completionHandler(false, response as AnyObject)
                    if isShowHud {
                        appDelegate.window!.dismissProgressHUD()
                    }
                }
            } else {
                completionHandler(false, response as AnyObject)
                if isShowHud {
                    appDelegate.window!.dismissProgressHUD()
                }
            }
        }
    }
    
    class func streamId(_ params: [String: Any], isShowHud: Bool, completionHandler: @escaping userCompletionHandler) {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.streamIdApi)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    completionHandler(true, dict as AnyObject)
                } else {
                    completionHandler(false, response as AnyObject)
                    if isShowHud {
                        appDelegate.window!.dismissProgressHUD()
                    }
                }
            } else {
                completionHandler(false, response as AnyObject)
                if isShowHud {
                    appDelegate.window!.dismissProgressHUD()
                }
            }
        }
    }
    
    class func liveStreamComment(_ params: [String: Any], isShowHud: Bool, completionHandler: @escaping userCompletionHandler) {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.liveStreamCommentApi)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    completionHandler(true, dict as AnyObject)
                } else {
                    completionHandler(false, response as AnyObject)
                    if isShowHud {
                        appDelegate.window!.dismissProgressHUD()
                    }
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            } else {
                completionHandler(false, response as AnyObject)
                if isShowHud {
                    appDelegate.window!.dismissProgressHUD()
                }
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func getLiveStreamAllComment(_ params: [String: Any], isShowHud: Bool, completionHandler: @escaping userCompletionHandler) {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.getLiveStreamAllCommentsApi)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    completionHandler(true, dict as AnyObject)
                } else {
                    completionHandler(false, response as AnyObject)
                    if isShowHud {
                        appDelegate.window!.dismissProgressHUD()
                    }
                }
            } else {
                completionHandler(false, response as AnyObject)
                if isShowHud {
                    appDelegate.window!.dismissProgressHUD()
                }
            }
        }
    }
    
    class func getLiveStreamStatus(_ params: [String: Any], isShowHud: Bool, completionHandler: @escaping userCompletionHandler) {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.checkLiveStreamStatus)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    completionHandler(true, dict as AnyObject)
                } else {
                    completionHandler(false, response as AnyObject)
                    if isShowHud {
                        appDelegate.window!.dismissProgressHUD()
                    }
                }
            } else {
                completionHandler(false, response as AnyObject)
                if isShowHud {
                    appDelegate.window!.dismissProgressHUD()
                }
            }
        }
    }
    
    class func getPhotoList(_ params:[String: Any],completionHandler: @escaping userCompletionHandler) {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.photoList)")!
        APIManager.sharedInstance.makeGetRequestToServer(isAutomaticLoaderHide: true, isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    completionHandler(true, dict as AnyObject)
                } else {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            } else {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func getReportTextList(_ params:[String: Any],completionHandler: @escaping userCompletionHandler) {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.reportTextList)")!
        APIManager.sharedInstance.makeGetRequestToServer(isAutomaticLoaderHide: true, isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    completionHandler(true, dict as AnyObject)
                } else {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            } else {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func reelPostDetail(_ params:[String: Any],completionHandler: @escaping userCompletionHandler)
    {
        appDelegate.window!.showProgressHUD()
        let strUrl = API.reelPostDetail
        let url: URLConvertible = URL(string: "\(strUrl)")!
        APIManager.sharedInstance.makeGetRequestToServer(isAutomaticLoaderHide: true, isHeader:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func radioSubscribeAPI(_ params:[String: Any],completionHandler: @escaping userCompletionHandler) {
        let url: URLConvertible = URL(string: "\(API.radioSubscribe)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow: true, apiURL: url, parameters: params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict: [String: AnyObject] = value as? Dictionary<String, AnyObject> {
                    completionHandler(true, dict as AnyObject)
                } else {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title: appName, withMessage: serverError.errorMsgGeneral)
                }
            } else {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title: appName, withMessage: serverError.errorMsgGeneral)
            }
        }
    }
    
    class func radioListnerUserList(_ params:[String: Any],completionHandler: @escaping userCompletionHandler) {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.radioListnerUserList)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    completionHandler(true, dict as AnyObject)
                }
                else {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            } else {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
}


extension Result {
    /// Returns whether the instance is `.success`.
    var isSuccess: Bool {
        guard case .success = self else { return false }
        return true
    }
}
