//
//  BusinessViewController.swift
//  EasyEvents
//
//  Created by Cole Thornton on 11/4/16.
//  Copyright © 2016 Oklahoma State University. All rights reserved.
//

import UIKit

class BusinessViewController: UIViewController {

    let bC = UIImage(named: "Briefcase_Color.png")
    let levels = 8
    var levelCount = 0
    var imageFractions = [UIView]()
    
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var PercentLabel: UILabel!
    var completion : Double = 0.0
    var date: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor( patternImage: UIImage( named: "celebration.jpeg" )! )
        
        //EDIT THIS TO CHANGE THE PERCENT AND DATE LABELS WHEN SEGUEING IN
        PercentLabel.text = "\(completion)% completed"
        DateLabel.text = date
        levelCount = Int( ( completion/100.0 )*Double( levels ) ) - 1
        if levelCount < 0 { levelCount = 0 }
        
        //Draws greyed out version of the briefcase, meaning no progress made yet
        let briefcaseRect = CGRect(x: (self.view.bounds.size.width / 4), y: (self.view.bounds.size.height / 3), width: (bC?.size.width)!, height: (bC?.size.height)!)
        let briefcase = UIView.init(frame: briefcaseRect)
        briefcase.backgroundColor = UIColor(patternImage: UIImage(named:"Briefcase_Gray.png")!)
        briefcase.alpha = 0.4
        view.addSubview(briefcase)
        
        splitImage()
        print( levelCount )
        view.addSubview( imageFractions[levelCount] )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func splitImage(){
        
        let tempImage = bC?.cgImage
        var fractionsCount = 0
        
        while(fractionsCount < levels){
            
            let f1 = tempImage!.cropping(to: CGRect(x: 0, y: 0, width: (bC?.size.width)!, height: ( ((bC?.size.height)! / CGFloat(levels)) + (CGFloat(fractionsCount) * (bC?.size.height)! / CGFloat(levels)) )))
            let fractIm1 = UIImage(cgImage: f1!)
            let bcP1Rect = CGRect(x:(self.view.bounds.size.width / 4), y:(self.view.bounds.size.height / 3), width:(fractIm1.size.width), height: (fractIm1.size.height))
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
