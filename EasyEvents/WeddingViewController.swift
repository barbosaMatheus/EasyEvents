//
//  WeddingViewController.swift
//  EasyEvents
//
//  Created by Cole Thornton on 11/4/16.
//  Copyright © 2016 Oklahoma State University. All rights reserved.
//

import UIKit

class WeddingViewController: UIViewController {
    
    let wC = UIImage(named: "WeddingCake_Color.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Draws background on
        let backGrect = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
        let background = UIView.init(frame: backGrect)
        background.backgroundColor = UIColor(patternImage: UIImage(named:"MAD_EE_Background.png")!)
        view.addSubview(background)
        
        //Draws greyed out version of the wedding cake, meaning no progress made yet
        let cakeGreyRect = CGRect(x: (self.view.bounds.size.width / 16), y: (self.view.bounds.size.height / 4), width: (wC?.size.width)!, height: (wC?.size.height)!)
        let cakeGrey = UIView.init(frame: cakeGreyRect)
        cakeGrey.backgroundColor = UIColor(patternImage: UIImage(named:"WeddingCake_Gray.png")!)
        view.addSubview(cakeGrey)
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
