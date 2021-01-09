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
        
        NetworkService.shared.getEverything(with: .apple) { [weak self] result in
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
        let detailViewController = UIStoryboard(
            name: "Main",
            bundle: nil
        ).instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        detailViewController.article = articles[indexPath.row]
        present(detailViewController, animated: false)
    }
    
}
