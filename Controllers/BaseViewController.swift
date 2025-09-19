//
//  BaseViewController.swift
//  RFP
//
//  Created by LP on 06/01/22.
//

import UIKit
import SideMenu

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: -  Custom Methods
    func setClerColorNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(hex: "#FAE2B4"), NSAttributedString.Key.font: UIFont(name: kFonts.fontSemibold, size: 18)!]
        UINavigationBar.appearance().barTintColor = .clear
        UIBarButtonItem.appearance().tintColor = .clear
        UINavigationBar.appearance().backgroundColor = .clear
    }
    
    func setColorNavBar() {
        UINavigationBar.appearance().backgroundColor = UIColor(named:"Color1") // backgorund color with gradient
        // or
        UINavigationBar.appearance().barTintColor = UIColor(named:"Color1")  // solid color
        
        UIBarButtonItem.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(hex: "#FAE2B4"), NSAttributedString.Key.font: UIFont(name: kFonts.fontSemibold, size: 18)!]
        UITabBar.appearance().barTintColor = .white
    }
    
    func setScrollEdgeAppearance(vc: UIViewController) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(named:"Color1")
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(hex: "#FAE2B4"), NSAttributedString.Key.font: UIFont(name: kFonts.fontSemibold, size: 18)!]
        vc.navigationItem.scrollEdgeAppearance = navBarAppearance
    }
    
    @objc func showMenu(_ sender: UIBarButtonItem) {
        let obj = UIStoryboard.SideMenuVC()
        /*
         obj.modalPresentationStyle = .overFullScreen
         self.navigationController?.present(obj, animated:false, completion:nil)
         */
        let menu = SideMenuNavigationController(rootViewController: obj)
        menu.navigationBar.isHidden = true
        let settings = makeSettings()
        menu.settings = settings
        present(menu, animated: true, completion: nil)
    }
    
    @objc func backMenu() {
        self.navigationController?.popViewController(animated:true)
    }
    
    func changebtnTitel(btn:UIBarButtonItem) {
        btn.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name:CUSTOM_FONTS.BOLD, size: 20)!, NSAttributedString.Key.foregroundColor :UIColor(named: "TextColor") ?? ""], for:.disabled)
        /*
         btn.setTitelTextattribute
         */
    }
    
    @IBAction func btnBackVKClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

func makeSettings() -> SideMenuSettings {
    var presentationStyle = SideMenuPresentationStyle()
    presentationStyle = .menuSlideIn
    presentationStyle.backgroundColor = .clear
    presentationStyle.menuStartAlpha = 0.5
    presentationStyle.onTopShadowOpacity = 1
    presentationStyle.presentingEndAlpha = 0.8
    presentationStyle.presentingScaleFactor = 1
    
    var settings = SideMenuSettings()
    settings.presentationStyle = presentationStyle
    settings.menuWidth = UIScreen.main.bounds.width
    settings.blurEffectStyle = .dark
    settings.statusBarEndAlpha = 1
    return settings
}
