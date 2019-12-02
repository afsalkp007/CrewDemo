//
//  BaseViewController.swift
//  CrewDemo
//
//  Created by Wasim on 14/11/19.
//  Copyright © 2019 Wasim. All rights reserved.
//

import UIKit
import MBProgressHUD
class BaseViewController: UIViewController {

    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var hud : MBProgressHUD!
    var alertController:UIAlertController?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //MARK: Show Progress
    func showProgress(_ strTitle: String? = nil) {
        
        self.hud = MBProgressHUD.showAdded(to: self.appDelegate.window! , animated: true)
        self.hud.removeFromSuperViewOnHide = true
        if let title = strTitle {
            self.hud.label.text = title
            self.hud.label.numberOfLines = 0
        }
    }
    
    @objc func hideProgress() {
        if(!self.hud.isHidden) {
            self.hud.hide(animated: true)
        }
    }
    
    //MARK: - show alerts
    func showAlert(_ message:String) {
        self.showAlert(message, title: "")
    }
    
    // Shows an alert view with the passed message and title on the calling controller.
    func showAlert(_ message:String, title:String) {
        self.alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertController.Style.alert)
        self.alertController!.addAction(UIAlertAction(title: STR_OK, style: UIAlertAction.Style.default,handler: nil))
        
        self.present(self.alertController!, animated: true, completion: nil)
        
    }
    

}
