//
//  SearchCell.swift
//  test
//
//  Created by Sandro Beruashvili on 7/12/20.
//  Copyright © 2020 Sandro Beruashvili. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    @IBOutlet weak var restName: UILabel!
    @IBOutlet weak var restCuisine: UILabel!
    @IBOutlet weak var restRate: UILabel!
    @IBOutlet weak var restLoc: UILabel!
    @IBOutlet weak var restPrice: UILabel!
    @IBOutlet weak var restImg: UIImageView!
    @IBOutlet weak var restView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
