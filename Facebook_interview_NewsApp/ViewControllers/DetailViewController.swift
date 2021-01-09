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
    var article: Article? {
        didSet{
            print("set article")
            updateUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    //    self.view.backgroundColor = .red
   //     guard let article = article else{return}
        print("I did presnt the detailviewcontroller")
        updateUI()
    }
    
    private func updateUI(){
        print("updating uis")
  //      guard let article = article else{return}
        self.titleLabel?.text = self.article?.title
         if let imageURLString: String = self.article?.urlToImage{
            //if imageURL is not nil, try to download it
            if let imageURl = URL(string: imageURLString){
     //       let imageData = UIImage(data: imageURl)
                print("Thread: \(Thread.current) \(imageView)")
                self.imageView?.download(from: imageURl)
                
                
            }else
            // if the imageview url is nil, don't try to download the data and set the height constraint of the
            // the uiimageview to zero
            {
                
            }
            
        }

    }
    
}

extension UIImageView {
    func download(
        from url: URL,
        contentMode mode: UIView.ContentMode = .scaleAspectFit
    ) {
        contentMode = mode
        URLSession.shared.dataTask(with: url){ data , response , _ in
            guard (response as? HTTPURLResponse)?.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data,
                  let image = UIImage(data: data)
            else { return }
            
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}
