//
//  CreateMenuPopupVC.swift
//  RFP
//
//  Created by LP on 24/03/22.
//

import UIKit

class CreateMenuPopupVC: UIViewController {
    
    var onSelect: ((_ index: Int)->Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnCloseClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnCreatePollClicked(_ sender: UIButton) {
        if let navigationController = self.navigationController {
            let vc = UIStoryboard.CreatePollVC()
            vc.hidesBottomBarWhenPushed = true
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: false)
        } else {
            print("Navigation controller is nil")
        }
    }
    
    @IBAction func btnCreateDebateClicked(_ sender: UIButton) {
        let vc = UIStoryboard.CreateDebateVC()
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnCreateDebate2Clicked(_ sender: UIButton) {
        let vc = UIStoryboard.AddVoteThemOutVC()
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnCreateEventClicked(_ sender: UIButton) {
        let vc = UIStoryboard.CreateEventNewVC()
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnCreateGroupClicked(_ sender: UIButton) {
        let vc = UIStoryboard.CreateForumVC()
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
