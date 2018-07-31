//
//  File.swift
//  AssignmentSwift
//
//  Created by Vijay Chavre on 05/01/18.
//  Copyright © 2018 Vijay Chavre. All rights reserved.
//
import UIKit
class Book: NSObject {
    var autherName: String = ""
    var thumbnailUrl: String = ""
    var bookTitle: String = ""
    
    init(autherName: String, thumbnailUrl: String, bookTitle: String) {
        self.autherName = autherName
        self.thumbnailUrl = thumbnailUrl
        self.bookTitle = bookTitle
    }
}

