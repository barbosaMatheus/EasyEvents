//
//  LoginViewController.swift
//  EasyEvents
//
//  Created by Asaph Matheus Moraes Barbosa on 11/15/16.
//  Copyright © 2016 Oklahoma State University. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //text labels
    @IBOutlet weak var username_label: UITextField!
    @IBOutlet weak var psswd_label: UITextField!
    
    //flags
    var username_found = false
    
    //db information
    var dbUsername: String = ""
    var dbPassword: String = ""
    var user_id: Int = 1 //id attribute for the current user in the database
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        //to make keyboard go away
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector( self.close_kb ) )
        view.addGestureRecognizer( tap )
        
        
        self.view.backgroundColor = UIColor( patternImage: UIImage( named: "MAD_EE_Background.png" )! )
    }
    
    func close_kb( ) {
        view.endEditing( true )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func login_pressed(_ sender: AnyObject) {
        self.dbUsername = username_label.text!
        self.dbPassword = psswd_label.text!
        
        //JSON interfacing (using Dr. Mayfield's example code)
        let url = URL( string:"https://cs.okstate.edu/~asaph/login.php?u=\(self.dbUsername)&p=\(self.dbPassword)" )!
        let config = URLSessionConfiguration.default
        let session = URLSession( configuration: config )
        
        let task = session.dataTask( with: url, completionHandler: { (data, response, error) in
            guard error == nil else {
                print("Error in session call: \(error)")
                return
            }
            
            guard let result = data else {
                print( "No data\n" )
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject( with: result, options: .allowFragments ) as? [[String: AnyObject]]
                
                //check if this user exists in the db
                for item in json! {
                    guard let user = item["username"] as? String else {
                        print( "USERNAME NOT FOUND!" )
                        return
                    }
                    //guard let id = item["id"] as? Int else {
                    //    return
                    //}
                    if user == self.dbUsername {
                        //print( "FOUND USERNAME" )
                        self.username_found = true
                        //self.user_id = id
                    }
                }
            } catch {
                print( "Error serializing JSON Data: \(error)" )
            }
        } )
        
        task.resume( )
        
        if self.username_found {
            performSegue( withIdentifier: "login_segue", sender: self )
        }
        else {
            let alert = UIAlertController( title: "Cannot Login:", message: "Username \"\(self.dbUsername)\" not found.", preferredStyle: UIAlertControllerStyle.alert )
            alert.addAction( UIAlertAction( title: "OK", style: UIAlertActionStyle.default, handler: nil ) )
            self.present( alert, animated: true, completion: nil )
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        guard let vc = segue.destination as? SplashScreenViewController else {
            return
        }
        vc.user_id = self.user_id
        vc.dbUsername = self.dbUsername
        vc.dbPassword = self.dbPassword
    }
}
