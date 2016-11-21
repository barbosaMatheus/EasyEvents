//
//  BabyShowerViewController.swift
//  EasyEvents
//
//  Created by Cole Thornton on 11/11/16.
//  Copyright © 2016 Oklahoma State University. All rights reserved.
//

import UIKit

class BabyShowerViewController: UIViewController {

    let bS = UIImage(named: "BabyShowerColor.png")
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
        self.view.backgroundColor = UIColor( patternImage: UIImage( named: "celebration.jpeg" )! )
        
        //EDIT THIS TO CHANGE THE PERCENT AND DATE LABELS WHEN SEGUEING IN
        completion = 27.0
        PercentLabel.text = "\(completion)%"
        let format = DateFormatter()
        format.dateFormat = "MM/dd/yyyy"
        let thisDate = format.string(from: date)
        DateLabel.text = thisDate
        
        //Draws greyed out version of the briefcase, meaning no progress made yet
        let babyShowerRect = CGRect(x: (self.view.bounds.size.width / 5), y: (self.view.bounds.size.height / 3), width: (bS?.size.width)!, height: (bS?.size.height)!)
        let babyShowerImage = UIView.init(frame: babyShowerRect)
        babyShowerImage.backgroundColor = UIColor(patternImage: UIImage(named:"BabyShowerGray.png")!)
        babyShowerImage.alpha = 0.4
        view.addSubview(babyShowerImage)
        
        splitImage()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func splitImage(){
        
        let tempImage = bS?.cgImage
        var fractionsCount = 0
        
        while(fractionsCount < levels){
            
            let f1 = tempImage!.cropping(to: CGRect(x: 0, y: 0, width: (bS?.size.width)!, height: ( ((bS?.size.height)! / CGFloat(levels)) + (CGFloat(fractionsCount) * (bS?.size.height)! / CGFloat(levels)) )))
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
