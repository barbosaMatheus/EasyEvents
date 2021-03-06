//
//  SplashScreenViewController.swift
//  EasyEvents
//
//  Created by Ryan Thomas McIver on 10/25/16.
//  Copyright © 2016 Oklahoma State University. All rights reserved.
//

import UIKit
import QuartzCore

class SplashScreenViewController: UIViewController {

    //db information
    var dbUsername: String = ""
    var dbPassword: String = ""
    var user_id: Int = 0 //id attribute for the current user in the database
    
    @IBOutlet weak var logo_image_view: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        logo_image_view.layer.cornerRadius = 90
        logo_image_view.clipsToBounds = true
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor( patternImage: UIImage( named: "events_image2.jpg" )! )
        self.navigationItem.setHidesBackButton( true, animated:true )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        guard let vc = segue.destination as? HomeScreenViewController else {
            return
        }
        vc.user_id = self.user_id
        vc.dbUsername = self.dbUsername
        vc.dbPassword = self.dbPassword
    }
    

}
