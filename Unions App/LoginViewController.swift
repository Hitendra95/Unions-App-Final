//
//  LoginViewController.swift
//  Unions App
//
//  Created by Hitendra Dubey on 01/04/18.
//  Copyright © 2018 Hitendra Dubey. All rights reserved.
//

import UIKit
import AccountKit

class LoginViewController: UIViewController ,AKFViewControllerDelegate{

    var accountKit:AKFAccountKit!
    override func viewDidLoad() {
        super.viewDidLoad()
        if accountKit == nil
        {
            self.accountKit = AKFAccountKit(responseType: AKFResponseType.accessToken)
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(accountKit.currentAccessToken != nil)
        {
            print("User already logged in go to view controller")
            DispatchQueue.main.async(execute : {
                self.performSegue(withIdentifier: "showhome", sender: self)
            })
        }
    }

    func viewController(_viewContoller: UIViewController, didCompleteLoginWith accessToken : AKFAccessToken!,state : String!)
    {
        print("Login Sucess With Access Token")
    }
    func viewController(_ viewController: (UIViewController & AKFViewController)!, didCompleteLoginWithAuthorizationCode code: String!, state: String!) {
        print("Login With Authorization Code")
    }
    private func viewController(_ viewController : UIViewController!,didFailWithError error: NSError!)
    {
        print("we have an error \(error)")
    }
    func viewControllerDidCancel(_ viewController: UIViewController!) {
        print("The User cancel the login")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareLoginViewController(_loginViewController : AKFViewController)
    {
        _loginViewController.delegate = self
        _loginViewController.setAdvancedUIManager(nil)
        
        let theme:AKFTheme = AKFTheme.default()
        theme.headerBackgroundColor = UIColor(red: 0.325, green: 0.557, blue: 1, alpha: 1)
        theme.headerTextColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        theme.iconColor = UIColor(red: 0.325, green: 0.557, blue: 1, alpha: 1)
        theme.inputTextColor = UIColor(white: 0.4, alpha: 1.0)
        theme.statusBarStyle = .default
        theme.textColor = UIColor(white: 0.3, alpha: 1.0)
        theme.titleColor = UIColor(red: 0.247, green: 0.247, blue: 0.247, alpha: 1)
        //check
        _loginViewController.setTheme(theme)
        
    }
//continue with phone number function
    @IBAction func loginWithPhone(_ sender: Any) {
        //login with Phone
        let inputState: String = UUID().uuidString
        let viewController:AKFViewController = accountKit.viewControllerForPhoneLogin(with: nil, state: inputState)  as AKFViewController
        viewController.enableSendToFacebook = true
        self.prepareLoginViewController(_loginViewController: viewController)
        self.present(viewController as! UIViewController, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
