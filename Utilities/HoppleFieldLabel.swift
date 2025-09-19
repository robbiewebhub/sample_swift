//
//  HoppleFieldLabel.swift
//  Firgun
//
//  Created by LP on 20/10/21.
//

import Foundation
import UIKit
class HoppleFieldLabel: UILabel {
    
    // Method used for set custom label font according to the screen size
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if(self.text != nil)
        {
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 7
            let strText = self.text
            let underlineAttriStringTerms = NSMutableAttributedString(string:self.text!)
            if self.text!.suffix(1) == "*"
            {
                let rangeTerms1 = (self.text! as NSString).range(of: "*")
                underlineAttriStringTerms.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor(named: CUSTOM_COLORS.StarRedColor)!, range: rangeTerms1)
                self.attributedText = underlineAttriStringTerms
            }
            underlineAttriStringTerms.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0,(self.text!.count)))
            self.attributedText = underlineAttriStringTerms
        }
    }
    
    func labelFontNameSizeAccordingToScreenSize(labelFontSize: CGFloat ,labelFontName:String = ""){
        let fontSize = labelFontSize * KAppConstant.kScreenSizeWidthRatio
        if(labelFontName == ""){
            self.font =  UIFont.systemFont(ofSize: labelFontSize)
        }
        else{
            let titleFont : UIFont = UIFont(name: labelFontName, size: fontSize)!
            self.font =  titleFont
        }
    }
    
    
    
}
