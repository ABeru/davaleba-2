//
//  FavCell.swift
//  test
//
//  Created by Sandro Beruashvili on 7/10/20.
//  Copyright © 2020 Sandro Beruashvili. All rights reserved.
//

import UIKit

class FavCell: UITableViewCell {
    @IBOutlet weak var openNow: UILabel!
    @IBOutlet weak var heart: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var restName: UILabel!
    @IBOutlet weak var restCuisine: UILabel!
    @IBOutlet weak var restRate: UILabel!
    @IBOutlet weak var restLoc: UILabel!
    @IBOutlet weak var restPrice: UILabel!
    @IBOutlet weak var restImage: UIImageView!
    @IBOutlet weak var view1: UIView!
   
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
  
    var didTapMoreInfo: (() -> Void)?
    var didTapMoreInfo1: (() -> Void)?
    @IBAction func detailOn(_ sender: UIButton) {
        didTapMoreInfo?()
        
    }
    @IBAction func removeOn(_ sender: UIButton) {
        didTapMoreInfo1?()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
