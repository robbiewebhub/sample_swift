//
//  ForumsVC.swift
//  RFP
//
//  Created by LP on 10/01/22.
//

import UIKit
import ESPullToRefresh

class ForumsVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var btnTitel: UIBarButtonItem!
    @IBOutlet weak var Fourrmtable: UITableView!
    
    let profilePic = UIImageView()
    var arrForumTopic: [ForumCategoryModel] = []
    var paging: Paging? = nil
    var canCallAPIOnViewWillAppear = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.setupVC()
        self.callForumTopicListAPI(isShowHud: true)
        self.Fourrmtable.es.addPullToRefresh { [unowned self] in
            self.paging?.currentPage = nil
            self.Fourrmtable.es.resetNoMoreData()
            self.callForumTopicListAPI(isShowHud: false)
        }
        let footer = ESRefreshFooterAnimator()
        footer.noMoreDataDescription = ""
        self.Fourrmtable.es.addInfiniteScrolling(animator: footer) { [unowned self] in
            self.callForumTopicListAPI(isShowHud: false)
        }
        
        self.btnTitel.action = #selector(self.backVC)
        self.btnTitel.target = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setClerColorNavBar()
        if canCallAPIOnViewWillAppear {
            self.paging?.currentPage = nil
            self.callForumTopicListAPI(isShowHud: false)
        }
        let tabs = self.tabBarController as? TabBarVC
        tabs?.centerButton.isHidden = false
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
        

        let buttonadd = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        buttonadd.setImage(UIImage(named: "icn_add_icon_white"), for: .normal)
        let menubaradd = UIBarButtonItem(customView: buttonadd)
        buttonadd.addTarget(self, action: #selector(btnPlusClicked(_:)), for: .touchUpInside)
        self.navigationItem.rightBarButtonItems = [menubaradd]
    }
    
    @objc func backVC() {
        self.navigationController?.popViewController(animated: true)
        self.setClerColorNavBar()
    }
    
    @objc func btnPlusClicked(_ sender: UIButton) {
        let vc = UIStoryboard.CreateForumVC()
        vc.arrForumTopic = self.arrForumTopic
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrForumTopic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ForumstableCell = tableView.dequeueReusableCell(withIdentifier: "ForumstableCell", for: indexPath) as!ForumstableCell
        let data = self.arrForumTopic[indexPath.row]
        let url = URL(string: data.image?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        cell.backImage.kf.indicatorType = .activity
        cell.backImage.kf.setImage(with: url, placeholder: nil)
        cell.backImage.layer.borderWidth = 1
        cell.backImage.layer.borderColor = UIColor.lightGray.cgColor
        cell.lblHeading.text = ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = UIStoryboard.ForumsDetailsLIstVC()
        vc.arrForumTopic = self.arrForumTopic
        vc.forum = self.arrForumTopic[indexPath.row]
        vc.strForumTopicName = self.arrForumTopic[indexPath.row].t_name ?? ""
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ForumsVC {
    func callForumTopicListAPI(isShowHud: Bool) {
        let pageNo = (self.paging?.currentPage ?? 0)+1
        let params = ["page_no": pageNo]
        AppAPIManager.getForumTopicList(params, isShowHud: isShowHud) { status, object in
            self.canCallAPIOnViewWillAppear = true
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
}

class ForumstableCell:UITableViewCell{
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var labelView: UIView!

}
