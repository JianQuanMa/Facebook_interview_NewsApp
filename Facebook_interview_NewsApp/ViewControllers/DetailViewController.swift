//
//  DetailViewController.swift
//  Facebook_interview_NewsApp
//
//  Created by Jian Ma on 1/9/21.
//

import UIKit

class DetailViewController: UIViewController{
    @IBOutlet weak var stackview: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var despTextView: UITextView!
    var article: Article?
    override func viewDidLoad() {
        guard let article = article else{return}
        updateUI()
    }
    
    func updateUI(){
        self.titleLabel.text = self.article?.title
        if let imageURLString: String = self.article?.urlToImage{
            let imageURl = URL(string: imageURLString)
     //       let imageData = UIImage(data: imageURl)
        }
    }
    
}

extension UIImageView{
    func download(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit){
        contentMode = mode
        URLSession.shared.dataTask(with: url){ data , response , _ in
            guard
                            let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                            let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                            let data = data,
                            let image = UIImage(data: data)
                            else { return }
                        DispatchQueue.main.async() { [weak self] in
                            self?.image = image
                        }
                    }.resume()
        }
//    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
//            guard let url = URL(string: link) else { return }
//            downloaded(from: url, contentMode: mode)
//        }
    }
