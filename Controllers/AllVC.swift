//
//  AllVC.swift
//  RFP
//
//  Created by LP on 01/02/22.
//

import UIKit

class AllVC: UIViewController {

    var screens: [String] = [
        "Create Room",
        "Onboarding Tutorial",
        "Edit Profile",
        "Room Details",
        "Forums Details LIst",
        "Vote Them Out",
        "Invite Participants",
        "Event Details",
        "My Events",
        "Vote Them Out Details",
        "People Attending",
        "Poll Details",
        "My Debates",
        "Chat Details",
        "Create Event",
        "Create Vote Them Out",
        "Create Debate",
        "Create Poll",
        "Live Debate",
        "Debate Details",
        "Media"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}


extension AllVC: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return screens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text =  "\(indexPath.row+1). " + screens[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            let vc = UIStoryboard.CreateForumVC()
//            let vc = UIStoryboard.ReportVC()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 1 {
            let vc = UIStoryboard.WelcomeVC()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 2 {
            let vc = UIStoryboard.EditProfileVC()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 3 {
            let vc = UIStoryboard.RoomDetailsVC()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 4 {
            let vc = UIStoryboard.ForumsDetailsLIstVC()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 5 {
            let vc = UIStoryboard.VoteThemOutVC()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 6 {
            let vc = UIStoryboard.InviteParticipantsVC()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 7 {
            let vc = UIStoryboard.EventDetailsVC()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 8 {
            let vc = UIStoryboard.MyEventsVC()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 9 {
            let vc = UIStoryboard.VoteThemOutDetailsVC()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 10 {
            let vc = UIStoryboard.PeopleAttendingVC()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 11 {
            let vc = UIStoryboard.PollDetailsVC()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 12 {
            let vc = UIStoryboard.MyDebatesVC()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 13 {
            let vc = UIStoryboard.ChatDetailsVC()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 14 {
            let vc = UIStoryboard.CreateEventVC()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 15 {
            let vc = UIStoryboard.CreateVoteThemOutVC()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 16 {
            let vc = UIStoryboard.CreateDebateVC()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 17 {
            let vc = UIStoryboard.CreatePollVC()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 18 {
            let vc = UIStoryboard.LiveDebateVC()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 19 {
            let vc = UIStoryboard.DebateDetailsVC()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 20 {
            let vc = UIStoryboard.MediaVC()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
