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
    let levels = 12
    var levelCount = 0
    var imageFractions = [UIView]()
    
    @IBAction func AddLevelButton(_ sender: UIButton) {
        if(levelCount < levels){
            view.addSubview(imageFractions[levelCount])
            levelCount = levelCount + 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ////Draws background on
        //let backGrect = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
        //let background = UIView.init(frame: backGrect)
        //background.backgroundColor = UIColor(patternImage: UIImage(named:"MAD_EE_Background.png")!)
        //view.addSubview(background)
        
        //Draws greyed out version of the birthday present, meaning no progress made yet
        let presentRect = CGRect(x: (self.view.bounds.size.width / 4), y: (self.view.bounds.size.height / 3), width: (bP?.size.width)!, height: (bP?.size.height)!)
        let present = UIView.init(frame: presentRect)
        present.backgroundColor = UIColor(patternImage: UIImage(named:"BirthdayPresent_Gray.png")!)
        view.addSubview(present)
        
        splitImage()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func splitImage(){
        
        let tempImage = bP?.cgImage
        var fractionsCount = 0
        
        while(fractionsCount < 12){
            
            let f1 = tempImage!.cropping(to: CGRect(x: 0, y: 0, width: (bP?.size.width)!, height: ( ((bP?.size.height)! / CGFloat(levels)) + (CGFloat(fractionsCount) * (bP?.size.height)! / CGFloat(levels)) )))
            let fractIm1 = UIImage(cgImage: f1!)
            let pP1Rect = CGRect(x:(self.view.bounds.size.width / 4), y:(self.view.bounds.size.height / 3), width:(fractIm1.size.width), height: (fractIm1.size.height))
            let presentPart = UIView.init(frame: pP1Rect)
            presentPart.backgroundColor = UIColor(patternImage: fractIm1)
            imageFractions.append(presentPart)
            fractionsCount = fractionsCount + 1
            
        }
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
