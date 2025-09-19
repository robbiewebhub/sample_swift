//
//  UserManager.swift
//  Driver
//
//  Created by LP on 19/02/20.
//  Copyright © 2020. All rights reserved.
//

/*
 com.barred.app
 */

import Foundation
import UIKit

//MARK: - UseDefaults Fields key names
struct userDefaultKey {
    static let token = "token"
    static let errorCode = "errorCode"
    static let errorMessage = "errorMessage"
    static let title = "title"
    static let firstName = "firstName"
    static let userdata = "userdata"
    static let KPushToken = "push_token"
    static let KPushTokenData = "push_token_data"
    static let id_token = "id_token"
    static let username = "username"
    static let user_status = "user_status"
    static let activeUser = "activeUser"
    static let deviceID = "deviceID"
    static let accessToken = "accessToken"
    static let authToken = "auth_token"
    static let userEmail = "userEmail"
    static let basepath = "basepath"
    static let KWelcomePopup = "wel_popup"
    static let tutorialDone = "tutorial"
    static let wellcomeDone = "wellcome"
    static let chatTutorial = "chatTutorial"
    static let chatToken = "chatToken"
    static let userPhone = "userPhone"
    static let userId = "user_Id"
    static let categoryList = "categoryList"
}

// MARK: - saveUserProfilePic
func saveUserProfilePic(param: String) {
    UserDefaults.standard.setValue(param, forKeyPath: "userProfilePic")
    UserDefaults.standard.synchronize()
}
// MARK: - saveSenderProfilePic
func saveSenderProfileEmail(param: String) {
  UserDefaults.standard.setValue(param, forKeyPath: "senderProfilePic")
  UserDefaults.standard.synchronize()
}
func getUserProfilePic() -> String {
    let userProfilePic = UserDefaults.standard.value(forKey: "userProfilePic") as? String ?? ""
    return userProfilePic
}
func getSenderProfileEmail() -> String {
  let userProfilePic = UserDefaults.standard.value(forKey: "senderProfilePic") as? String ?? ""
  return userProfilePic
}

/// User Manager - manages all feature for User model
class UserManager: NSObject {
    // var addressDelegate:handleAddressResponseDelegate! = nil
    var _activeUser: User_Data?
    var PScompanyId: String = ""
    var ProfileType:String = ""
    var isPersonalProfile:Bool = true
    var activeUser: User_Data!
    {
        get {
            _activeUser?.is_subscribe = 1
            return _activeUser
        }
        set {
            _activeUser = newValue
            self.saveActiveUser()
        }
    }
    
    // MARK: Singleton Instance
    static let _sharedManager = UserManager()
    class func sharedManager() -> UserManager {
        return _sharedManager
    }
    
    override init() {
        super.init()
        
        if isUserLoggedIn() {
            loadActiveUser()
        }
    }
    
    func isTutorialLoggedIn() -> Bool {
        guard let _ = UserDefaults.objectForKey(userDefaultKey.tutorialDone)
        else {
            return false
        }
        return true
    }
    
    func isWellcomeLoggedIn() -> Bool {
        guard let _ = UserDefaults.objectForKey(userDefaultKey.wellcomeDone)
        else {
            return false
        }
        return true
    }
    
    func isChatTutorial() -> Bool {
        guard let _ = UserDefaults.objectForKey(userDefaultKey.chatTutorial)
        else {
            return false
        }
        return true
    }
    
    func isUserLoggedIn() -> Bool {
        guard let _ = UserDefaults.objectForKey(userDefaultKey.userId)
        else {
            return false
        }
        guard let _ = UserDefaults.objectForKey(userDefaultKey.accessToken)
        else {
            return false
        }
        return true
    }
    
    func saveTutorialLoggedIn() {
        UserDefaults.setObject("1" as AnyObject, forKey:userDefaultKey.tutorialDone)
        UserDefaults.standard.synchronize()
    }
    
    func saveWellcomeLoggedIn() {
        UserDefaults.setObject("1" as AnyObject, forKey:userDefaultKey.wellcomeDone)
        UserDefaults.standard.synchronize()
    }
    
    func saveChatTutorial() {
        UserDefaults.setObject("1" as AnyObject, forKey:userDefaultKey.chatTutorial)
        UserDefaults.standard.synchronize()
    }
    
