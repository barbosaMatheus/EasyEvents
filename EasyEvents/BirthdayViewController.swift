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
    
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var PercentLabel: UILabel!
    var date = Date()
    var completion : Double = 0.0
    
    @IBAction func AddLevelButton(_ sender: UIButton) {
        if(levelCount < levels){
            view.addSubview(imageFractions[levelCount])
            levelCount = levelCount + 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //EDIT THIS TO CHANGE THE PERCENT AND DATE LABELS WHEN SEGUEING IN
        completion = 27.0
        PercentLabel.text = "\(completion)%"
        let format = DateFormatter()
        format.dateFormat = "MM/dd/yyyy"
        let thisDate = format.string(from: date)
        DateLabel.text = thisDate
        
        //Draws greyed out version of the birthday present, meaning no progress made yet
        let presentRect = CGRect(x: (self.view.bounds.size.width / 4), y: (self.view.bounds.size.height / 3), width: (bP?.size.width)!, height: (bP?.size.height)!)
        let present = UIView.init(frame: presentRect)
        present.backgroundColor = UIColor(patternImage: UIImage(named:"BirthdayPresent_Gray.png")!)
        present.alpha = 0.4
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
