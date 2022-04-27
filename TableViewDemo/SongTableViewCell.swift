//
//  SongTableViewCell.swift
//  TableViewDemo
//
//  Created by Chu Go-Go on 2022/4/25.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var artiesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var trackLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
