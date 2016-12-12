//
//  ViewController.swift
//  QuickbloxDemo
//
//  Created by 默司 on 2016/12/12.
//  Copyright © 2016年 默司. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let login = UserDefaults.standard.string(forKey: "login") {
            signin(with: login)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signin(_ sender: Any) {
        if let text = nameField.text, !text.isEmpty {
            let login = "demo02_\(text)"
            UserDefaults.standard.set(login, forKey: "login")
            signin(with: login)
        }
    }
    
    func signin(with login: String) {
        let password = "12345678"
        print(Date(), "login")
        QBRequest.logIn(withUserLogin: login, password: password, successBlock: { (res, user) in
            user?.password = password
            print(Date(), "connect to chat")
            QBChat.instance().connect(with: user!, completion: { (error) in
                print(Date(), "connected")
                print(error ?? "")
                self.present(self.storyboard!.instantiateViewController(withIdentifier: "CallViewController"), animated: true)
            })
        }, errorBlock: { (res) in
            print(res.error?.reasons ?? [])
        })
    }
}

