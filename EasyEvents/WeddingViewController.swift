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
    let levels = 16
    var levelCount = 0
    var imageFractions = [UIView]()
    
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var PercentLabel: UILabel!
    var date: String = ""
    
    //Matheus edit:
    var completion : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor( patternImage: UIImage( named: "celebration.jpeg" )! )
        
        PercentLabel.text = "\(completion)% completed"
        DateLabel.text = date
        levelCount = Int( ( completion/100.0 )*Double( levels ) ) - 1
        
        //Draws greyed out version of the wedding cake, meaning no progress made yet
        let cakeGreyRect = CGRect(x: (self.view.bounds.size.width / 16), y: (self.view.bounds.size.height / 10), width: (wC?.size.width)!, height: (wC?.size.height)!)
        let cakeGrey = UIView.init(frame: cakeGreyRect)
        cakeGrey.backgroundColor = UIColor(patternImage: UIImage(named:"WeddingCake_Gray.png")!)
        cakeGrey.alpha = 0.4
        view.addSubview(cakeGrey)
        splitImage()
        view.addSubview( imageFractions[levelCount] )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func splitImage(){
        
        let tempImage = wC?.cgImage
        var fractionsCount = 0
        
        while(fractionsCount < levels){
            
            let f1 = tempImage!.cropping(to: CGRect(x: 0, y: 0, width: (wC?.size.width)!, height: ( ((wC?.size.height)! / CGFloat(levels)) + (CGFloat(fractionsCount) * (wC?.size.height)! / CGFloat(levels)) )))
            let fractIm1 = UIImage(cgImage: f1!)
            let cP1Rect = CGRect(x:(self.view.bounds.size.width / 16), y:(self.view.bounds.size.height / 10), width:(fractIm1.size.width), height: (fractIm1.size.height))
            let cakePart = UIView.init(frame: cP1Rect)
            cakePart.backgroundColor = UIColor(patternImage: fractIm1)
            imageFractions.append(cakePart)
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
