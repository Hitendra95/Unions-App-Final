//
//  ViewController.swift
//  Unions App
//
//  Created by Hitendra Dubey on 01/04/18.
//  Copyright © 2018 Hitendra Dubey. All rights reserved.
//

import UIKit
import AccountKit
import RealmSwift

class ViewController: UIViewController {
    var accountKit :AKFAccountKit!

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var accounID: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    var token : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(Realm.Configuration.defaultConfiguration.fileURL)
        // Do any additional setup after loading the view, typically from a nib.
        accountKit = AKFAccountKit(responseType: AKFResponseType.accessToken)
        accountKit.requestAccount{
            (account, error) -> Void in
            
            self.token = account?.accountID
    }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submitButtonPressed(_ sender: Any) {
     saveData()
        print("hello tooken")
        print(token)
        
    }
    func saveData()
    {
        var key = Data(count: 64)
        _ = key.withUnsafeMutableBytes { bytes in
            SecRandomCopyBytes(kSecRandomDefault, 64, bytes)
        }
        let config = Realm.Configuration(encryptionKey: key)
        
        let data = FinalData()
        data.name = nameTextField.text!
        data.emailId = emailTextField.text!
        data.accountId = token
        
        
        do
        {
            let realm = try Realm(configuration: config)
            print(Realm.Configuration.defaultConfiguration.fileURL!)
            try realm.write {
                realm.add(data)
                print(Realm.Configuration.defaultConfiguration.fileURL!)
            }
        }
        catch
        {
            print("error making realm object\(error)")
        }
        
        print("data saved")
    }
}

