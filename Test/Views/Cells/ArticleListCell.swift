//
//  ArticleListCell.swift
//  Test
//
//  Created by Evan Su on 18/3/20.
//  Copyright © 2020 techtask. All rights reserved.
//

import UIKit

class ArticleListCell: UITableViewCell {
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(_ article: Article) {
        headlineLabel.text = article.title
        abstractLabel.text = article.abstract
        writerLabel.text = "By \(article.writer)\n\(article.displayDateTime)"
    }
    
}
