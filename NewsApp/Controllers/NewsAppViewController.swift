//
//  NewsAppViewController.swift
//  NewsApp
//
//  Created by admios on 8/20/20.
//  Copyright © 2020 rene. All rights reserved.
//

import UIKit
import UIKit
import RxSwift

class NewsAppViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let newsTableView = UITableView()
    
    let disposeBag = DisposeBag()
    private var articleListVM: ArticleListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(newsTableView)
        newsTableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: "ArticleTableViewCell")
        newsTableView.dataSource = self
        newsTableView.delegate = self
        newsTableView.rowHeight = UITableView.automaticDimension
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white

        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        newsTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        newsTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        newsTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        newsTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true

        newsTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        newsTableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        newsTableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        newsTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        navigationItem.title = "News API"
        populateNews()
    }
    
    private func populateNews() {
        let resource = Resource<ArticleResponse>(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=88fa26b1cc254725ae27fa478bd842e9")!)
        URLRequest.load(resource: resource)
            .subscribe(onNext: { articleResponse in
                let articles = articleResponse.articles
                self.articleListVM = ArticleListViewModel(articles)
                DispatchQueue.main.async {
                    self.newsTableView.reloadData()
                }
            }).disposed(by: disposeBag)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM == nil ? 0: self.articleListVM.articlesVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("ArticleTableViewCell is not found")
        }
        
        let articleVM = self.articleListVM.articleAt(indexPath.row)
        
        articleVM.title.asDriver(onErrorJustReturn: "")
            .drive(cell.titleLabel.rx.text)
            .disposed(by: disposeBag)

        articleVM.description.asDriver(onErrorJustReturn: "")
            .drive(cell.descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        return cell
    }
}