    func setRootToLoginSuccessScreen() {
        if(UserDefaults.objectForKey(userDefaultKey.activeUser) != nil) {
            let dict =  UserDefaults.objectForKey(userDefaultKey.activeUser) as! [String:AnyObject]
            self.activeUser = ModelMapper<User_Data>.map(dict)!
        }
        self.getProfileData()
        let tabBarController = UIStoryboard.TabBar()
        appDelegate.window?.rootViewController = tabBarController
        appDelegate.window?.makeKeyAndVisible()
        
    }
    
    func userLogout() {
        UserDefaults.standard.removeObject(forKey:userDefaultKey.userId)
        UserDefaults.standard.removeObject(forKey:userDefaultKey.accessToken)
        UserDefaults.standard.removeObject(forKey:userDefaultKey.activeUser)
        UserDefaults.standard.removeObject(forKey: "userProfilePic")
        UserDefaults.standard.synchronize()
        self.setRootToLoginScreen()
    }
    
    func setRootToLoginScreen() {
        let objLogin = UIStoryboard.Login()
        var navController: UINavigationController? = nil
        navController = UINavigationController(rootViewController: objLogin)
        navController?.isNavigationBarHidden = true
        appDelegate.window?.rootViewController = navController
        appDelegate.window?.makeKeyAndVisible()
    }
    
    // MARK: - KeyChain / User Defaults / Flat file / XML
    func getActiveUserAndLoadHomeScreen() {
        if(UserDefaults.objectForKey(userDefaultKey.activeUser) != nil) {
            let dict =  UserDefaults.objectForKey(userDefaultKey.activeUser) as! [String:AnyObject]
            self.activeUser = ModelMapper<User_Data>.map(dict)!
        }
    }
    
    func getUserAuth() -> String {
        if(UserDefaults.objectForKey(userDefaultKey.accessToken) != nil) {
            return UserDefaults.objectForKey(userDefaultKey.accessToken) as! String
        } else {
            return ""
        }
    }
    
    func getUserId() -> Int {
        if(UserDefaults.objectForKey(userDefaultKey.userId) != nil) {
            return UserDefaults.objectForKey(userDefaultKey.userId) as! Int
        } else {
            return 0
        }
    }
    
    func getBaseImagePath() -> String {
        if(UserDefaults.objectForKey(userDefaultKey.basepath) != nil) {
            return UserDefaults.objectForKey(userDefaultKey.basepath) as! String
        } else {
            return ""
        }
    }
    
    func getLoginStatus() -> Bool {
        if((UserDefaults.objectForKey(userDefaultKey.accessToken)) != nil) {
            return true
        } else {
            return false
        }
    }
    
    func loadActiveUser() {
        guard let decodedUser = UserDefaults.objectForKey(userDefaultKey.authToken) as? User_Data,
              let user = UserDefaults.objectForKey(userDefaultKey.activeUser) as? User_Data
        else {
            return
        }
        self.activeUser = user
    }
    
    func lastLoggedUserEmail() -> String? {
        return UserDefaults.objectForKey(userDefaultKey.userEmail) as? String
    }
    
    // Save current user data
    func saveActiveUser() {
        let userId:Int = activeUser.id
        UserDefaults.setObject(userId as AnyObject, forKey: userDefaultKey.userId)
        
        let userAuthToken:String = (activeUser.access_token as String?)!
        UserDefaults.setObject(userAuthToken as AnyObject, forKey:userDefaultKey.accessToken)
        
        let userPhone:String = activeUser.phone
        UserDefaults.setObject(userPhone as AnyObject, forKey:userDefaultKey.userPhone)
        UserDefaults.standard.synchronize()
    }
    
    // Update current user data
    func updateActiveUser() {
        saveActiveUser()
    }
    
    //Save Device Token
    func saveDeviceToken(token:String) {
        UserDefaults.setObject(token as AnyObject?, forKey:userDefaultKey.KPushToken)
        UserDefaults.standard.synchronize()
    }
    
    func saveDeviceTokenData(token:Data) {
        UserDefaults.setObject(token as AnyObject?, forKey:userDefaultKey.KPushTokenData)
        UserDefaults.standard.synchronize()
    }
    
