//
//  APIManager.swift
//  Studi
//
//  Created by Abhinav Saxena on 12/28/17.
//  Copyright © 2017. All rights reserved.
//

import Foundation
import Alamofire

enum YFError: Error {
    case apiError
    case internetConnectivityError
    case serverDownError
    case unknownError
    case noError
    case logout
}

class APIManager: NSObject {
    typealias CompletionHandler = (_ response: DataResponse <Any, AFError>) -> Void
    var errorMsg = serverError.errorMsgGeneral
    class var sharedInstance : APIManager {
        struct Static {
            static let instance : APIManager = APIManager()
        }
        return Static.instance
    }
    
    fileprivate override init() {} //This prevents others from using the default '()' initializer for this class.
    fileprivate func isServerDown(_ statusCode: Int) -> YFError {
        if statusCode == 200 {
            return .noError
        } else {
            return .serverDownError
        }
    }
    
    fileprivate func validateAPIResponse(_ response: (DataResponse<Any, AFError>)) -> YFError {
        // Check Internet connectivity
        print("response: \(response.response?.allHeaderFields ?? [:])")
        print("response: \(response.error?.localizedDescription ?? "")")
        let json = response.data?.toJSON() ?? String(data: response.data ?? Data(), encoding: .utf8) ?? ""
        print("URL: ", response.request?.url ?? "")
        print("Status Code: \(response.response?.statusCode ?? 0) API Value : \(json as AnyObject) \n")
        if(response.response == nil) {
            errorMsg = "\(response.error!.localizedDescription)"
            return .unknownError
        }
        
        switch response.result {
        case .success: // internet works
            let statusCode = (response.response?.statusCode)!
            if statusCode == 200 ||  statusCode == 414 {
                let dict = response.value as? NSDictionary ?? [:]
                if dict[key.errorCode] as? Int == 414 {
                    return .logout
                }
                return .noError
            } else if statusCode == 401 {
                return .logout
            } else {
                return .unknownError
            }
        case .failure: // internet fails
            return .noError
            if response.response?.statusCode == nil {
                return .internetConnectivityError
            } else if response.response?.statusCode == 500 {
                return .unknownError
            } else if response.response?.statusCode == 404 {
                return .unknownError
            } else {
                return .unknownError
            }
        }
    }
    
    func makeUploadImageRequestWithData(_ apiURL: URL, fileType:String = "", parameters : [String: String],headerParam: [String: String],imagedata: Data,imageTagName: String, completionHandler: @escaping CompletionHandler) {
        var headers: HTTPHeaders = ["content_type":"application/json"]
        NetworkManager.sharedInstance.performRequestWithImageWithData(apiURL, method: .POST, headers: headers, parameters: parameters, imageData: imagedata, imageTagName:imageTagName) { (response) in
            switch self.validateAPIResponse(response) {
            case .logout:
                let dict = response.value as? NSDictionary ?? [:]
                let message = dict["message"] as? String ?? ""
                showAlertViewWithMessageAndActionHandler(appName, message:message) {
                    UserManager.sharedManager().userLogout()
                }
                break
            case .apiError:
                let dict = response.value as? NSDictionary ?? [:]
                let message = dict[key.message] as? String
                showNotificationAlert(title: "Error", withMessage: message!)
                break
            case .internetConnectivityError:
                showNotificationAlert(title: "Error", withMessage: serverError.errorMsgNoInternet)
                break
            case .serverDownError:
                showNotificationAlert(title: "Error", withMessage: serverError.errorMsgServerDown)
                break
            case .unknownError:
                showNotificationAlert(title: "Error", withMessage: self.errorMsg)
                break
            case .noError:
                completionHandler(response)
                break
            }
            appDelegate.window!.dismissProgressHUD()
        }
    }
    
