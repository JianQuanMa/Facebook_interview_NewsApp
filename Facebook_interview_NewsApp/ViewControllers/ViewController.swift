//
//  ViewController.swift
//  Facebook_interview_NewsApp
//
//  Created by Jian Ma on 1/7/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var keywordTextView: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var totalResults: UILabel!
    
    @IBOutlet weak var mainTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let appleKeyword = SearchKeyword(keyword: "apple")
        
        NetworkService.shared.getEverything(with: appleKeyword) { [weak self] result in
            guard let self = self else { return }
            print("-=- isMainThread111 \(Thread.isMainThread)")
            switch result {
            case .failure(let error):
                print("-=- hand the error however you want")
            case .success(let result):
                print("-=- handle the success")
                
                self.statusLabel.text = result.status
                self.totalResults.text = "total results: \(result.totalResults)"
                self.articles = result.articles
            }
        }
        
        mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: "something")
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "viewControllerToDetailViewControllerSegue"{
    //            let detailViewController = segue.destination as? DetailViewController
    //          //  detailViewController?.article = self.articles[]
    //        }
    //    }
    
    var articles: [Article] = [] {
        didSet {
            mainTableView.reloadData()
        }
    }
    @IBAction func submitButtonTapped(_ sender: UIButton) {
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "something") else {
            print("-=- not able to dequeu")
            return UITableViewCell()
        }
        
        cell.textLabel?.text  = articles[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   //     let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let detailViewController = storyboard.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        let detailViewController = DetailViewController(article: articles[indexPath.row])
     //   let myViewcontroller = MyController(article: self.articles[indexPath.row])
  //      present(myViewcontroller, animated: false)
        present(detailViewController, animated: false)
        //   prepare(for: UIStoryboardSegue(identifier: "viewControllerToDetailViewControllerSegue", source: self, destination: detailViewController), sender: nil)
        //    detailViewController.article = articles[indexPath.row]
      //  self.navigationController?.pushViewController(detailViewController, animated: false)
    //    performSegue(withIdentifier: "viewControllerToDetailViewControllerSegue", sender: nil)
        //    detailViewController.article = articles[indexPath.row]
        //    present(detailViewController, animated: true)
    }
    
}

class MyController: UIViewController {

    let article: Article?

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }
}