    func getPhoneNumber() -> String {
        if((UserDefaults.objectForKey(userDefaultKey.userPhone)) != nil) {
            return UserDefaults.objectForKey(userDefaultKey.userPhone) as! String;
        } else {
            return "";
        }
    }
    
    func getDeviceToken() -> String {
        if((UserDefaults.objectForKey(userDefaultKey.KPushToken)) != nil) {
            return UserDefaults.objectForKey(userDefaultKey.KPushToken) as! String;
        } else {
            return "";
        }
    }
    
    func getDeviceTokenData() -> Data? {
        if((UserDefaults.objectForKey(userDefaultKey.KPushTokenData)) != nil) {
            return UserDefaults.objectForKey(userDefaultKey.KPushTokenData) as! Data;
        } else {
            return nil;
        }
    }
    
    // TwilioConversationsClient Token
    func saveTwilioToken(token:String) {
        UserDefaults.setObject(token as AnyObject?, forKey:userDefaultKey.chatToken)
        UserDefaults.standard.synchronize()
    }
    
    func getSaveTwilioToken() -> String {
        if((UserDefaults.objectForKey(userDefaultKey.chatToken)) != nil) {
            return UserDefaults.objectForKey(userDefaultKey.chatToken) as! String;
        } else {
            return "";
        }
    }
    
    func getPopupShowLogin() -> Bool {
        if((UserDefaults.boolForKey(defaultName:userDefaultKey.KWelcomePopup)) != nil) {
            return UserDefaults.boolForKey(defaultName:userDefaultKey.KWelcomePopup) ?? false
        } else {
            return false;
        }
    }
    
    func setPopupShowLogin(isSet:Bool) {
        UserDefaults.setBool(value:isSet, forKey:userDefaultKey.KWelcomePopup)
        UserDefaults.standard.synchronize()
    }
    
    // Delete current user data
    func deleteActiveUser() {
        // remove active user from storage
        UserDefaults.removeObjectForKey(userDefaultKey.activeUser)
    }
    
    func toUserDictionary(objUser:User_Data) -> [String:AnyObject] {
        var dictionary:[String:AnyObject] = [:]
        dictionary["id"] = objUser.id as AnyObject?
        dictionary["country_code"] = objUser.country_code as AnyObject?
        dictionary["access_token"] = objUser.access_token as AnyObject?
        dictionary["email"] = objUser.email as AnyObject?
        dictionary["first_name"] = objUser.first_name as AnyObject?
        dictionary["last_name"] = objUser.last_name as AnyObject?
        dictionary["device_id"] = objUser.device_id as AnyObject?
        dictionary["device_type"] = objUser.device_type as AnyObject?
        dictionary["is_active_profile"] = objUser.is_active_profile as AnyObject?
        dictionary["last_login"] = objUser.last_login as AnyObject?
        dictionary["device_id"] = objUser.device_id as AnyObject?
        dictionary["device_token"] = objUser.device_token as AnyObject?
        dictionary["user_status"] = objUser.user_status as AnyObject?
        dictionary["phone"] = objUser.phone as AnyObject?
        dictionary["is_subscribe"] = objUser.is_subscribe as AnyObject?
        dictionary["device_token"] = objUser.device_token as AnyObject?
        dictionary["user_status"] = objUser.user_status as AnyObject?
        dictionary["photo"] = objUser.photo as AnyObject?
        return dictionary
    }
    
    func userLogin(params:[String:String],completionHandler: @escaping (_ response: Bool,_ message:String) -> Void) {
        UserAPIManager.loginUser(params) { (success,response) in
            if success == true {
                if let objResponse = response as? [String:AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    let strMessage = objResponse["msg"] as? String ?? ""
                    if(status == 200) {
                        completionHandler(true,strMessage)
                    } else {
                        completionHandler(false,strMessage)
                    }
                } else {
                    completionHandler(false,serverError.errorMsgGeneral)
                }
            } else {
                completionHandler(false,serverError.errorMsgGeneral)
            }
        }
    }
    
    func loginSignup(objResponse:[String:AnyObject]) {
        self.activeUser = ModelMapper<User_Data>.map(objResponse)!
        self.saveActiveUser()
        self.updateProfile()
        self.setRootToLoginSuccessScreen()
    }
    
