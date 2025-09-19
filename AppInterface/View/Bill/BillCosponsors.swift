//
//  BillCosponsors.swift
//  RFP
//
//  Created by Apple on 22/05/2024.
//

import UIKit

class BillCosponsors: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var party: UILabel!
    @IBOutlet weak var district: UILabel!
    @IBOutlet weak var bioguideId: UILabel!
    @IBOutlet weak var sponsorshipDate: UILabel!
    @IBOutlet weak var sponsoredLegislationBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
