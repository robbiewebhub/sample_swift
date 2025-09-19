//
//  PremiumCollectionViewCell.swift
//  RFP
//
//  Created by Apple on 17/07/2024.
//

import UIKit

class PremiumCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PremiumCollectionViewCell"
    
    @IBOutlet weak var initialView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var chatRoomView: UIView!
    @IBOutlet weak var scrambledMessageView: UIView!
    @IBOutlet weak var liveVideoStreamingView: UIView!
    @IBOutlet weak var encryptedMessageView: UIView!
    @IBOutlet weak var subscriptionButton: UIButton!
    @IBOutlet weak var audioReplyView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupFont()
        setupButton()
        setupUI()
    }
    
    func setupUI() {
        contentView.layer.cornerRadius = 20
    }
    
    func setupButton() {
        subscriptionButton.backgroundColor = UIColor(red: 0.75294117647058822, green: 0.69411764705882351, blue: 0.5607843137254902, alpha: 1)
        subscriptionButton.setTitleColor(.white, for: .normal)
        subscriptionButton.layer.cornerRadius = 20
        subscriptionButton.setTitle("Subscribe Now", for: .normal)
    }
    
    func setupFont() {
        titleLabel.font = UIFont.customFont(with: .plasma, weight: .bold_700, size: 20)
        priceLabel.font = UIFont.customFont(with: .roboto, weight: .medium_500, size: 40)
        
    }
}
