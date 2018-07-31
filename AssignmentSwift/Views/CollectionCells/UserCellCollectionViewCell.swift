//
//  UserCellCollectionViewCell.swift
//  AssignmentSwift
//
//  Created by Vijay Chavre on 05/01/18.
//  Copyright © 2018 Vijay Chavre. All rights reserved.
//

import UIKit

class UserCellCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var tagLineLabel: UILabel!
    let imageCache = NSCache<AnyObject, AnyObject>()
    var imageUrlString: String?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.profileImageView.layer.cornerRadius = 5
        self.profileImageView.layer.borderWidth = 1
    }

    func setupView(book: Book) {
        self.userNameLabel.text = book.bookTitle
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async {
            self.getImageFromUrl(urlString: book.thumbnailUrl)
        }
        self.tagLineLabel.text = book.autherName
    }
    
    func getImageFromUrl(urlString: String){
        self.imageUrlString = urlString
        let url = NSURL(string: urlString)
        let request = URLRequest(url: url! as URL)
        DispatchQueue.main.async {
            self.profileImageView.image = nil
            if let imageFromCache = self.imageCache.object(forKey: urlString as AnyObject) as? UIImage {
                self.profileImageView.image = imageFromCache
                return
            }
        }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else { return }
            
            OperationQueue.main.addOperation({
                if let imageToCach = UIImage(data: data) {
                    if self.imageUrlString == urlString {
                        self.profileImageView.image = imageToCach
                    }
                    self.imageCache.setObject(imageToCach, forKey: urlString as AnyObject)
                }
            })
            
            }.resume()
    }
    
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}


