//
//  AppAPIManager.swift
//  Firgun
//
//  Created by LP on 01/11/21.
//

import Foundation
import Alamofire
class AppAPIManager: NSObject {
    // typealias CompletionHandler = (_ response: Bool, _ object: AnyObject) -> Void
    typealias appCompletionHandler = (_ response: Bool, _ object: AnyObject) -> Void
    
    class func getAddsList(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.getAddsList)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    class func getFavouriteList(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.getFavouriteList)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    class func favourite(_ params:[String: Any],completionHandler: @escaping appCompletionHandler)
    {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.favourite)")!
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
    class func getNotificationList(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.notificationList)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    class func getCheckVoteThemOutPending(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.checkPendingVoteThemOut)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func getCategoryList(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.getCategoryList)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func deleteAccount(_ params: [String: Any], completionHandler: @escaping appCompletionHandler) {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.deleteAccount)")!
        APIManager.sharedInstance.makeDeleteRequestToServer(true, apiURL:url, parameters: params) { (response) in
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
    
    class func getDealDetail(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.dealDetail)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
        
    }
    
    class func getFollowUserList(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.followUser)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func getFollowersList(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
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
    
    class func createPost(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.createPost)")!
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
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func requestVerification(_ params:[String: Any],completionHandler: @escaping appCompletionHandler)
    {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.requestVerification)")!
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
    
    class func createForum(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.createForum)")!
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
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func createQuestion(_ params: [String: Any], isShowHud: Bool = true, completionHandler: @escaping appCompletionHandler) {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.createQuestion)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
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
    
    class func getForumTopicList(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.ForumTopicList)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                
                if let data = response.data {
                    UserDefaults.standard.set(data, forKey: userDefaultKey.categoryList)
                }
                
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func getForumDetailsList(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.ForumList)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func getQuestionDetailsList(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler) {
        if(isShowHud) {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.questionList)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    appDelegate.window!.dismissProgressHUD()
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
    
    class func forumLike(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.ForumLike)")!
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
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func forumPin(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler) {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.ForumPin)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
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
    
    class func questionLike(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler) {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.questionLike)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
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
    
    class func questionDislike(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler) {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.questionDislike)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
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
    class func forumComment(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.ForumComment)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params, encoding: JSONEncoding.default) { (response) in
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
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func questionComment(_ params: [String: Any], isShowHud: Bool = true, completionHandler: @escaping appCompletionHandler) {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.questionComment)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params, encoding: JSONEncoding.default) { (response) in
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
    
    class func forumCommentLike(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.ForumCommentLike)")!
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
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func questionCommentLike(_ params: [String: Any], isShowHud: Bool = true, completionHandler: @escaping appCompletionHandler) {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.questionCommentLike)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
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
    
    class func getForumDetail(_ params: [String: Any], isShowHud: Bool, completionHandler: @escaping appCompletionHandler) {
        if(isShowHud) {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.ForumDetail)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    appDelegate.window!.dismissProgressHUD()
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
    
    class func getQuestionDetail(_ params: [String: Any], isShowHud: Bool, completionHandler: @escaping appCompletionHandler) {
        if(isShowHud) {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.questionDetail)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    appDelegate.window!.dismissProgressHUD()
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
    
    class func createVoteThem(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.createVoteThem)")!
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
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func getVoteThemList(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.VoteThemList)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func voteThemLike(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.VoteThemLike)")!
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
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    
    class func voteThemComment(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.VoteThemComment)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params, encoding: JSONEncoding.default) { (response) in
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
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func voteThemCommentLike(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.VoteThemCommentLike)")!
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
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    
    class func getVoteThemDetail(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.VoteThemDetail)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func createDebet(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.createDebet)")!
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
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func getDebetRequestList(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.debetrequestList)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func debetaAceptDecline(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.debetacceptDecline)")!
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
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func createEvent(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.createEvent)")!
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
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func getEventList(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.eventList)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func getEventDetail(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.eventDetail)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func joinEvent(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.eventJoin)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params, encoding: JSONEncoding.default) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func endEvent(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler) {
        if(isShowHud) {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.eventEnd)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader: true, apiURL: url, parameters: params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    appDelegate.window!.dismissProgressHUD()
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
    
    class func eventJoinResponses(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.eventJoinResponses)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params, encoding: JSONEncoding.default) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func getTrandingList(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.tranding)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func getLiveList(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.debetList)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func getAgoraToken(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.agoraToken)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func getStreamToken(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.getStream)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func getStreamDebateToken(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler) {
        if(isShowHud) {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.getStreamDebate)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    appDelegate.window!.dismissProgressHUD()
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
    
    class func debetAttend(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.debetAttend)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params, encoding: JSONEncoding.default) { (response) in
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
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func debetDetail(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.debetDetail)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    if(isShowHud)
                    {
                        appDelegate.window!.dismissProgressHUD()
                    }
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    if(isShowHud)
                    {
                        appDelegate.window!.dismissProgressHUD()
                    }
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func debetVoteCount(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.debetVoteCount)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    if(isShowHud)
                    {
                        appDelegate.window!.dismissProgressHUD()
                    }
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    if(isShowHud)
                    {
                        appDelegate.window!.dismissProgressHUD()
                    }
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func debetVote(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.debetVote)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params, encoding: JSONEncoding.default) { (response) in
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
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func debetLive(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler) {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.postStreamliveDebet)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params, encoding: JSONEncoding.default) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    completionHandler(true, dict as AnyObject)
                } else {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            } else {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func saveEventStreamData(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler) {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.saveEventStreamData)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params, encoding: JSONEncoding.default) { (response) in
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
    
    class func debetLiveLeave(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler) {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.postLiveStreamDebetLeave)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params, encoding: JSONEncoding.default) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    completionHandler(true, dict as AnyObject)
                } else {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            } else {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func votePoll(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.vote)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params, encoding: JSONEncoding.default) { (response) in
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
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func deleteEvent(_ params:[String: Any],_ completionHandler: @escaping appCompletionHandler)
    {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.deleteEvent)")!
        APIManager.sharedInstance.makeDeleteRequestToServer(true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
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
    
    
    class func attendingPeopleList(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.attendingPeopleList)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func attendingMaybePeopleList(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.attendingMaybePeopleList)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func deleteVoteThemOut(_ params:[String: Any],_ completionHandler: @escaping appCompletionHandler)
    {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.deleteVoteThemOut)")!
        APIManager.sharedInstance.makeDeleteRequestToServer(true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
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
    
    class func deleteForum(_ params:[String: Any],_ completionHandler: @escaping appCompletionHandler)
    {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.deleteForum)")!
        APIManager.sharedInstance.makeDeleteRequestToServer(true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
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
    
    class func deleteQuestion(_ params: [String: Any],_ completionHandler: @escaping appCompletionHandler) {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.deleteQuestion)")!
        APIManager.sharedInstance.makeDeleteRequestToServer(true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    appDelegate.window!.dismissProgressHUD()
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
    
    // MARK: CHAT
    
    class func chat(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.chat)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params, encoding: JSONEncoding.default) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func messageAcceptOrDecline(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler) {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.messageAcceptOrDecline)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params, encoding: JSONEncoding.default) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    appDelegate.window!.dismissProgressHUD()
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
    
    class func chatList(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.chatList)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func deleteChatList(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler) {
        if(isShowHud) {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.deleteChatList)")!
        APIManager.sharedInstance.makePostRequestToServer(true, apiURL: url, parameters: params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    appDelegate.window!.dismissProgressHUD()
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
    
    class func ChangeChatList(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler) {
        if(isShowHud) {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.changeChatListApi)")!
        APIManager.sharedInstance.makePostRequestToServer(true, apiURL: url, parameters: params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    appDelegate.window!.dismissProgressHUD()
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
    
    class func ChatMessageList(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.ChatMessageList)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    if(isShowHud) {
                        appDelegate.window!.dismissProgressHUD()
                    }
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    if(isShowHud) {
                        appDelegate.window!.dismissProgressHUD()
                    }
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                if(isShowHud) {
                    appDelegate.window!.dismissProgressHUD()
                }
            }
        }
    }
    
    class func BlockUser(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler) {
        if(isShowHud) {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.blockUser)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow: true, apiURL: url, parameters: params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict: [String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    if(isShowHud) {
                        appDelegate.window!.dismissProgressHUD()
                    }
                    completionHandler(true, dict as AnyObject)
                } else {
                    completionHandler(false, response as AnyObject)
                    if(isShowHud) {
                        appDelegate.window!.dismissProgressHUD()
                    }
                }
            } else {
                completionHandler(false, response as AnyObject)
                if(isShowHud) {
                    appDelegate.window!.dismissProgressHUD()
                }
            }
        }
    }
    
    class func reelView(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        let url: URLConvertible = URL(string: "\(API.reelView)")!
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
                    //appDelegate.window!.dismissProgressHUD()
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                //appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    
    class func getPostLikeUser(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.postLikeUser)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func getForumLikeUser(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.forumLikeUser)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func getQuestionLikeUser(_ params: [String: Any], isShowHud:Bool, completionHandler: @escaping appCompletionHandler) {
        if(isShowHud) {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.questionLikeUser)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    appDelegate.window!.dismissProgressHUD()
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
    
    
    class func getQuestionDislikeUser(_ params: [String: Any], isShowHud:Bool, completionHandler: @escaping appCompletionHandler) {
        if(isShowHud) {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.questionDislikeUserList)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    appDelegate.window!.dismissProgressHUD()
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
    
    class func deletePost(_ params:[String: Any],_ completionHandler: @escaping appCompletionHandler)
    {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.deletePost)")!
        APIManager.sharedInstance.makeDeleteRequestToServer(true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
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
    
    class func getFollowRequestList(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.followerRequestList)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func getStatesList(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.stateList)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func followRequestSend(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.followRequestSend)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params, encoding: JSONEncoding.default) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func deleteNotification(_ params:[String: Any],completionHandler: @escaping appCompletionHandler)
    {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.deleteNotification)")!
        APIManager.sharedInstance.makeDeleteRequestToServer(true, apiURL:url, parameters: params) { (response) in
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
    
    class func addCandidate(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.addCandidate)")!
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
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func candidateDetail(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.candidateDetail)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func candidateCommentPost(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.candidateCommentPost)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params, encoding: JSONEncoding.default) { (response) in
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
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func createRoom(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.createRoom)")!
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
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func roomListV2(type: String, params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.roomListV2)\(type)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func roomMembersList(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.roomMembersList)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func removeRoomMember(_ params: [String: Any], isShowHud:Bool, completionHandler: @escaping appCompletionHandler) {
        if(isShowHud) {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.removeRoomMember)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    appDelegate.window!.dismissProgressHUD()
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
    
    class func makeOrRemoveRoomAdmin(_ params: [String: Any], isShowHud:Bool, completionHandler: @escaping appCompletionHandler) {
        if(isShowHud) {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.makeOrRemoveRoomAdmin)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    appDelegate.window!.dismissProgressHUD()
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
    
    class func addRoomMember(_ params: [String: Any], isShowHud:Bool, completionHandler: @escaping appCompletionHandler) {
        if(isShowHud) {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.addRoomMember)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    appDelegate.window!.dismissProgressHUD()
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
    
    class func deleteRoom(_ params: [String: Any], isShowHud:Bool, completionHandler: @escaping appCompletionHandler) {
        if(isShowHud) {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.deleteRoom)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    appDelegate.window!.dismissProgressHUD()
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
    
    class func leaveRoom(_ params: [String: Any], isShowHud:Bool, completionHandler: @escaping appCompletionHandler) {
        if(isShowHud) {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.leaveRoom)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    appDelegate.window!.dismissProgressHUD()
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
    
    class func activeRoomMember(_ params: [String: Any], isShowHud:Bool, completionHandler: @escaping appCompletionHandler) {
        if(isShowHud) {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.activeRoomMember)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    appDelegate.window!.dismissProgressHUD()
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
    
    class func activeRoomMemberList(_ params: [String: Any], isShowHud:Bool, completionHandler: @escaping appCompletionHandler) {
        if(isShowHud) {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.activeRoomMemberList)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    appDelegate.window!.dismissProgressHUD()
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
    
    class func roomChatMessageList(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.groupChatMessageList)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    if(isShowHud) {
                        appDelegate.window!.dismissProgressHUD()
                    }
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    if(isShowHud) {
                        appDelegate.window!.dismissProgressHUD()
                    }
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                if(isShowHud) {
                    appDelegate.window!.dismissProgressHUD()
                }
            }
        }
    }
    
    class func groupChatSendMsg(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.groupChatV2)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params, encoding: JSONEncoding.default) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func voteThemOutVote(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.VoteThemOutVote)")!
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
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func getNews(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.getNews)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    if(isShowHud) {
                        appDelegate.window!.dismissProgressHUD()
                    }
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    if(isShowHud) {
                        appDelegate.window!.dismissProgressHUD()
                    }
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                if(isShowHud) {
                    appDelegate.window!.dismissProgressHUD()
                }
            }
        }
    }
    
    class func radioList(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.radioList)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    if(isShowHud) {
                        appDelegate.window!.dismissProgressHUD()
                    }
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    if(isShowHud) {
                        appDelegate.window!.dismissProgressHUD()
                    }
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                if(isShowHud) {
                    appDelegate.window!.dismissProgressHUD()
                }
            }
        }
    }
    
    class func commentRadio(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.commentRadio)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params, encoding: JSONEncoding.default) { (response) in
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
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func commentNews(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.commentNews)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params, encoding: JSONEncoding.default) { (response) in
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
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func radioDetail(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.radioDetail)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func newsDetail(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.newsDetail)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func followRequestacceptDecline(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.followRequestacceptDecline)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params, encoding: JSONEncoding.default) { (response) in
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
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func newsLike(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.newsLike)")!
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
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func newsCommentLike(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.newsCommentLike)")!
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
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func deleteChatMsg(_ params:[String: Any],_ completionHandler: @escaping appCompletionHandler)
    {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.deleteChatMsg)")!
        APIManager.sharedInstance.makeDeleteRequestToServer(true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
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
    
    class func deleteGroupChatMsg(_ params:[String: Any],_ completionHandler: @escaping appCompletionHandler) {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.deleteGroupChatMsg)")!
        APIManager.sharedInstance.makePostRequestToServer(true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    appDelegate.window!.dismissProgressHUD()
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
    
    class func acceptRoomTerms(_ params:[String: Any],_ completionHandler: @escaping appCompletionHandler) {
        appDelegate.window!.showProgressHUD()
        let url: URLConvertible = URL(string: "\(API.acceptRoomTerms)")!
        APIManager.sharedInstance.makePostRequestToServer(true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    appDelegate.window!.dismissProgressHUD()
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
    
    class func repost(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.repost)")!
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
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func postDetailFackCheck(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.postDetailFackCheck)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func remondationUsers(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.remondationUsers)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func liveComment(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.commentEvent)")!
        APIManager.sharedInstance.makePostRequestToServer(true, isMsgShow:true, apiURL:url, parameters: params, encoding: JSONEncoding.default) { (response) in
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
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func liveCommentList(_ params:[String: Any], isShowHud: Bool = true,completionHandler: @escaping appCompletionHandler)
    {
        if isShowHud {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.eventCommentList)")!
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
                    //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
                //showNotificationAlert(title:appName, withMessage:serverError.errorMsgGeneral)
            }
        }
    }
    
    class func getGovtDataList(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.govtMemberList)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
    
    class func getGovtZipDataList(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler) {
        if(isShowHud) {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.govtRepresentativeList)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict = value as? [[String: Any]] {
                    appDelegate.window!.dismissProgressHUD()
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
    
    class func getGovtDataListThirdParty(_ params:[String: Any], apiURL: URLConvertible, isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = apiURL
        APIManager.sharedInstance.makeGetRequestThirdParty(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }
  
    class func getGovtBillDataListThirdParty(_ params:[String: Any], apiURL: URLConvertible, isShowHud:Bool,completionHandler: @escaping appCompletionHandler) {
        if(isShowHud) {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = apiURL
        APIManager.sharedInstance.makeGetRequestBillThirdParty(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess) {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject> {
                    appDelegate.window!.dismissProgressHUD()
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
    
    class func getGovtDataCommiteList(_ params:[String: Any],isShowHud:Bool,completionHandler: @escaping appCompletionHandler)
    {
        if(isShowHud)
        {
            appDelegate.window!.showProgressHUD()
        }
        let url: URLConvertible = URL(string: "\(API.govtCommiteList)")!
        APIManager.sharedInstance.makeGetRequestToServer(isHeader:true, apiURL:url, parameters:params) { (response) in
            if(response.result.isSuccess)
            {
                let value = response.value
                if let dict:[String:AnyObject] = value as? Dictionary<String, AnyObject>
                {
                    appDelegate.window!.dismissProgressHUD()
                    completionHandler(true, dict as AnyObject)
                }
                else
                {
                    completionHandler(false, response as AnyObject)
                    appDelegate.window!.dismissProgressHUD()
                }
            }
            else
            {
                completionHandler(false, response as AnyObject)
                appDelegate.window!.dismissProgressHUD()
            }
        }
    }

}
