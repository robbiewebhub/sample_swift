//
//  ReligionAndPublicVC.swift
//  RFP
//
//  Created by Apple on 04/04/2024.
//

import Foundation
import UIKit
import ESPullToRefresh

class ReligionAndPublicVC: BaseViewController, viewCount, WebSocketConnectionDelegate {
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet weak var btnTitel: UIBarButtonItem!
    @IBOutlet weak var religionStackView: UIStackView!
    @IBOutlet weak var publicSquareStackView: UIStackView!
    @IBOutlet weak var religionStackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var publicSquareStackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var Fourrmtable: UITableView!
    @IBOutlet weak var tblInstance: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var myForumView: UIView!
    @IBOutlet weak var floatingButton: UIButton!
    @IBOutlet weak var textSearchView: UIView!
    
    var data: ForumDetails?
    let profilePic = UIImageView()
    var strForumTopicName: String = ""
    private var arrForum: [ForumDetails] = []
    private var paging: Paging? = nil
    var forum: ForumCategoryModel? = nil
    var arrForumTopic: [ForumCategoryModel] = []
    var arrForumTopicHolder: [ForumDetails] = []
    var uID: Int? = nil
    var webSocketConnection: WebSocketConnection!
    var memberSearchText = ""
    private var arrMyForum: [ForumDetails] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        txtSearch.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        self.changebtnTitel(btn: self.btnTitel)
        self.religionStackView.isHidden = true
        self.publicSquareStackView.isHidden = true
        self.Fourrmtable.isHidden = false
        self.myForumView.isHidden = true
        self.religionStackViewHeight.constant = 0
        self.publicSquareStackViewHeight.constant = 0
        segmentedControl.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
        webSocketConnection = SocketIOManager()
        webSocketConnection.delegate = self
        webSocketConnection.send(text: WebSocketSubscription.createForumSubscription)
        webSocketConnection.send(text: WebSocketSubscription.likeForumSubscription)
        webSocketConnection.send(text: WebSocketSubscription.createForumDeleteSubscription)
        webSocketConnection.send(text: WebSocketSubscription.forumListSubscription)
        
        self.paging?.currentPage = nil
        callForumTopicListAPI(isShowHud: true)
        uID = UserManager.sharedManager().activeUser.id
        txtSearch.isHidden = true
        textSearchView.isHidden = true
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
        let titleTextAttributesSelect = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
        segmentedControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(titleTextAttributesSelect, for: .selected)
        setAttributedPlaceholder(for: txtSearch, text: "Search")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let picURL = UserManager.sharedManager().activeUser?.photo ?? ""
        let profileImage = URL(string: picURL)
        let placholder = UIImage(named: "icn_placeholder_user")
        profilePic.kf.setImage(with: profileImage, placeholder: placholder)
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
        
