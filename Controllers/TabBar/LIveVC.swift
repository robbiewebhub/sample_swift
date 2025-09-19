//
//  LIveVC.swift
//  RFP
//
//  Created by LP on 10/01/22.
//

import UIKit
import ESPullToRefresh

class LIveVC: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var Livetable: UITableView!
    @IBOutlet weak var floatingButton: UIButton!
    
    let profilePic = UIImageView()
    var arrList: [DebateLiveUser] = []
    var paging: Paging? = nil
    var isApiCalling = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupVC()
        let footer = ESRefreshFooterAnimator()
        footer.noMoreDataDescription = ""
        self.Livetable.es.addInfiniteScrolling(animator: footer) { [unowned self] in
            self.callDebateListAPI(isShowHud: false)
        }
        self.Livetable.es.addPullToRefresh { [unowned self] in
            self.paging?.currentPage = nil
            self.Livetable.es.resetNoMoreData()
            self.callDebateListAPI(isShowHud: false)
        }
        self.callDebateListAPI(isShowHud: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setClerColorNavBar()
        let tabs = self.tabBarController as? TabBarVC
        tabs?.centerButton.isHidden = false
        if isApiCalling == false {
            self.paging?.currentPage = nil
            self.Livetable.es.resetNoMoreData()
            self.callDebateListAPI(isShowHud: false)
        }
        let picURL = UserManager.sharedManager().activeUser?.photo ?? ""
        let profileImage = URL(string: picURL)
        let placholder = UIImage(named: "icn_placeholder_user")
        profilePic.kf.setImage(with: profileImage, placeholder: placholder)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let tabs = self.tabBarController as? TabBarVC
        tabs?.centerButton.isHidden = true
    }
    
    func setupVC() {
        let ItemView = UIButton()
        ItemView.frame = CGRect(x: 0, y: 0, width: 38, height: 38)
        
        profilePic.frame = CGRect(x: 0, y: 0, width: 38, height: 38)
        profilePic.image = UIImage(named: "icn_dummy_profile")
        profilePic.contentMode = .scaleAspectFill
        let picURL = UserManager.sharedManager().activeUser?.photo ?? ""
        let profileImage = URL(string: picURL)
        let placholder = UIImage(named: "icn_placeholder_user")
        profilePic.kf.setImage(with: profileImage, placeholder: placholder)
        
        ItemView.addSubview(profilePic)
        profilePic.layer.cornerRadius = 10
        profilePic.clipsToBounds = true
        ItemView.addTarget(self, action: #selector(self.showMenu(_:)), for: .touchUpInside)
        
        let img1 = UIImageView()
        img1.frame = CGRect(x: -3, y: 23, width: 10, height: 10)
        img1.image = UIImage(named: "icn_profile_pic_icon")
        ItemView.addSubview(img1)
        
        let Menubaritem = UIBarButtonItem(customView:ItemView)//UIBarButtonItem(customView: ItemView)
        Menubaritem.target = self
        Menubaritem.action = #selector(self.showMenu(_:))
        self.navigationItem.rightBarButtonItems = [Menubaritem]
    }
    
    func setPlaceholder() {
        if self.arrList.count == 0 {
            Livetable.emptyMessage(message: "No Data Found")
        } else {
            Livetable.backgroundView = nil
        }
    }
    
    @IBAction func floatingButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.CreateMenuPopupVC()
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .overFullScreen
        self.present(navigationController, animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LiveTableCell", for: indexPath) as! LiveTableCell
        cell.viewAttending.isHidden = false
        cell.btnAttend.isHidden = false
        cell.btnAttendHeight.constant = 45
        
        let data = self.arrList[indexPath.row]
        cell.lblTopic.text = data.topic
        cell.lblUser1Name.text = "\(data.firstName ?? "") \(data.lastName ?? "")"
        cell.lblUser2Name.text = "\(data.opponantTwoFirstName ?? "") \(data.opponantTwoLastName ?? "")"
        let profileImage1 = URL(string: data.picURL?.percentEncoding() ?? "")
        let placholder = UIImage(named: "icn_placeholder_user")
        cell.picUser1.kf.setImage(with: profileImage1, placeholder: placholder)
        let profileImage2 = URL(string: data.opponantTwoPicURL?.percentEncoding() ?? "")
        cell.picUser2.kf.setImage(with: profileImage2, placeholder: placholder)

        let strDebateEndTime = "\(data.date ?? "") \(data.timeSlot ?? "")"
        let debateEndDateTmp = (strDebateEndTime.toDate("yyyy-MM-dd hh:mm a") ?? Date())
        let debateEndDate  = debateEndDateTmp.addingTimeInterval(30*60)
        
        let strDebateTime = "\(data.date ?? "") \(data.timeSlot ?? "")"
        let dateTime = getStringDate(with: strDebateTime, withOldFormat: "yyyy-MM-dd hh:mm a", withNewFormat: "MMM dd, yyyy hh:mm a")
        cell.lblDate.text = dateTime
        
        let myId = UserManager.sharedManager().activeUser.id
        if myId == data.userid || myId == data.opponantTwoUserid {
            cell.btnAttendHeight.constant = 45
            cell.btnAttend.isHidden = false
            cell.viewAttending.isHidden = true
            cell.btnAttend.layer.cornerRadius = 25
            let strDebateTime = "\(data.date ?? "") \(data.timeSlot ?? "")"
            let debateDate = strDebateTime.toDate("yyyy-MM-dd hh:mm a") ?? Date()
            if debateDate > Date() {
                cell.btnAttend.setTitle("Start on \(dateTime)", for: .normal)
            } else {
                cell.btnAttend.setTitle("Start", for: .normal)
            }
            
        } else {
            if data.debetIsAttent == true {
                if Date().timeIntervalSince1970 >= debateEndDateTmp.timeIntervalSince1970 && Date().timeIntervalSince1970 <= debateEndDate.timeIntervalSince1970 {
                    cell.btnAttendHeight.constant = 45
                    cell.btnAttend.isHidden = false
                    cell.viewAttending.isHidden = true
                    cell.btnAttend.setTitle("Join", for: .normal)
                    cell.btnAttend.layer.cornerRadius = 25
                } else {
                    cell.btnAttendHeight.constant = 45
                    cell.btnAttend.isHidden = true
                    cell.viewAttending.isHidden = false
                    cell.viewAttending.isHidden = true
                    cell.viewAttending.layer.cornerRadius = 25
                    
                }
            } else {
                cell.btnAttendHeight.constant = 45
                cell.btnAttend.setTitle("Attend", for: .normal)
                cell.btnAttend.isHidden = false
                cell.viewAttending.isHidden = true
                cell.btnAttend.layer.cornerRadius = 25
            }
        }
        
        if Date() > debateEndDate {
            cell.btnAttendHeight.constant = 0
            cell.viewAttending.isHidden = true
            cell.btnAttend.isHidden = true
        }
        
        cell.btnAttend.tag = indexPath.row
        cell.btnAttend.addTarget(self, action: #selector(btnAttendClicked(_:)), for: .touchUpInside)
        
        let flagObj1 = arrStates.first(where: { $0.id == data.stateId?.intValue })
        let flagObj2 = arrStates.first(where: { $0.id == data.opponantTwoStateId?.intValue })
        let flagImage1 = URL(string: flagObj1?.flag ?? "")
        let flagImage2 = URL(string: flagObj2?.flag ?? "")
        cell.flagIcon1.kf.setImage(with: flagImage1, placeholder: nil)
        cell.flagIcon2.kf.setImage(with: flagImage2, placeholder: nil)
        cell.flagName1.text = flagObj1?.stateName
        cell.flagName2.text = flagObj2?.stateName
        if data.createDiscussion?.boolValue == true {
            cell.vsImg?.isHidden = true
        } else {
            cell.vsImg?.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let data = self.arrList[indexPath.row]
        let vc = UIStoryboard.DebateDetailsVC()
        vc.hidesBottomBarWhenPushed = true
        vc.debateDetails = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btnAttendClicked(_ sender: UIButton) {
        let data = self.arrList[sender.tag]
        let myId = UserManager.sharedManager().activeUser.id
        if myId == data.userid || myId == data.opponantTwoUserid {
            let vc = UIStoryboard.DebateDetailsVC()
            vc.hidesBottomBarWhenPushed = true
            vc.debateDetails = data
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            if let debateId = data.id {
                self.callDebetAttendAPI(debetId: debateId)
            }
            let vc = UIStoryboard.DebateDetailsVC()
            vc.hidesBottomBarWhenPushed = true
            vc.debateDetails = data
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func callDebateListAPI(isShowHud: Bool) {
        let pageNo = (self.paging?.currentPage ?? 0)+1
        var params = [String: Any]()
        params["page_no"] = pageNo
        self.isApiCalling = true
        AppAPIManager.getLiveList(params, isShowHud: isShowHud) { status, object in
            self.Livetable.es.stopLoadingMore()
            self.Livetable.es.stopPullToRefresh()
            self.isApiCalling = false
            if status {
                do {
                    let model = try DebateLiveModel(from: object)
                    self.paging = model.data?.paging
                    let arrData = model.data?.users ?? []
                    if pageNo == 1 {
                        self.arrList.removeAll()
                    }
                    if (self.paging?.currentPage ?? 0) >= (self.paging?.lastPage ?? 0)  {
                        self.Livetable.es.noticeNoMoreData()
                    }
                    self.arrList.append(contentsOf: arrData)
                    self.Livetable.reloadData()
                    self.setPlaceholder()
                } catch {
                    print("Error", error)
                }
            }
        }
    }
    
    func callDebetAttendAPI(debetId: Int) {
        var params = [String: Any]()
        params["debet_id"] = debetId
        AppAPIManager.debetAttend(params, isShowHud: true) { status, object in
            if status {
                if let ind = self.arrList.firstIndex(where: { $0.id == debetId }) {
                    self.arrList[ind].debetIsAttent = true
                    self.Livetable.reloadData()
                }
            }
        }
    }
}

class LiveTableCell: UITableViewCell {
    @IBOutlet weak var lblTopic: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblUser1Name: UILabel!
    @IBOutlet weak var lblUser2Name: UILabel!
    @IBOutlet weak var picUser1: UIImageView!
    @IBOutlet weak var picUser2: UIImageView!
    @IBOutlet weak var flagIcon1: UIImageView!
    @IBOutlet weak var flagIcon2: UIImageView!
    @IBOutlet weak var flagName1: UILabel!
    @IBOutlet weak var flagName2: UILabel!
    @IBOutlet weak var viewAttending: UIView!
    @IBOutlet weak var btnAttend: UIButton!
    @IBOutlet weak var vsImg: UIImageView!
    @IBOutlet weak var btnAttendHeight: NSLayoutConstraint!
}
