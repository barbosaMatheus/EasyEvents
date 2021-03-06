//
//  LoginViewController.swift
//  EasyEvents
//
//  Created by Asaph Matheus Moraes Barbosa on 11/15/16.
//  Copyright © 2016 Oklahoma State University. All rights reserved.
//

import UIKit
import QuartzCore

class LoginViewController: UIViewController {
    
    @IBOutlet weak var logo_image_view: UIImageView!
    //text labels
    @IBOutlet weak var username_label: UITextField!
    @IBOutlet weak var psswd_label: UITextField!
    
    //db information
    var dbUsername: String = ""
    var dbPassword: String = ""
    var user_id: Int = 0 //id attribute for the current user in the database
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //makes a rounded corner logo
        //Joe Kline chose 90, thank you
        logo_image_view.layer.cornerRadius = 90
        logo_image_view.clipsToBounds = true
        
        // Do any additional setup after loading the view
        //to make keyboard go away
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector( self.close_kb ) )
        view.addGestureRecognizer( tap )
        
        
        self.view.backgroundColor = UIColor( patternImage: UIImage( named: "events_image1.jpg" )! )
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
                    guard ( item["username"] as? String ) != nil else {
                        return
                    }
                    guard let id = item["id"] as? String else {
                        let alert = UIAlertController( title: "Database Error:", message: "Please try again", preferredStyle: UIAlertControllerStyle.alert )
                        alert.addAction( UIAlertAction( title: "OK", style: UIAlertActionStyle.default, handler: nil ) )
                        self.present( alert, animated: true, completion: nil )
                        return
                    }
                    
                    self.user_id = Int( id )!
                }
                
                DispatchQueue.main.async {
                    self.performSegue( withIdentifier: "login_segue", sender: self )
                }
                
            } catch {
                print( "Error serializing JSON Data: \(error)" )
            }
        } )
        
        task.resume( )
        //sleep( 2 ) //seriously I can't fix this async bug
        //so this at least gives the db a chance to update
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
