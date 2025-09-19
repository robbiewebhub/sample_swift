//
//  NetworkManager.swift
//  Studi
//
//  Created by Abhinav Saxena on 12/28/17.
//  Copyright © 2017 All rights reserved.
//

import Foundation
import Alamofire

public enum HTTPMethod : String {
    case GET
    case POST
    case PUT
    case DELETE
}

class NetworkManager: NSObject {
    
    typealias CompletionHandler = (_ response: DataResponse<Any, AFError>) -> Void
    
    static let sharedInstance = NetworkManager()
    
    /*
    private let AF: Session = {
        let manager = ServerTrustManager(evaluators: ["18.191.53.23": DisabledTrustEvaluator()])
        let configuration = URLSessionConfiguration.af.default
        return Session(configuration: configuration, serverTrustManager: manager)
    }()*/
    
    fileprivate override init() {} //This prevents others from using the default '()' initializer for this class.
    
    func cancelRequest(){
        
        print("Cancel All Request cancelRequest")
        AF.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach { $0.cancel() }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
        }
        
        
    }
    
    // Header
    func performRequestWithURL(_ URLString: URLConvertible, method: HTTPMethod, headers: HTTPHeaders?, parameters: [String: Any]?, encoding: ParameterEncoding = URLEncoding.default, completionHandler: @escaping CompletionHandler) {
        
        debugPrint("URL: \(URLString)")
        debugPrint("Parameters:", parameters?.toJSON() as AnyObject)
        debugPrint("Headers:", headers?.dictionary.toJSON() as AnyObject)
        //let configuration = URLSessionConfiguration.default
        //configuration.urlCache = nil
        let HTTPHeaders = headers // HTTPHeaders(headers ?? [:])
        if method == .POST
        {
          /* Alamofire.request(URLString, method: .post, parameters: parameters, headers: headers).responseString
                { response in
                print(response.result.value)
                    //completionHandler(response)
            }*/
            //encoding: JSONEncoding.default
            AF.request(URLString, method: .post, parameters: parameters,encoding: encoding, headers: HTTPHeaders).responseJSON
                { response in
                //print(response.result.value)
                    completionHandler(response)
            }
            
            
        }
        else if method == .GET
        {
            /*Alamofire.request(URLString, method: .get, parameters: parameters, headers: headers).responseString
                { response in
                print(response.result.value)
                    //completionHandler(response)
            }*/
            AF.request(URLString, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: HTTPHeaders).responseJSON
                { response in
                
                    completionHandler(response)
            }
        }
        else if method == .PUT
        {
            AF.request(URLString, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: HTTPHeaders).responseJSON
                { response in
                    completionHandler(response)
            }
        }
        else if method == .DELETE
        {
            
            AF.request(URLString, method: .delete, parameters: parameters, encoding: URLEncoding.default, headers: HTTPHeaders).responseJSON
                { response in
                    completionHandler(response)
            }
        }
    }
    
    
    //    func performRequestWithImageWithData(_ URLString: URL, fileType:String, method: HTTPMethod, headers: [String : String]?, parameters: [String: String]?,imageData: Data, imageTagName: String, completionHandler: @escaping CompletionHandler) {
    //
    //        debugPrint("URL: \(URLString)")
    //        print("Parameters: \(parameters!)")
    //
    //        debugPrint("Headers: \(headers!)")
    //
    //        let url = try! URLRequest(url: URLString, method: .post, headers: headers)
    //
    //        Alamofire.upload(
    //            multipartFormData: { multipartFormData in
    //
    //                multipartFormData.append(imageData, withName: imageTagName, fileName: "file.png", mimeType: "image/png")
    //
    //
    ////        Alamofire.upload(
    ////            multipartFormData: { multipartFormData in
    ////            multipartFormData.append(imageData, withName: imageTagName, fileName: "png", mimeType: "image/png")
    //
    //
    ////                for (key, value) in parameters!
    ////                {
    ////                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
    ////                }
    //
    //                //fileType 1 = video, 2 = image, 3 = pdf
    ////                multipartFormData.append(imageData, withName: imageTagName, fileName: "file.png", mimeType: "image/png")
    //
    ////                if(fileType == "V"){
    ////                    multipartFormData.append(imageData, withName: imageTagName, fileName: "Video.mp4", mimeType: "video/mp4")
    ////
    ////                }
    ////                else if(fileType == "I"){
    ////                }
    ////                else if(fileType == "F"){
    ////                    multipartFormData.append(imageData, withName: imageTagName, fileName: "file.pdf", mimeType: "application/pdf")
    ////                }
    ////                else if(fileType == "QRCode"){
    ////                    print(imageData)
    ////                    multipartFormData.append(imageData, withName: imageTagName, fileName: "file.jpg", mimeType: "image/jpg")
    ////                }
    ////                else{
    ////                  multipartFormData.append(imageData, withName: imageTagName, fileName: "file.mp3", mimeType: "audio/mpeg")
    ////                }
    //
    //        },
    //            with: url,
    //            encodingCompletion: { encodingResult in
    //                switch encodingResult {
    //                case .success(let upload, _, _):
    //                    upload.responseJSON { response in
    //                        completionHandler(response)
    //                    }
    //                case .failure( _):
    //                    break
    //                }
    //        }
    //        )
    //    }
    ////
    func performRequestWithImage(_ URLString: URL, method: HTTPMethod, headers: [String : String]?,imageData: Data, imageName: String, completionHandler: @escaping CompletionHandler) {
        
        debugPrint("URL: \(URLString)")
        debugPrint("Headers: \(headers)")
        let HTTPHeaders = HTTPHeaders(headers ?? [:])
        let url = try! URLRequest(url: URLString, method: .post, headers: HTTPHeaders)
     
        let request = AF.upload(
            multipartFormData: { multipartFormData in
                
                multipartFormData.append(imageData, withName: imageName, fileName: "file.png", mimeType: "image/png")
            },
            with: url)
        
        request.uploadProgress { (progress) in
            print("IMAGE UPLOADING: ", progress.fractionCompleted)
        }
        
        //Response
        request.responseJSON { (dataResponse) in
            completionHandler(dataResponse)
        }
    }
    //
    func performRequestWithImageWithData(_ URLString: URL, method: HTTPMethod, headers: HTTPHeaders?, parameters: [String: String]?,imageData: Data, imageTagName: String!, completionHandler: @escaping CompletionHandler) {
        
        debugPrint("URL: \(URLString)")
        debugPrint("Parameters:", parameters?.toJSON() as AnyObject)
        debugPrint("Headers:", headers?.dictionary.toJSON() as AnyObject)
        let HTTPHeaders = headers //HTTPHeaders(headers ?? [:])
        let url = try! URLRequest(url: URLString, method: .post, headers: HTTPHeaders)
        
        let request = AF.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in parameters!
                {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
                multipartFormData.append(imageData, withName: imageTagName, fileName: "file.jpg", mimeType: "image/jpg")
                
        },with: url)
        
        request.uploadProgress { (progress) in
            print("IMAGE UPLOADING: ", progress.fractionCompleted)
        }
        
        //Response
        request.responseJSON { (dataResponse) in
            completionHandler(dataResponse)
        }
    }
    func performRequestWithMultiImageWithData(_ URLString: URL, method: HTTPMethod, headers: HTTPHeaders?, parameters: [String: String]?,arrMedia:[MediaInternalModel], completionHandler: @escaping CompletionHandler) {
        
        debugPrint("URL: \(URLString)")
        debugPrint("Parameters:", parameters?.toJSON() as AnyObject)
        debugPrint("Headers:", headers?.dictionary.toJSON() as AnyObject)
        let HTTPHeaders = headers // HTTPHeaders(headers ?? [:])
        let url = try! URLRequest(url: URLString, method: .post, headers: HTTPHeaders)
        
        let request = AF.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in parameters!
                {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
                for obj in arrMedia
                {
                    multipartFormData.append(obj.data, withName:obj.key, fileName:obj.fileName, mimeType: "image/jpg")
                }
            }, with: url)
        
        request.uploadProgress { (progress) in
            print("IMAGE UPLOADING: ", progress.fractionCompleted)
        }
        
        //Response
        request.responseJSON { (dataResponse) in
            completionHandler(dataResponse)
        }
    }
    
}
