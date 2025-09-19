//
//  BillAction.swift
//  RFP
//
//  Created by Apple on 22/05/2024.
//

import UIKit

class BillAction: UITableViewCell {
    
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var actionCode: UILabel!
    @IBOutlet weak var actionDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
