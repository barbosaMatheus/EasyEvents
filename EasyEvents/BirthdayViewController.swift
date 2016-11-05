//
//  BirthdayViewController.swift
//  EasyEvents
//
//  Created by Cole Thornton on 11/4/16.
//  Copyright © 2016 Oklahoma State University. All rights reserved.
//

import UIKit

class BirthdayViewController: UIViewController {

    let bP = UIImage(named: "BirthdayPresent_Color.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        //Draws background on
//        let backGrect = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
//        let background = UIView.init(frame: backGrect)
//        background.backgroundColor = UIColor(patternImage: UIImage(named:"MAD_EE_Background.png")!)
//        view.addSubview(background)
        
        //Draws greyed out version of the birthday present, meaning no progress made yet
        let presentRect = CGRect(x: (self.view.bounds.size.width / 4), y: (self.view.bounds.size.height / 3), width: (bP?.size.width)!, height: (bP?.size.height)!)
        let present = UIView.init(frame: presentRect)
        present.backgroundColor = UIColor(patternImage: UIImage(named:"BirthdayPresent_Gray.png")!)
        view.addSubview(present)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
