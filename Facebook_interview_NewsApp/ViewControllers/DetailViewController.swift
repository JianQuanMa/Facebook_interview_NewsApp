//
//  DetailViewController.swift
//  Facebook_interview_NewsApp
//
//  Created by Jian Ma on 1/9/21.
//

import UIKit
import WebKit

class DetailViewController: UIViewController{
    @IBOutlet weak var stackview: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var despTextView: UITextView!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    var article: Article? {
        didSet{
            print("set article")
            updateUI()
        }
    }
    
    lazy var webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
    //    self.view.backgroundColor = .red
   //     guard let article = article else{return}
        print("I did presnt the detailviewcontroller")
        updateUI()
    }
    
    private func updateUI(){
        let backButton = UIBarButtonItem(title: "back", style: .done, target: self.webView, action: #selector(back))
        self.navigationItem.leftBarButtonItem = backButton
        print("updating uis")
  //      guard let article = article else{return}
        self.titleLabel?.text = self.article?.title
         if let imageURLString: String = self.article?.urlToImage{
            //if imageURL is not nil, try to download it
            if let imageURl = URL(string: imageURLString){
     //       let imageData = UIImage(data: imageURl)
                self.imageView?.download(from: imageURl)
            }else{
                self.imageViewHeightConstraint.constant = 0
            }
            
        }

    }
    @IBAction func linkToSourceButtonTapped(_ sender: UIButton) {
        
         webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.view.addSubview(webView)
   //     guard let article = article else {return}
   //     let backButton = UIBarButtonItem(title: "back", style: .done, target: self, action: #selector(self.webView.goBack))
        
        self.webView.gestureRecognizers?.append(UIGestureRecognizer(target: self.webView, action: #selector (self.back)))
        self.webView.allowsBackForwardNavigationGestures = true
        guard let article = article, let url = URL(string: article.url) else {return}
        DispatchQueue.main.async{ [weak self] in
            self!.webView.load(URLRequest(url: url))}
    }
    @objc func back(){
        dismiss(animated: true)
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
