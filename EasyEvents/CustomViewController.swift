//
//  CustomViewController.swift
//  EasyEvents
//
//  Created by Cole Thornton on 11/11/16.
//  Copyright © 2016 Oklahoma State University. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {

    let gC = UIImage(named: "GeneralCalendarColor.png")
    
    //choice IS THE VARIABLE TO CHANGE DEPENDING ON NUMBER OF CUSTOM STEPS
    //NEEDED, (8-18), AT MOMENT OF SEGUE.
    var choice = 12  //8-18
    
    var levelCount = 0
    var imageFractions = [UIView]()
    
    @IBAction func AddLevelButton(_ sender: UIButton) {
        if(levelCount < choice){
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
        
        //Draws greyed out version of the briefcase, meaning no progress made yet
        let genCalRect = CGRect(x: (self.view.bounds.size.width / 5), y: (self.view.bounds.size.height / 3), width: (gC?.size.width)!, height: (gC?.size.height)!)
        let genCalImage = UIView.init(frame: genCalRect)
        genCalImage.backgroundColor = UIColor(patternImage: UIImage(named:"GeneralCalendarGray.png")!)
        genCalImage.alpha = 0.4
        view.addSubview(genCalImage)
        
        splitImage()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func splitImage(){
        
        let tempImage = gC?.cgImage
        var fractionsCount = 0
        
        while(fractionsCount < choice){
            
            let f1 = tempImage!.cropping(to: CGRect(x: 0, y: 0, width: (gC?.size.width)!, height: ( ((gC?.size.height)! / CGFloat(choice)) + (CGFloat(fractionsCount) * (gC?.size.height)! / CGFloat(choice)) )))
            let fractIm1 = UIImage(cgImage: f1!)
            let bcP1Rect = CGRect(x:(self.view.bounds.size.width / 5), y:(self.view.bounds.size.height / 3), width:(fractIm1.size.width), height: (fractIm1.size.height))
            let casePart = UIView.init(frame: bcP1Rect)
            casePart.backgroundColor = UIColor(patternImage: fractIm1)
            imageFractions.append(casePart)
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
