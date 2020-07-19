//
//  NearByCell.swift
//  test
//
//  Created by Sandro Beruashvili on 7/8/20.
//  Copyright © 2020 Sandro Beruashvili. All rights reserved.
//

import UIKit

class NearByCell: UITableViewCell {
    @IBOutlet weak var restThumb: UIImageView!
    @IBOutlet weak var restCuisine: UILabel!
    @IBOutlet weak var restRating: UILabel!
    @IBOutlet weak var restLocation: UILabel!
    @IBOutlet weak var restPrice: UILabel!
    @IBOutlet weak var openNow: UILabel!
    @IBOutlet weak var restName: UILabel!
    @IBOutlet weak var view1: UIView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
