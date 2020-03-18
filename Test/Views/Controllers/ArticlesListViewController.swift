//
//  ArticlesListViewController.swift
//  Test
//
//  Created by Evan Su on 18/3/20.
//  Copyright © 2020 techtask. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ArticlesListViewController: ViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    let viewModel: ArticlesListViewModelType = ArticlesListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.startAnimating()
        self.viewModel.inputs.getArticlesContent()
    }
    
    override func configureUI() {
        self.title = "Articles"
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: ArticleListCell.defaultReusableId, bundle: nil),
                           forCellReuseIdentifier: ArticleListCell.defaultReusableId)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func bindViewModel() {
        // Use share operator to define streams that share resources among their subscribers.
        let articles = self.viewModel.outputs.articles.share()
        
        articles.elements()
            .observerForUI()
            .bind(to: tableView.rx.items(cellIdentifier: ArticleListCell.defaultReusableId, cellType: ArticleListCell.self)) { (_, article, cell) in
                cell.configureCell(article)
        }
        .disposed(by: disposeBag)
        
        articles.elements()
            .observerForUI()
            .subscribe(onNext: { [weak self] error in
                self?.indicator.stopAnimating()
            })
            .disposed(by: disposeBag)
        
        articles.errors()
            .observerForUI()
            .subscribe(onNext: { [weak self] error in
                // handle error message
                if let errorMessage = (error as NSError).userInfo["message"] as? String{
                    self?.showErrorAlert(message: errorMessage)
                }
                self?.indicator.stopAnimating()
            })
            .disposed(by: disposeBag)
        
        tableView.rx
        .modelSelected(Article.self)
        .subscribe(onNext:  { [weak self] article in
            let vc = Storyboard.main.instantiate(ArticleDetailsViewController.self)
            vc.url = article.url
            vc.headline = article.title
            self?.navigationController?.pushViewController(vc, animated: true)
        })
        .disposed(by: disposeBag)
    }
}
