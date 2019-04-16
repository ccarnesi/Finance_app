//
//  ViewController.swift
//  Finance_app
//
//  Created by Chris Carnesi on 2/22/19.
//  Copyright © 2019 Carnesi. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase


class ViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    
    @IBAction func test(_ sender: Any) {
        print("Hello")
    }
    
    @IBAction func sign_In(_ sender: Any) {
        print("hi")
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance().signIn()
        // Do any additional setup after loading the view, typically from a nib.
        if let user = Auth.auth().currentUser{
            //someone is signed in
            print("Someone sigend in " + user.email!)
            
        }else{
            //Nobody is logged in
            print("Someone not sigend in")
        }
        
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let authentication = user.authentication else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signInAndRetrieveData(with: credentials) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let result = authResult{
                print(result.user.getIDTokenForcingRefresh(true, completion: { (token, error) in
                    if let error = error{
                        print(error.localizedDescription)
                    }
                    if let token = token{
                         print(token)
                        
                    }
                   
                }))
            }
            
        }
    }

}



