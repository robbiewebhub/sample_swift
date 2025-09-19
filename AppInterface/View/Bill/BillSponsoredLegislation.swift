//
//  BillSponsoredLegislation.swift
//  RFP
//
//  Created by Apple on 22/05/2024.
//

import UIKit

class BillSponsoredLegislation: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var congress: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var introducedDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