    func getProfileData() {
        var dictParams:[String:String] = [:]
        //dictParams["user_type"] = "\(UserManager.sharedManager().activeUser.user_type)"
        UserAPIManager.getProfileData(dictParams) { [self]  (success,response) in
            if success == true {
                if let objResponse = response as? [String:AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    let strMessage = objResponse["msg"] as? String ?? ""
                    if(status == 200) {
                        if let objResponse = objResponse["data"]  as? [String:AnyObject] {
                            let accessToken = self.getUserAuth()
                            let userId = self.getUserId()
                            self.activeUser = ModelMapper<User_Data>.map(objResponse)!
                            self.activeUser.access_token = accessToken
                            self.activeUser.id = userId
                            self.saveActiveUser()
                            self.updateProfile()
                            
                        } else {
                            let strMessage = objResponse["msg"] as? String ?? ""
                        }
                    } else {}
                } else {}
            } else {}
        }
    }
    
    func getProfileData(completionHandler: @escaping (_ response: Bool,_ message:String) -> Void) {
        var dictParams:[String:String] = [:]
        //dictParams["user_type"] = "\(UserManager.sharedManager().activeUser.user_type)"
        UserAPIManager.getProfileData(dictParams) { [self]  (success,response) in
            if success == true {
                if let objResponse = response as? [String:AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    let strMessage = objResponse["msg"] as? String ?? ""
                    if(status == 200) {
                        if let objResponse = objResponse["data"]  as? [String:AnyObject] {
                            let accessToken = self.getUserAuth()
                            let userId = self.getUserId()
                            self.activeUser = ModelMapper<User_Data>.map(objResponse)!
                            self.activeUser.access_token = accessToken
                            self.activeUser.id = userId
                            self.saveActiveUser()
                            self.updateProfile()
                            completionHandler(true,serverError.errorMsgGeneral)
                        } else {
                            let strMessage = objResponse["msg"] as? String ?? ""
                            completionHandler(false,strMessage)
                        }
                    } else {
                        completionHandler(false,serverError.errorMsgGeneral)
                    }
                } else {
                    completionHandler(false,serverError.errorMsgGeneral)
                }
            } else {
                completionHandler(false,serverError.errorMsgGeneral)
            }
        }
    }
    
    func updateProfileData(params:[String:String], completionHandler: @escaping (_ response: Bool,_ message:String) -> Void) {
        UserAPIManager.updateProfile(params) { (success,response) in
            if success == true {
                if let objResponse = response as? [String:AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    let strMessage = objResponse["msg"] as? String ?? ""
                    if(status == 200) {
                        completionHandler(true,strMessage)
                    } else {
                        completionHandler(false,strMessage)
                    }
                } else {
                    completionHandler(false,serverError.errorMsgGeneral)
                }
            } else {
                completionHandler(false,serverError.errorMsgGeneral)
            }
        }
    }
    
    func updateProfileDataWithImage(media: MediaInternalModel, params:[String:String], completionHandler: @escaping (_ response: Bool,_ message:String) -> Void) {
        UserAPIManager.uploadProImage(params, arrObjImages: [media]) { (success,response) in
            if success == true {
                if let objResponse = response as? [String:AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    let strMessage = objResponse["msg"] as? String ?? ""
                    if(status == 200) {
                        completionHandler(true,strMessage)
                    } else {
                        completionHandler(false,strMessage)
                    }
                } else {
                    completionHandler(false,serverError.errorMsgGeneral)
                }
            } else {
                completionHandler(false,serverError.errorMsgGeneral)
            }
        }
    }
    
