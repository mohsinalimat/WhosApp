//
//  RegisterViewController.swift
//  WhosApp
//
//  Created by Zhiyuan Cui on 6/24/17.
//  Copyright © 2017 Zhiyuan Cui. All rights reserved.
//

import UIKit
import FirebaseAuth
import MBProgressHUD

class RegisterViewController: UIViewController {

    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var RegisterBtnOutlet: UIButton!
    
    
    var avatarImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //Mark: IBActions
    @IBAction func RegisterBtnPressed(_ sender: UIButton) {
        let email = emailTextField.text;
        let password = passwordTextField.text;
        let username = usernameTextField.text;
        
        if isValidEmail(email: email! ) && password != ""{
            let spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true)
            spinnerActivity?.mode = MBProgressHUDMode.indeterminate
            spinnerActivity?.isUserInteractionEnabled = false;
            
            register(email: email!, password: password!, username: username!, avatarImage: avatarImage);
        }
        
    }
    
    @IBAction func CameraBtnPressed(_ sender: Any) {
    }
    
    func isValidEmail(email: String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func register(email: String, password:String, username: String, avatarImage: UIImage?) {
        
        if avatarImage == nil {
            
        } else {
            //upload avatar image
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {(user, error) in
            MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
            if error != nil {
                
                let alert = UIAlertController(title:"Fail to Register",message:"Fail to register", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title:"Try Again", style:UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated:true, completion:nil)
                
            } else {
                
                //Success
                self.loginUser(email: email, password: password)
            }
        })

    }
    
    func loginUser(email: String, password: String) {
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: {(user, error) in
            if error == nil{
                
                //Go to Application
                let vc = UIStoryboard(name: "Main",bundle:nil).instantiateViewController(withIdentifier: "RecentVC") as! UITabBarController
                vc.selectedIndex = 0;
                self.present(vc, animated: true, completion: nil)
                
            }
        })
    }

}
