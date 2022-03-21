//
//  HomeTableViewCell.swift
//  NewsAppMVVM
//
//  Created by 神原良継 on 2022/03/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!

    func prepareUI() {
        titleLabel.numberOfLines = 0
        
    }
    
}