    func updateProfile() {
        let dict = toUserDictionary(objUser:self.activeUser)
        UserDefaults.setObject(dict as AnyObject, forKey:userDefaultKey.activeUser)
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: Notification.Name("SIDEMENU_SCREEN_UPDATE"), object: nil)
    }
    
    func saveDevice(completionHandler: @escaping (_ status:Bool) -> Void) {
        var dictData = [String:Any]()
        dictData["device_token"] = self.getDeviceToken()
        dictData["device_type"] = deviceType
        dictData["device_id"] = Device_ID
        UserAPIManager.updateDevice(dictData) { (success , response) in
            completionHandler(success)
        }
    }
    
    func getPostList(params:[String:Any], isShowHud: Bool,completionHandler: @escaping (_ response: Bool,_ object:[String:AnyObject]) -> Void) {
        UserAPIManager.postList(params, isShowHud: isShowHud) { success, object in
            if success == true {
                if let objResponse = object as? [String:AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    if(status == 200) {
                        completionHandler(true,objResponse)
                    } else {
                        completionHandler(false,objResponse)
                    }
                } else {
                    completionHandler(false,[:])
                }
            } else {
                completionHandler(false,[:])
            }
        }
    }
    
    func getStatusList(params:[String:String],completionHandler: @escaping (_ response: Bool,_ object:[String:AnyObject]) -> Void) {
        UserAPIManager.statusList(params) { success, object in
            if success == true {
                if let objResponse = object as? [String:AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    if(status == 200) {
                        completionHandler(true,objResponse)
                    } else {
                        completionHandler(false,objResponse)
                    }
                } else {
                    completionHandler(false,[:])
                }
            } else {
                completionHandler(false,[:])
            }
        }
    }
    
    func getReelList(params:[String:Any],completionHandler: @escaping (_ response: Bool,_ object:[String:AnyObject]) -> Void) {
        UserAPIManager.reelList(params) { success, object in
            if success == true {
                if let objResponse = object as? [String:AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    if(status == 200) {
                        completionHandler(true,objResponse)
                    } else {
                        completionHandler(false,objResponse)
                    }
                } else {
                    completionHandler(false,[:])
                }
            } else {
                completionHandler(false,[:])
            }
        }
    }
    
    func getPostDetails(params:[String:String], isShowHud: Bool, completionHandler: @escaping (_ response: Bool,_ object:[String:AnyObject]) -> Void) {
        UserAPIManager.postDetails(params, isShowHud: isShowHud) { success, object in
            if success == true {
                if let objResponse = object as? [String:AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    if(status == 200) {
                        completionHandler(true,objResponse)
                    } else {
                        completionHandler(false,objResponse)
                    }
                } else {
                    completionHandler(false,[:])
                }
            } else {
                completionHandler(false,[:])
            }
        }
    }
    
    func commentPost(params:[String:Any],completionHandler: @escaping (_ response: Bool,_ object:[String:AnyObject]) -> Void) {
        UserAPIManager.commentPost(params) { success, object in
            if success == true {
                if let objResponse = object as? [String:AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    if(status == 200) {
                        completionHandler(true,objResponse)
                    } else {
                        completionHandler(false,objResponse)
                    }
                } else {
                    completionHandler(false,[:])
                }
            } else {
                completionHandler(false,[:])
            }
        }
    }
    
    func commentLike(params:[String:String],completionHandler: @escaping (_ response: Bool,_ object:[String:AnyObject]) -> Void) {
        UserAPIManager.commentLike(params) { success, object in
            if success == true {
                if let objResponse = object as? [String:AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    if(status == 200) {
                        completionHandler(true,objResponse)
                    } else {
                        completionHandler(false,objResponse)
                    }
                } else {
                    completionHandler(false,[:])
                }
            } else {
                completionHandler(false,[:])
            }
        }
    }
    
    func radioCommentLike(params:[String:String],completionHandler: @escaping (_ response: Bool,_ object:[String:AnyObject]) -> Void) {
        UserAPIManager.radioCommentLike(params) { success, object in
            if success == true {
                if let objResponse = object as? [String:AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    if(status == 200) {
                        completionHandler(true,objResponse)
                    } else {
                        completionHandler(false,objResponse)
                    }
                } else {
                    completionHandler(false,[:])
                }
            } else {
                completionHandler(false,[:])
            }
        }
    }
    
    func candidateCommentLike(params: [String:String], completionHandler: @escaping (_ response: Bool,_ object:[String:AnyObject]) -> Void) {
        UserAPIManager.candidateCommentLike(params) { success, object in
            if success == true {
                if let objResponse = object as? [String:AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    if(status == 200) {
                        completionHandler(true,objResponse)
                    } else {
                        completionHandler(false,objResponse)
                    }
                } else {
                    completionHandler(false,[:])
                }
            } else {
                completionHandler(false,[:])
            }
        }
    }
    
    func postLike(params:[String:String],completionHandler: @escaping (_ response: Bool,_ object:[String:AnyObject]) -> Void) {
        UserAPIManager.postLike(params) { success, object in
            if success == true {
                if let objResponse = object as? [String:AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    if(status == 200) {
                        completionHandler(true,objResponse)
                    } else {
                        completionHandler(false,objResponse)
                    }
                } else {
                    completionHandler(false,[:])
                }
            } else {
                completionHandler(false,[:])
            }
        }
    }
    
    func getOtherUserProfile(params:[String:Any],completionHandler: @escaping (_ response: Bool,_ object:[String:AnyObject]) -> Void) {
        UserAPIManager.getOtherUserData(params) { success, object in
            if success == true {
                if let objResponse = object as? [String:AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    if(status == 200) {
                        completionHandler(true,objResponse)
                    } else {
                        completionHandler(false,objResponse)
                    }
                } else {
                    completionHandler(false,[:])
                }
            } else {
                completionHandler(false,[:])
            }
        }
    }
    
    func followUnfollow(params:[String:Any],completionHandler: @escaping (_ response: Bool,_ object:[String:AnyObject]) -> Void) {
        UserAPIManager.followUnfollowAPI(params) { success, object in
            if success == true {
                if let objResponse = object as? [String:AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    if(status == 200) {
                        completionHandler(true,objResponse)
                    } else {
                        completionHandler(false,objResponse)
                    }
                } else {
                    completionHandler(false,[:])
                }
            } else {
                completionHandler(false,[:])
            }
        }
    }
    
    func contactAPI(params:[String:Any],completionHandler: @escaping (_ response: Bool,_ object:[String:AnyObject]) -> Void) {
        UserAPIManager.contactAPI(params) { success, object in
            if success == true {
                if let objResponse = object as? [String:AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    if(status == 200) {
                        completionHandler(true,objResponse)
                    } else {
                        completionHandler(false,objResponse)
                    }
                } else {
                    completionHandler(false,[:])
                }
            } else {
                completionHandler(false,[:])
            }
        }
    }
    
    func reportAPI(params:[String:Any],completionHandler: @escaping (_ response: Bool,_ object:[String:AnyObject]) -> Void) {
        UserAPIManager.reportAPI(params) { success, object in
            if success == true {
                if let objResponse = object as? [String:AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    if(status == 200) {
                        completionHandler(true,objResponse)
                    } else {
                        completionHandler(false,objResponse)
                    }
                } else {
                    completionHandler(false,[:])
                }
            } else {
                completionHandler(false,[:])
            }
        }
    }
    
    func searchUserListAPI(params: [String: Any], isShowHud: Bool, completionHandler: @escaping (_ response: Bool,_ object:[String: AnyObject]) -> Void) {
        UserAPIManager.userList(params, isShowHud: isShowHud) { success, object in
            if success == true {
                if let objResponse = object as? [String: AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    if(status == 200) {
                        completionHandler(true,objResponse)
                    } else {
                        completionHandler(false,objResponse)
                    }
                } else {
                    completionHandler(false,[:])
                }
            } else {
                completionHandler(false,[:])
            }
        }
    }
    
    func searchAllUserListAPI(params: [String: Any], isShowHud: Bool, completionHandler: @escaping (_ response: Bool,_ object:[String: AnyObject]) -> Void) {
        UserAPIManager.allUserList(params, isShowHud: isShowHud) { success, object in
            if success == true {
                if let objResponse = object as? [String: AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    if(status == 200) {
                        completionHandler(true,objResponse)
                    } else {
                        completionHandler(false,objResponse)
                    }
                } else {
                    completionHandler(false,[:])
                }
            } else {
                completionHandler(false,[:])
            }
        }
    }
    
    func callLogoutAPI(completionHandler: @escaping (_ response: Bool,_ object:[String: AnyObject]) -> Void) {
        UserAPIManager.logoutAPI([:]) { success, object in
            if success == true {
                if let objResponse = object as? [String: AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    if(status == 200) {
                        completionHandler(true,objResponse)
                    } else {
                        completionHandler(false,objResponse)
                    }
                } else {
                    completionHandler(false,[:])
                }
            } else {
                completionHandler(false,[:])
            }
        }
    }
    
    func callBlockedUserListAPI(completionHandler: @escaping (_ response: Bool,_ object: [String:AnyObject]) -> Void) {
        UserAPIManager.blockedUserList([:], isShowHud: true) { success, object in
            if success == true {
                if let objResponse = object as? [String: AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    if(status == 200) {
                        completionHandler(true,objResponse)
                    } else {
                        completionHandler(false,objResponse)
                    }
                } else {
                    completionHandler(false,[:])
                }
            } else {
                completionHandler(false,[:])
            }
        }
    }
    
    func callBroadcastStreamingAPI(params: [String: String], isShowHud: Bool, completionHandler: @escaping (_ response: Bool,_ object: [String: AnyObject]) -> Void) {
        UserAPIManager.broadcastLiveStream(params, isShowHud: isShowHud) { success, object in
            if success == true {
                if let objResponse = object as? [String: AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    if(status == 200) {
                        completionHandler(true,objResponse)
                    } else {
                        completionHandler(false,objResponse)
                    }
                } else {
                    completionHandler(false,[:])
                }
            } else {
                completionHandler(false,[:])
            }
        }
    }
    
    func callBroadcastStreamingStopAPI(params: [String: String], isShowHud: Bool, completionHandler: @escaping (_ response: Bool,_ object: [String: AnyObject]) -> Void) {
        UserAPIManager.broadcastLiveStreamStop(params, isShowHud: isShowHud) { success, object in
            if success == true {
                if let objResponse = object as? [String: AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    if(status == 200) {
                        completionHandler(true,objResponse)
                    } else {
                        completionHandler(false,objResponse)
                    }
                } else {
                    completionHandler(false,[:])
                }
            } else {
                completionHandler(false,[:])
            }
        }
    }
    
    func callBroadcastStreamingListAPI(isShowHud: Bool, completionHandler: @escaping (_ response: Bool,_ object: [String: AnyObject]) -> Void) {
        UserAPIManager.broadcastLiveStreamList([:], isShowHud: isShowHud) { success, object in
            if success == true {
                if let objResponse = object as? [String: AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    if(status == 200) {
                        completionHandler(true,objResponse)
                    } else {
                        completionHandler(false,objResponse)
                    }
                } else {
                    completionHandler(false,[:])
                }
            } else {
                completionHandler(false,[:])
            }
        }
    }
    
    func callJoinStreamingAPI(params: [String: Any], isShowHud: Bool, completionHandler: @escaping (_ response: Bool,_ object: [String: AnyObject]) -> Void) {
        UserAPIManager.joinLiveStream(params, isShowHud: isShowHud) { success, object in
            if success == true {
                if let objResponse = object as? [String: AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    if(status == 200) {
                        completionHandler(true,objResponse)
                    } else {
                        completionHandler(false,objResponse)
                    }
                } else {
                    completionHandler(false,[:])
                }
            } else {
                completionHandler(false,[:])
            }
        }
    }
    
    func callJoinStreamingUserListAPI(params: [String: Any], isShowHud: Bool, completionHandler: @escaping (_ response: Bool,_ object: [String: AnyObject]) -> Void) {
        UserAPIManager.joinLiveUserListStream(params, isShowHud: isShowHud) { success, object in
            if success == true {
                if let objResponse = object as? [String: AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    if(status == 200) {
                        completionHandler(true,objResponse)
                    } else {
                        completionHandler(false,objResponse)
                    }
                } else {
                    completionHandler(false,[:])
                }
            } else {
                completionHandler(false,[:])
            }
        }
    }
    
    func callStreamIdAPI(params: [String: Any], isShowHud: Bool, completionHandler: @escaping (_ response: Bool,_ object: [String: AnyObject]) -> Void) {
        UserAPIManager.streamId(params, isShowHud: isShowHud) { success, object in
            if success == true {
                if let objResponse = object as? [String: AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    if(status == 200) {
                        completionHandler(true,objResponse)
                    } else {
                        completionHandler(false,objResponse)
                    }
                } else {
                    completionHandler(false,[:])
                }
            } else {
                completionHandler(false,[:])
            }
        }
    }
    
    func callLiveStreamCommentAPI(params: [String: Any], isShowHud: Bool, completionHandler: @escaping (_ response: Bool,_ object: [String: AnyObject]) -> Void) {
        UserAPIManager.liveStreamComment(params, isShowHud: isShowHud) { success, object in
            if success == true {
                if let objResponse = object as? [String: AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    if(status == 200) {
                        completionHandler(true,objResponse)
                    } else {
                        completionHandler(false,objResponse)
                    }
                } else {
                    completionHandler(false,[:])
                }
            } else {
                completionHandler(false,[:])
            }
        }
    }
    
    func callGetLiveStreamAllCommentAPI(params: [String: Any], isShowHud: Bool, completionHandler: @escaping (_ response: Bool,_ object: [String: AnyObject]) -> Void) {
        UserAPIManager.getLiveStreamAllComment(params, isShowHud: isShowHud) { success, object in
            if success == true {
                if let objResponse = object as? [String: AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    if(status == 200) {
                        completionHandler(true,objResponse)
                    } else {
                        completionHandler(false,objResponse)
                    }
                } else {
                    completionHandler(false,[:])
                }
            } else {
                completionHandler(false,[:])
            }
        }
    }
    
    func callGetLiveStreamStatusAPI(params: [String: Any], isShowHud: Bool, completionHandler: @escaping (_ response: Bool,_ object: [String: AnyObject]) -> Void) {
        UserAPIManager.getLiveStreamStatus(params, isShowHud: isShowHud) { success, object in
            if success == true {
                if let objResponse = object as? [String: AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    if(status == 200) {
                        completionHandler(true,objResponse)
                    } else {
                        completionHandler(false,objResponse)
                    }
                } else {
                    completionHandler(false,[:])
                }
            } else {
                completionHandler(false,[:])
            }
        }
    }
    
    func reelPostDetail(params: [String: String],completionHandler: @escaping (_ response: Bool,_ object: [String: AnyObject]) -> Void) {
        UserAPIManager.reelPostDetail(params) { success, object in
            if success == true {
                if let objResponse = object as? [String: AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    if(status == 200) {
                        completionHandler(true,objResponse)
                    } else {
                        completionHandler(false,objResponse)
                    }
                } else {
                    completionHandler(false,[:])
                }
            } else {
                completionHandler(false,[:])
            }
        }
    }
    
    func userLogoutApp(completionHandler: @escaping (_ response: Bool, _ message:String) -> Void) {
        /*
        let dictParams = [String:String]()
        let networkModel = NetworkModel(params: dictParams, url: API.userLogout, showHUD: true, loaderString: "", shouldPassHeader: true, method: HTTPMethod.GET, arrMedia: [])
        let user: CommonApiResponseModel? = nil
        APIManager.sharedInstance.serviceRequest(networkObj: networkModel, modelObj: user) { (userResponse) in
            if(userResponse != nil) {
                let userExternalObj = userResponse as! CommonApiResponseModel
                if(userExternalObj.status_code == 200) {
                    self.userLogout()
                } else {
                    completionHandler(false,userExternalObj.message!)
                }
            }
        }
        */
    }
    
    func radioSubscribe(params: [String: Any], completionHandler: @escaping (_ response: Bool,_ object: [String: AnyObject]) -> Void) {
        UserAPIManager.radioSubscribeAPI(params) { success, object in
            if success == true {
                if let objResponse = object as? [String: AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    if(status == 200) {
                        completionHandler(true,objResponse)
                    } else {
                        completionHandler(false,objResponse)
                    }
                } else {
                    completionHandler(false,[:])
                }
            } else {
                completionHandler(false,[:])
            }
        }
    }
    
    func radioListnerUserList(params: [String: Any], completionHandler: @escaping (_ response: Bool,_ object: [String: AnyObject]) -> Void) {
        UserAPIManager.radioListnerUserList(params) { success, object in
            if success == true {
                if let objResponse = object as? [String: AnyObject] {
                    let status = objResponse["code"] as? Int ?? 0
                    if(status == 200) {
                        completionHandler(true,objResponse)
                    } else {
                        completionHandler(false,objResponse)
                    }
                } else {
                    completionHandler(false,[:])
                }
            } else {
                completionHandler(false,[:])
            }
        }
    }
}