    func makePostRequestToServer (_ isHeader:Bool = false, isMsgShow:Bool = true, apiURL: URLConvertible, parameters : [String: Any] , encoding: ParameterEncoding = JSONEncoding.default, completionHandler: @escaping CompletionHandler) {
        var headers: HTTPHeaders = [:]
        if(isHeader) {
            headers = [
                "Authorization" : "Bearer \(UserDefaults.standard.object(forKey:userDefaultKey.accessToken) as? String ?? "")",
                "Accept": "application/json",
                "Content-Type": "application/json"
            ]
        }
        NetworkManager.sharedInstance.performRequestWithURL(apiURL, method: HTTPMethod.POST, headers: headers, parameters: parameters, encoding: encoding) { (response) in
            switch self.validateAPIResponse(response) {
            case .logout:
                let dict = response.value as? NSDictionary ?? [:]
                let message = dict["message"] as? String ?? ""
                showAlertViewWithMessageAndActionHandler(appName, message:message) {
                    UserManager.sharedManager().userLogout()
                }
                break
            case .apiError:
                let dict = response.value as? NSDictionary ?? [:]
                if(dict.object(forKey: "message") != nil && isMsgShow) {
                    showNotificationAlert(title: "Error", withMessage: dict.object(forKey: "message") as! String)
                    completionHandler(response)
                } else if((dict["message"] as? NSDictionary)?.object(forKey: "resendVerification") != nil && (dict["message"] as? NSDictionary)?.object(forKey: "resendVerification") as! NSNumber == 1) {
                    completionHandler(response)
                } else {
                    completionHandler(response)
                }
                break
            case .internetConnectivityError:
                if (isMsgShow) {
                    showNotificationAlert(title: "Error", withMessage:serverError.errorMsgNoInternet)
                }
                completionHandler(response)
                break
            case .serverDownError:
                if (isMsgShow) {
                    showNotificationAlert(title: "Error", withMessage:serverError.errorMsgServerDown)
                }
                completionHandler(response)
                break
            case .unknownError:
                if (isMsgShow) {
                    showNotificationAlert(title: "Error", withMessage: self.errorMsg)
                }
                completionHandler(response)
                break
            case .noError:
                completionHandler(response)
                break
            }
            appDelegate.window!.dismissProgressHUD()
        }
    }
    
    func makeDeleteRequestToServer (_ isHeader:Bool = false, apiURL: URLConvertible, parameters : [String: Any] ,completionHandler: @escaping CompletionHandler) {
        var headers: HTTPHeaders = [:]
        if(isHeader) {
            
            headers = ["Authorization" : "Bearer \(UserDefaults.standard.object(forKey:userDefaultKey.accessToken) as! String)"]
        }
        NetworkManager.sharedInstance.performRequestWithURL(apiURL, method: HTTPMethod.DELETE, headers: headers, parameters: parameters) { (response) in
            switch self.validateAPIResponse(response) {
            case .logout:
                let dict = response.value as? NSDictionary ?? [:]
                let message = dict["message"] as? String ?? ""
                showAlertViewWithMessageAndActionHandler(appName, message:message) {
                    UserManager.sharedManager().userLogout()
                }
                break
            case .apiError:
                let dict = response.value as? NSDictionary ?? [:]
                let message = dict.object(forKey:key.message) as! Dictionary<String, Any>
                let messageText = message.values.first as? String
                if((dict["message"] as? NSDictionary)?.object(forKey: "resendVerification") != nil && (dict["message"] as? NSDictionary)?.object(forKey: "resendVerification") as! NSNumber == 1) {
                    completionHandler(response)
                } else if(messageText != nil) {
                    showNotificationAlert(title: "Error", withMessage: messageText!)
                }
                break
            case .internetConnectivityError:
                showNotificationAlert(title: "Error", withMessage: serverError.errorMsgNoInternet)
                break
            case .serverDownError:
                showNotificationAlert(title: "Error", withMessage: serverError.errorMsgServerDown)
                break
            case .unknownError:
                showNotificationAlert(title: "Error", withMessage: self.errorMsg)
                break
            case .noError:
                completionHandler(response)
                break
            }
            appDelegate.window!.dismissProgressHUD()
        }
    }
    
