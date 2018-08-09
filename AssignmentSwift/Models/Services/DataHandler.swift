//
//  File.swift
//  AssignmentSwift
//
//  Created by vijay on 8/2/18.
//  Copyright © 2018 Vijay Chavre. All rights reserved.
//

import Foundation
import UIKit
//import Alamofire
import SSZipArchive

class DataHandler {
    class func directoryPath() -> String {
        let zip = "zip"
        let newDir: String = getDocumentDirectoryPath().appendingPathComponent("\(zip)").path
        return newDir
    }
    
    class func getDocumentDirectoryPath() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    class func startDownload(urlString:String) -> Void {
        
        let url = URL(string: urlString)
        let request = URLRequest(url: url! as URL)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else { return }
            do {
                try FileManager.default.createDirectory(atPath: directoryPath(),
                                            withIntermediateDirectories: true, attributes: nil)
            } catch let error as NSError {
                print("Error: \(error.localizedDescription)")
            }
            let path = directoryPath() + "/data.epub"
            do {
                try data.write(to: URL(fileURLWithPath: path))
            } catch let error as NSError {
                print("Error: \(error.localizedDescription)")
            }
            }.resume()
        
    }
}
