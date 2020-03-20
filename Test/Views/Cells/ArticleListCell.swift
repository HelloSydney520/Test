//
//  ArticleListCell.swift
//  Test
//
//  Created by Evan Su on 18/3/20.
//  Copyright © 2020 techtask. All rights reserved.
//

import UIKit
import SDWebImage

class ArticleListCell: UITableViewCell {
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(_ article: Article, tableView: UITableView?, indexPath: IndexPath?) {
        headlineLabel.text = article.title
        abstractLabel.text = article.abstract
        writerLabel.text = "By \(article.writer)\n\(article.displayDateTime)"
        if let thumbnail = article.thumbnail {
            thumbnailImageView.sd_setImage(with: URL(string: thumbnail.url),
                                           placeholderImage: UIImage(named: "placeholder"))
        } else {
            thumbnailImageView.image = UIImage(named: "placeholder")
        }
    }
    
}
