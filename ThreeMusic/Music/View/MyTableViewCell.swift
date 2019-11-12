//
//  MyTableViewCell.swift
//  Music
//
//  Created by Chen Wei Wen on 4/11/2019.
//  Copyright © 2019 Musicplayer. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    static let identifier: String = "mycell"
    static let height: CGFloat = 60
  
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        
    }
    
}
extension MyTableViewCell {
    func setup(titleName: String, subtitleName: String) {
        titleLabel.text = titleName
        subtitleLabel.text = subtitleName
    }
}