    func makePutRequestToServer (isAutomaticLoaderHide:Bool = false, isHeader:Bool = false, apiURL: URLConvertible, parameters : [String: Any] ,completionHandler: @escaping CompletionHandler) {
        var headers: HTTPHeaders = [:]
        if(isHeader) {
            headers["Authorization"] = UserDefaults.standard.object(forKey:userDefaultKey.accessToken) as? String
        }
        NetworkManager.sharedInstance.performRequestWithURL(apiURL, method: HTTPMethod.PUT, headers: headers, parameters: parameters) { (response) in
            switch self.validateAPIResponse(response) {
            case .logout:
                let dict = response.value as? NSDictionary ?? [:]
                let message = dict["message"] as? String ?? ""
                showAlertViewWithMessageAndActionHandler(appName, message:message) {
                    UserManager.sharedManager().userLogout()
                }
                break
            case .apiError:
                let dict = response.value as? NSDictionary ?? [:]
                let message = dict.object(forKey:key.message) as! Dictionary<String, Any>
                let messageText = message.values.first as? String
                
                if((dict["message"] as? NSDictionary)?.object(forKey: "resendVerification") != nil && (dict["message"] as? NSDictionary)?.object(forKey: "resendVerification") as! NSNumber == 1) {
                    completionHandler(response)
                } else if(messageText != nil){
                    showNotificationAlert(title: "Error", withMessage: messageText!)
                    appDelegate.window!.dismissProgressHUD()
                }
                break
            case .internetConnectivityError:
                showNotificationAlert(title: "Error", withMessage:serverError.errorMsgNoInternet)
                appDelegate.window!.dismissProgressHUD()
                break
            case .serverDownError:
                showNotificationAlert(title: "Error", withMessage:serverError.errorMsgServerDown)
                appDelegate.window!.dismissProgressHUD()
                break
            case .unknownError:
                showNotificationAlert(title: "Error", withMessage: self.errorMsg)
                appDelegate.window!.dismissProgressHUD()
                break
            case .noError:
                completionHandler(response)
                break
            }
            if(isAutomaticLoaderHide) {
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    func makeGetRequestToServer (isAutomaticLoaderHide:Bool = false, isHeader:Bool,  apiURL: URLConvertible, parameters : [String: Any],completionHandler: @escaping CompletionHandler) {
        var headers: HTTPHeaders = [:]
        if(isHeader) {
            headers = [
                "Authorization" : "Bearer \(UserDefaults.standard.object(forKey:userDefaultKey.accessToken) as? String ?? "")",
                "Accept": "application/json",
                "Content-Type": "application/json",
                "X-API-Key": CONSTANTS.PROPUBLICA_API_KEY
            ]
            
        }
        NetworkManager.sharedInstance.performRequestWithURL(apiURL, method: HTTPMethod.GET, headers: headers, parameters: parameters) { (response) in
            switch self.validateAPIResponse(response) {
            case .logout:
                let dict = response.value as? NSDictionary ?? [:]
                let message = dict["message"] as? String ?? ""
                showAlertViewWithMessageAndActionHandler(appName, message:message) {
                    UserManager.sharedManager().userLogout()
                    return
                }
                break
            case .apiError:
                let dict = response.value as? NSDictionary ?? [:]
                if let message = dict[key.message] as? String {
                    showNotificationAlert(title: "Error", withMessage: message)
                }
                break
            case .internetConnectivityError:
                showNotificationAlert(title: "Error", withMessage:serverError.errorMsgNoInternet)
                appDelegate.window!.dismissProgressHUD()
                break
            case .serverDownError:
                showNotificationAlert(title: "Error", withMessage:serverError.errorMsgServerDown)
                appDelegate.window!.dismissProgressHUD()
                break
            case .unknownError:
                showNotificationAlert(title: "Error", withMessage: self.errorMsg)
                appDelegate.window!.dismissProgressHUD()
                break
            case .noError:
                break
            }
            if(isAutomaticLoaderHide) {
                appDelegate.window!.dismissProgressHUD()
            }
            completionHandler(response)
        }
    }
    
    func makeGetRequestThirdParty (isAutomaticLoaderHide:Bool = false, isHeader:Bool,  apiURL: URLConvertible, parameters : [String: Any],completionHandler: @escaping CompletionHandler) {
        var headers: HTTPHeaders = [:]
        if(isHeader) {
            headers = [
                "Authorization" : "Bearer \(UserDefaults.standard.object(forKey:userDefaultKey.accessToken) as? String ?? "")",
                "Accept": "application/json",
                "Content-Type": "application/json",
                "X-API-Key": "h96rJ7fRB8Bm04lNkQyNCHOmPfx4Tmpw1V3Uox3H"
            ]
            
        }
        NetworkManager.sharedInstance.performRequestWithURL(apiURL, method: HTTPMethod.GET, headers: headers, parameters: parameters) { (response) in
            switch self.validateAPIResponse(response) {
            case .logout:
                let dict = response.value as? NSDictionary ?? [:]
                let message = dict["message"] as? String ?? ""
                showAlertViewWithMessageAndActionHandler(appName, message:message) {
                    UserManager.sharedManager().userLogout()
                    return
                }
                break
            case .apiError:
                let dict = response.value as? NSDictionary ?? [:]
                if let message = dict[key.message] as? String {
                    showNotificationAlert(title: "Error", withMessage: message)
                }
                break
            case .internetConnectivityError:
                showNotificationAlert(title: "Error", withMessage:serverError.errorMsgNoInternet)
                appDelegate.window!.dismissProgressHUD()
                break
            case .serverDownError:
                showNotificationAlert(title: "Error", withMessage:serverError.errorMsgServerDown)
                appDelegate.window!.dismissProgressHUD()
                break
            case .unknownError:
                showNotificationAlert(title: "Error", withMessage: self.errorMsg)
                appDelegate.window!.dismissProgressHUD()
                break
            case .noError:
                break
            }
            if(isAutomaticLoaderHide) {
                appDelegate.window!.dismissProgressHUD()
            }
            completionHandler(response)
        }
    }
    
    func makeGetRequestBillThirdParty (isAutomaticLoaderHide:Bool = false, isHeader:Bool,  apiURL: URLConvertible, parameters : [String: Any],completionHandler: @escaping CompletionHandler) {
        var headers: HTTPHeaders = [:]
        if(isHeader) {
            headers = [
                "Authorization" : "Bearer \(UserDefaults.standard.object(forKey:userDefaultKey.accessToken) as? String ?? "")",
                "Accept": "application/json",
                "Content-Type": "application/json",
                "X-API-Key": API.governmentBillApiKey
            ]
            
        }
        NetworkManager.sharedInstance.performRequestWithURL(apiURL, method: HTTPMethod.GET, headers: headers, parameters: parameters) { (response) in
            switch self.validateAPIResponse(response) {
            case .logout:
                let dict = response.value as? NSDictionary ?? [:]
                let message = dict["message"] as? String ?? ""
                showAlertViewWithMessageAndActionHandler(appName, message:message) {
                    UserManager.sharedManager().userLogout()
                    return
                }
                break
            case .apiError:
                let dict = response.value as? NSDictionary ?? [:]
                if let message = dict[key.message] as? String {
                    showNotificationAlert(title: "Error", withMessage: message)
                }
                break
            case .internetConnectivityError:
                showNotificationAlert(title: "Error", withMessage:serverError.errorMsgNoInternet)
                appDelegate.window!.dismissProgressHUD()
                break
            case .serverDownError:
                showNotificationAlert(title: "Error", withMessage:serverError.errorMsgServerDown)
                appDelegate.window!.dismissProgressHUD()
                break
            case .unknownError:
                showNotificationAlert(title: "Error", withMessage: self.errorMsg)
                appDelegate.window!.dismissProgressHUD()
                break
            case .noError:
                break
            }
            if(isAutomaticLoaderHide) {
                appDelegate.window!.dismissProgressHUD()
            }
            completionHandler(response)
        }
    }
    
    func makeUploadMultiImageRequestWithData(_ apiURL:URL, fileType:String = "", parameters : [String: String],arrObjMedia:[MediaInternalModel], completionHandler: @escaping CompletionHandler) {
        var headers: HTTPHeaders = [:]
        headers = [
            "Authorization" : "Bearer \(UserDefaults.standard.object(forKey:userDefaultKey.accessToken) as? String ?? "")",
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        NetworkManager.sharedInstance.performRequestWithMultiImageWithData(apiURL, method:.POST, headers:headers, parameters:parameters, arrMedia:arrObjMedia) { (response) in
            switch self.validateAPIResponse(response) {
            case .logout:
                let dict = response.value as? NSDictionary ?? [:]
                let message = dict["message"] as? String ?? ""
                showAlertViewWithMessageAndActionHandler(appName, message:message) {
                    UserManager.sharedManager().userLogout()
                }
                break
            case .apiError:
                let dict = response.value as? NSDictionary ?? [:]
                let message = dict[key.message] as? String
                showNotificationAlert(title: "Error", withMessage: message!)
                break
            case .internetConnectivityError:
                showNotificationAlert(title: "Error", withMessage: serverError.errorMsgNoInternet)
                break
            case .serverDownError:
                showNotificationAlert(title: "Error", withMessage: serverError.errorMsgServerDown)
                break
            case .unknownError:
                showNotificationAlert(title: "Error", withMessage: self.errorMsg)
                break
            case .noError:
                completionHandler(response)
                break
            }
            appDelegate.window!.dismissProgressHUD()
        }
    }
}

extension Data {
    func toJSON() -> String? {
        do {
            let jsonObj = try JSONSerialization.jsonObject(with: self, options: [])
            let json = try JSONSerialization.data(withJSONObject: jsonObj, options: .prettyPrinted)
            return String(data: json, encoding: .utf8)
        } catch {
            print("errorrrrrr", error)
        }
        return nil
    }
    
}

extension Dictionary where Key == String {
    func toJSON() -> String? {
        do {
            let json = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(data: json, encoding: .utf8)
        } catch {
            print("errorrrrrr", error)
        }
        return nil
    }
}
