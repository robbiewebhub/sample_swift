//
//  BillNo.swift
//  RFP
//
//  Created by Apple on 23/05/2024.
//

import UIKit

class BillNo: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var updatedDate: UILabel!
    @IBOutlet weak var introducedDate: UILabel!
    @IBOutlet weak var orifinChmber: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var updatedDateIncludingText: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var congress: UILabel!
    @IBOutlet weak var latestAction: UILabel!
    @IBOutlet weak var policyArea: UILabel!
    @IBOutlet weak var origionChsmberCode: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