        let Menubaritem = UIBarButtonItem(customView: ItemView)
        Menubaritem.target = self
        Menubaritem.action = #selector(self.showMenu(_:))
        self.navigationItem.rightBarButtonItems = [Menubaritem]
    }
    
    func setAttributedPlaceholder(for textField: UITextField, text: String) {
        textField.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        DispatchQueue.main.async {
            if self.segmentedControl.selectedSegmentIndex == 0 {
                self.Fourrmtable.reloadData()
                self.paging?.currentPage = nil
                self.callForumTopicListAPI(isShowHud: true)
                self.religionStackView.isHidden = true
                self.publicSquareStackView.isHidden = true
                self.Fourrmtable.isHidden = false
                self.myForumView.isHidden = true
                self.religionStackViewHeight.constant = 0
                self.publicSquareStackViewHeight.constant = 0
                
            } else if self.segmentedControl.selectedSegmentIndex == 1 {
                self.tblInstance.reloadData()
                self.paging?.currentPage = nil
                self.callForumListAPI(isShowHud: true, shouldBroadcast: "true")
                self.religionStackView.isHidden = true
                self.publicSquareStackView.isHidden = true
                self.Fourrmtable.isHidden = true
                self.myForumView.isHidden = false
                self.religionStackViewHeight.constant = 0
                self.publicSquareStackViewHeight.constant = 0
                
            } else if self.segmentedControl.selectedSegmentIndex == 2 {
                self.religionStackView.isHidden = false
                self.publicSquareStackView.isHidden = true
                self.Fourrmtable.isHidden = true
                self.myForumView.isHidden = true
                self.religionStackViewHeight.constant = 260
                self.publicSquareStackViewHeight.constant = 0
                
            } else if self.segmentedControl.selectedSegmentIndex == 3 {
                self.religionStackView.isHidden = true
                self.publicSquareStackView.isHidden = false
                self.Fourrmtable.isHidden = true
                self.myForumView.isHidden = true
                self.religionStackViewHeight.constant = 0
                self.publicSquareStackViewHeight.constant = 110
            }
        }
    }
    
    @IBAction func floatingButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.CreateMenuPopupVC()
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .overFullScreen
        self.present(navigationController, animated: false)
    }
    
    @IBAction func forumTapped() {
        let vc = UIStoryboard.CreatedForumsVc()
        vc.forum = ForumCategoryModel(t_id: nil, t_name: "Religion Forums", image: nil)
        vc.strForumTopicName = "Religion Forums"
        vc.religionTopicId = 4
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func religionQuestionTapped() {
        let vc = UIStoryboard.QuestionVC()
        vc.questionType = "Religion"
        vc.createQuestionCategory = "Religion"
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func liveChatTapped() {
        let vc = UIStoryboard.PublicSquareLiveChatVC()
        vc.socketId = "2"
        vc.liveChatType = "public_square"
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func religionLiveChatTapped() {
        let vc = UIStoryboard.PublicSquareLiveChatVC()
        vc.socketId = "1"
        vc.liveChatType = "religion"
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func publicSquareQuestionTapped() {
        let vc = UIStoryboard.QuestionVC()
        vc.questionType = "Public Square"
        vc.createQuestionCategory = "Public Square"
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func religionBibleTapped() {
        let vc = UIStoryboard.BibleBookVC()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func onConnected(connection: WebSocketConnection) {
        print("Connected")
    }
    
    func onDisconnected(connection: WebSocketConnection, error: Error?) {
        if let error = error {
            print("Disconnected with error:\(error)")
        } else {
            print("Disconnected normally")
        }
    }
    
    func onError(connection: WebSocketConnection, error: Error) {
        print("Connection error:\(error)")
    }
    
    func onMessage(connection: WebSocketConnection, text: String) {
        if let data = text.data(using: .utf8) {
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if json["event"] as! String == "App\\Events\\CreateEvent" {
                        DispatchQueue.main.async {
                            self.paging?.currentPage = nil
                            self.tblInstance.es.resetNoMoreData()
                            self.callForumListAPI(isShowHud: false, shouldBroadcast: "false")
                        }
                        
                    } else if json["event"] as! String == "App\\Events\\ForumEvent" && json["channel"] as! String == "forum.like"  {
                        if let dataString = json["data"] as? String,
                           let jsonData = dataString.data(using: .utf8),
                           let dataDictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? NSDictionary {
                            let _ = self.convertToDictionary(text: dataDictionary["data"] as! [String : Any])
                        }
                    } else if json["event"] as! String == "App\\Events\\ForumEvent" && json["channel"] as! String == "forum.list" {
                        if let dataString = json["data"] as? String,
                           let jsonData = dataString.data(using: .utf8),
                           let dataDictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? NSDictionary {
                            self.paging?.currentPage = nil
                            self.tblInstance.es.resetNoMoreData()
                            self.callForumListAPI(isShowHud: false, shouldBroadcast: "false")
                        }
                    }
                }
            } catch {
                print("Error deserializing JSON: \(error)")
            }
        }
    }
    
    func onMessage(connection: WebSocketConnection, data: Data) {
        print("Data message: \(data)")
    }
    
    @objc func textFieldChange(_ textField: UITextField) {
        let keyword = textField.text?.trim() ?? ""
        if !keyword.isEmpty {
            memberSearchText = textField.text ?? ""
            self.arrForum = self.arrForumTopicHolder.filter({
                $0.firstName?.localizedCaseInsensitiveContains(keyword) == true ||
                $0.lastName?.localizedCaseInsensitiveContains(keyword) == true ||
                $0.postData?.title?.localizedCaseInsensitiveContains(keyword) == true
            })
        } else {
            memberSearchText = textField.text ?? ""
            self.arrForum = self.arrForumTopicHolder
        }
        self.tblInstance.reloadData()
    }
}

// MARK: APICall
extension ReligionAndPublicVC {
    func callForumTopicListAPI(isShowHud: Bool) {
        let pageNo = (self.paging?.currentPage ?? 0)+1
        let params = ["page_no": pageNo]
        AppAPIManager.getForumTopicList(params, isShowHud: isShowHud) { status, object in
            self.Fourrmtable.es.stopLoadingMore()
            self.Fourrmtable.es.stopPullToRefresh()
            if status {
                do {
                    let model = try ForumListModel(from: object)
                    self.paging = model.data?.paging
                    let forums = model.data?.category ?? []
                    if pageNo == 1 {
                        self.arrForumTopic.removeAll()
                    }
                    if (self.paging?.currentPage ?? 0) >= (self.paging?.lastPage ?? 0) {
                        self.Fourrmtable.es.noticeNoMoreData()
                    }
                    self.arrForumTopic.append(contentsOf: forums)
                    self.Fourrmtable.reloadData()
                } catch {
                    print("Error", error)
                }
            }
        }
    }
    
    func callForumListAPI(isShowHud: Bool, shouldBroadcast: String) {
        var pageNo = Int()
        pageNo = (self.paging?.currentPage ?? 0) + 1
        var params: [String: Any] = ["page_no": pageNo,
                                     "should_broadcast": shouldBroadcast]
        if let uid = self.uID {
            params["u_id"] = uid
        }
        if let topicId = self.forum?.t_id {
            params["topic_id"] = topicId
        }
        AppAPIManager.getForumDetailsList(params, isShowHud: isShowHud) { status, object in
            self.tblInstance.es.stopLoadingMore()
            self.tblInstance.es.stopPullToRefresh()
            if status {
                do {
                    let model = try ForumDetailsListModel(from: object)
                    self.paging = model.data?.paging
                    let forums = model.data?.forum ?? []
                    if pageNo == 1 {
                        self.arrForum.removeAll()
                    }
                    if (self.paging?.currentPage ?? 0) >= (self.paging?.lastPage ?? 0)  {
                        self.tblInstance.es.noticeNoMoreData()
                    }
                    self.arrForum.append(contentsOf: forums)
                    self.arrForumTopicHolder = self.arrForum
                    if self.arrForum.count == 0 {
                        let placeholder = UILabel(frame: self.tblInstance.frame)
                        placeholder.textColor = .lightGray
                        placeholder.textAlignment = .center
                        placeholder.text = "No Forums are available."
                        self.tblInstance.backgroundView = placeholder
                    } else {
                        self.tblInstance.backgroundView = nil
                    }
                    self.tblInstance.reloadData()
                } catch {
                    print("Error", error)
                }
            }
        }
    }
    
    func callForumLikeAPI(postId: String) {
        let param = ["post_id": "\(postId)"]
        AppAPIManager.forumLike(param) { status, object in
            if status {
                do {
                    let model = try ForumDetails(from: object["data"] as Any)
                    if let index = self.arrForum.firstIndex(where: {$0.id?.toString == postId}) {
                        self.arrForum[index].postData?.isLiked = model.postData?.isLiked
                        if let likeCnt = model.postData?.likeCount {
                            self.arrForum[index].postData?.likeCount = likeCnt
                        }
                        if let userPlusLikeCount = model.postData?.userPlusLikeCount {
                            self.arrForum[index].postData?.userPlusLikeCount = userPlusLikeCount
                        }
                    }
                    self.tblInstance.reloadData()
                } catch {
                    print("Error:", error)
                }
            }
        }
    }
    
    func callForumPinAPI(forumId: Int, action: String, categoryId: Int) {
        let param = ["type": "forum",
                     "type_id": "\(forumId)",
                     "action": action,
                     "category_id": "\(categoryId)"]
        AppAPIManager.forumPin(param) { status, object in
            if status {
                if object["msg"] as! String == "Pin limit reached." {
                    let alert = UIAlertController().alertWithOk(appName, message: "You can only pin up to 5 forums.") { action in
                        if action?.style == .default {
                            self.dismiss(animated: true)
                        }
                    }
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self.paging?.currentPage = nil
                    self.callForumListAPI(isShowHud: false, shouldBroadcast: "false")
                }
            }
        }
    }
    
    func convertToDictionary(text: [String:Any]) {
        do {
            let model = try? ForumDetails(from: text["data"] as Any)
            if let index = self.arrForum.firstIndex(where: {$0.id?.toString == model?.id?.toString}) {
                if let likeCnt = model?.postData?.likeCount {
                    self.arrForum[index].postData?.likeCount = likeCnt
                }
                if let userPlusLikeCount = model?.postData?.userPlusLikeCount {
                    self.arrForum[index].postData?.userPlusLikeCount = userPlusLikeCount
                }
            }
            DispatchQueue.main.async {
                self.tblInstance.reloadData()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func viewCountSend(viewCount: Int, Id: Int) {
        if let index = self.arrForum.firstIndex(where: {$0.id?.toString == Id.toString}) {
            self.arrForum[index].postData?.viewCount = viewCount
        }
        DispatchQueue.main.async {
            self.tblInstance.reloadData()
        }
    }
}

// MARK: UITableViewDataSource
extension ReligionAndPublicVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 1 {
            return self.arrForum.count
        } else {
            return self.arrForumTopic.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentedControl.selectedSegmentIndex == 1 {
            let cell = self.tblInstance.dequeueReusableCell(withIdentifier: "ForumsDetailsItemCell") as! ForumsDetailsItemCell
            if self.arrForum.count > indexPath.row {
                let data = self.arrForum[indexPath.row]
                cell.configure(with: data)
                cell.btnLike.tag = indexPath.row
                cell.btnLike.addTarget(self, action: #selector(btnLikeUnlikeClicked(_:)), for: .touchUpInside)
                cell.btnLikeList.tag = indexPath.row
                cell.btnLikeList.addTarget(self, action: #selector(btnLikeListClicked(_:)), for: .touchUpInside)
                cell.forumImage.isUserInteractionEnabled = true
                cell.forumImage.tag = indexPath.row
                cell.openUserProfile = {
                    self.openUserProfileTapped(userId: "\(data.userid?.rawValue ?? "")")
                }

                let tapGestr = UITapGestureRecognizer(target: self, action: #selector(openImage(_:)))
                cell.forumImage.addGestureRecognizer(tapGestr)
                cell.btnPin.tag = indexPath.row
                cell.btnPin.addTarget(self, action: #selector(btnPinTapped), for: .touchUpInside)
                if self.arrForum[indexPath.row].isPinned == 0 {
                    cell.btnPin.isSelected = false
                } else {
                    cell.btnPin.isSelected = true
                }
                cell.btnPin.isHidden = true
            }
            return cell
        } else {
            let cell = self.Fourrmtable.dequeueReusableCell(withIdentifier: "ForumstableCell") as! ForumstableCell
            let data = self.arrForumTopic[indexPath.row]
            let url = URL(string: data.image?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
            cell.backImage.kf.indicatorType = .activity
            cell.backImage.kf.setImage(with: url, placeholder: nil)
            cell.lblHeading.text = data.t_name
            cell.labelView.layer.cornerRadius = 25
            cell.labelView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if segmentedControl.selectedSegmentIndex == 1 {
            return UITableView.automaticDimension
        } else {
            return 200
        }
    }
    
    @objc func btnLikeUnlikeClicked(_ sender: UIButton) {
        if let postId = self.arrForum[sender.tag].id?.toString {
            self.callForumLikeAPI(postId: postId)
        }
    }
    
    @objc func btnLikeListClicked(_ sender: UIButton) {
        if let postId = self.arrForum[sender.tag].id?.toString {
            let vc = UIStoryboard.LikedByVC()
            vc.hidesBottomBarWhenPushed = true
            vc.postId = postId
            vc.likedType = .forum
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    @objc func openUserProfileTapped(userId: String) {
      
        let currentUserId = UserManager.sharedManager().activeUser?.id.toString
       
        if userId == currentUserId {
            
            let vc = UIStoryboard.MyProfileVC()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = UIStoryboard.UserProfileVC()
            vc.userId = userId
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }


    
    @objc func openImage(_ sender: UITapGestureRecognizer) {
        if let index = sender.view?.tag {
            let url = self.arrForum[index].postData?.photo ?? ""
            let VC1 = UIStoryboard.ImageViewController()
            VC1.ImgOpen = url
            let navController = UINavigationController(rootViewController: VC1)
            self.present(navController, animated:true, completion: nil)
        }
    }
    
    @objc func btnPinTapped(_ sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        if let cell = tblInstance.cellForRow(at: indexPath) as? ForumsDetailsItemCell {
            if self.arrForum[indexPath.row].isPinned == 0 {
                cell.btnPin.isSelected = true
                self.callForumPinAPI(forumId: self.arrForum[sender.tag].id ?? 0, action: "pin", categoryId: self.arrForum[sender.tag].topicID ?? 0)
            } else {
                cell.btnPin.isSelected = false
                self.callForumPinAPI(forumId: self.arrForum[sender.tag].id ?? 0, action: "unpin", categoryId: self.arrForum[sender.tag].topicID ?? 0)
            }
        }
    }
}

// MARK: UITableViewDelegate
extension ReligionAndPublicVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segmentedControl.selectedSegmentIndex == 1 {
            let vc = UIStoryboard.RoomDetailsVC()
            vc.delegate = self
            vc.arrForumTopic = self.arrForumTopic
            vc.strForumTopicName = self.strForumTopicName
            vc.strTitle = self.arrForum[indexPath.row].postData?.title ?? ""
            vc.forumId = self.arrForum[indexPath.row].id?.toString ?? ""
            vc.time = self.arrForum[indexPath.row].postData?.lastActivity ?? ""
            vc.hidesBottomBarWhenPushed = true
            vc.onDelete = {
                self.paging?.currentPage = nil
                self.callForumListAPI(isShowHud: true, shouldBroadcast: "false")
            }
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
            let vc = UIStoryboard.ForumsDetailsLIstVC()
            vc.arrForumTopic = self.arrForumTopic
            vc.forum = self.arrForumTopic[indexPath.row]
            vc.strForumTopicName = self.arrForumTopic[indexPath.row].t_name ?? ""
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

class ForumsDetailsItemCell: UITableViewCell {
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var forumImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblByName: UILabel!
    @IBOutlet weak var lblView: UILabel!
    @IBOutlet weak var lblLikeCnt: UILabel!
    @IBOutlet weak var lblLastActivity: UILabel!
    @IBOutlet weak var btnLikeList: UIButton!
    @IBOutlet weak var eyeIcon: UIImageView!
    @IBOutlet weak var viewLabel: UILabel!
    @IBOutlet weak var btnPin: UIButton!
   
    var openUserProfile: (() -> Void)? = nil
    var openMyProfile: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblByName.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(openProfile))
        self.lblByName.addGestureRecognizer(tap)
    }
    
    @objc func openProfile() {
        openUserProfile?()
    }
    
    func configure(with data: ForumDetails) {
        let imgUrl = URL(string: data.postData?.photo ?? "")
        let placeholder = UIImage(named: "icn_placeholder_image")
        self.forumImage.kf.setImage(with: imgUrl, placeholder: placeholder)
        self.lblTitle.text = data.postData?.title
        self.lblByName.text = "\(data.firstName ?? "") \(data.lastName ?? "")"
        self.lblView.text = data.postData?.viewCount?.toString
        self.lblLikeCnt.text = data.postData?.userPlusLikeCount?.rawValue
        let dateTime = getDateFromString(strDate: data.postData?.lastActivity ?? "")
        self.lblLastActivity.text = "\(dateTime?.timeAgoSinceDate() ?? "")"
        
        if data.postData?.isLiked == true {
            self.btnLike.isSelected = true
        } else {
            self.btnLike.isSelected = false
        }
    }
}
