//
//  FBMediaInternalModel.swift
//  FamilyBook
//
//  Created by Ravi Mehta on 27/11/17.
//  Copyright © 2017 Ravi Mehta. All rights reserved.
//
import UIKit

struct MediaInternalModel {
    let key: String
    let fileName: String
    let data: Data
    let mimeType: String
    var url: String?
    
    var isLocal = true
    var photoId: String? = nil

    var width: Double?
    var height: Double?
    
    init?(withImage image: UIImage, forKey key: String, withFileName filename: String, url: String? = nil, width: Double?, height: Double?, isLocal: Bool = true, photoId: String? = nil) {
        self.key = key
        self.mimeType = "image/jpg"
        self.fileName = "\(filename).jpg"
        guard let data = image.jpegData(compressionQuality: 0.9) else { return nil }
        self.data = data
        self.url = url
        self.width = width
        self.height = height
        self.isLocal = isLocal
        self.photoId = photoId
    }
    
    init?(forKey key: String, withFileName filename: String) {
        self.key = key
        self.mimeType = "jpg"
        self.fileName = "\(filename).jpg"
        self.data = Data()
    }
    
    init?(withVideoData data: Data, forKey key: String, withFileName filename: String, url: String? = nil, width: Double?, height: Double?, isLocal: Bool = true, photoId: String? = nil) {
        self.key = key
        self.mimeType = "Video/mov"
        self.fileName = filename//"video.mov"
        self.data = data
        self.url = url
        self.width = width
        self.height = height
        self.isLocal = isLocal
        self.photoId = photoId
    }
    
    init(withImageData data: Data, forKey key: String, withFileName filename: String, url: String? = nil, width: Double?, height: Double?, isLocal: Bool = true, photoId: String? = nil) {
        self.key = key
        self.mimeType = "image/jpg"
        let ext = url?.toURL?.pathExtension ?? "jpg"
        self.fileName = "\(filename).\(ext)"
        self.data = data
        self.url = url
        self.width = width
        self.height = height
        self.isLocal = isLocal
        self.photoId = photoId
    }
}

