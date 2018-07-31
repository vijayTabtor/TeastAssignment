//
//  ViewController.swift
//  AssignmentSwift
//
//  Created by Vijay Chavre on 04/01/18.
//  Copyright © 2018 Vijay Chavre. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    let cellID = "cellIdentifire"
    @IBOutlet weak var userCollectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var backLabel: UILabel!
    var searchActive : Bool = false
    var columnCount: CGFloat = 3
    
    var backButtonText: String!
    var usersArray = [Book]()
    var filtered:[Book] = []
    
    init() {
        super.init(nibName: "PersonView", bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        self.userCollectionView.register(UINib(nibName: "UserCellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        DispatchQueue.global(qos: .default).async {
            self.getJsonFromUrl()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.backLabel.text = backButtonText
    }
    
    
    @IBAction func backButton(_ sender: Any) {
       self.navigationController?.popViewController(animated:true)
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = CGFloat(20 * (columnCount + 1))
        let availabelWidth = self.view.frame.width - paddingSpace
        return CGSize(width:(availabelWidth)/columnCount, height: 427)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 20, 0, 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
   
}

//MARK: - SearchBar delegate
extension ViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = usersArray.filter({ (book) -> Bool in
            let tmp = book.autherName as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.userCollectionView.reloadData()
    }
}
//MARK: - Method To get data from remote server
extension ViewController {
    func getJsonFromUrl(){
        var topic = "Fiction"
        if let slectedTopic = backButtonText {
            topic = slectedTopic
        }
        let url = NSURL(string: "https://www.googleapis.com/books/v1/volumes?filter=paid-ebooks&q=\(topic)&orderBy=relevance&startIndex=0&maxResults=40")
        let request = URLRequest(url: url! as URL)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else { return }
            if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                if let books = jsonObj!.value(forKey: "items") as? NSArray {
                    for book in books {
                        if let bookDictionary = book as? NSDictionary {
                            let volumInfo = bookDictionary.value(forKey: "volumeInfo") as? NSDictionary
                            let title = volumInfo?.value(forKey: "title")
                            let authers = volumInfo?.value(forKey: "authors") as? NSArray
                            var author = authers?.object(at: 0)
                            // if auther is not availabel use publisher in place
                            if author == nil {
                                author = volumInfo?.value(forKey: "publisher")
                            }
                            let thumbnailLinks = volumInfo?.value(forKey: "imageLinks") as? NSDictionary
                            let thumbanilUrl = thumbnailLinks?.value(forKey: "thumbnail")
                            let book = Book(autherName: author as! String, thumbnailUrl: thumbanilUrl as! String, bookTitle: title as! String)
                            self.usersArray.append(book)
                            
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.userCollectionView.reloadData()
                }
            }
            
            }.resume()
    }
}

 //MARK: - CollectionView datasource and delegate methods
extension ViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        if (self.usersArray.count > 0) {
            return self.usersArray.count;
        }
        return 0;
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! UserCellCollectionViewCell
        if(searchActive){
            if (self.filtered.count > 0) {
                cell.setupView(book: self.filtered[indexPath.row])
            }
        } else {
            if (self.usersArray.count > 0) {
                cell.setupView(book: self.usersArray[indexPath.row])
            }
        }

        return cell

    }
}

