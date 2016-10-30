//
//  EventChecklistViewController.swift
//  EasyEvents
//
//  Created by Asaph Matheus Moraes Barbosa on 10/24/16.
//  Copyright © 2016 Oklahoma State University. All rights reserved.
//

import UIKit

class EventChecklistViewController: UIViewController {
    
    //event name
    var event: String = ""
    
    @IBOutlet weak var curr_image: UIButton!

    //button indicates wether a task is done
    @IBOutlet weak var check_button: UIButton!
    
    //step description label
    @IBOutlet weak var step_label: UILabel!
    
    //array holding all steps for any event
    let all_steps: [(pic:UIImage,name:String)] = [(#imageLiteral(resourceName: "date.png"),"Event Date"),(#imageLiteral(resourceName: "budget.png"),"Budget"),(#imageLiteral(resourceName: "catering.png"),"Catering"),(#imageLiteral(resourceName: "details.png"),"Details & Decorations"),(#imageLiteral(resourceName: "favors.png"),"Party Favors"),(#imageLiteral(resourceName: "flowers.png"),"Flowers"),(#imageLiteral(resourceName: "guests.png"),"Guestlist"),(#imageLiteral(resourceName: "invite.png"),"Invitations"),(#imageLiteral(resourceName: "license.png"),"Marriage License & Officiant"),(#imageLiteral(resourceName: "music.png"),"Music/Entertainment"),(#imageLiteral(resourceName: "party.png"),"Reception/Party"),(#imageLiteral(resourceName: "photographer.png"),"Photographer"),(#imageLiteral(resourceName: "registration.png"),"Registration"),(#imageLiteral(resourceName: "theme.png"),"Theme"),(#imageLiteral(resourceName: "ty_cards.png"),"\'Thank You\' Cards"),(#imageLiteral(resourceName: "venue.png"),"Venue/Location"),(#imageLiteral(resourceName: "wardrobe.png"),"Wardrobe")]
    //array holding the steps needed for the current type of event
    var current_steps: [(pic:UIImage,name:String)] = []
    //aray index for the current step being displayed
    var step_index: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor( patternImage: UIImage( named: "MAD_EE_Background.png" )! )
        self.navigationItem.title = "\(event) Checklist"
        // Do any additional setup after loading the view.
        
        check_button.setImage( #imageLiteral(resourceName: "checkmark.png"), for: UIControlState.normal )
        pick_icons( event: "wedding" )
        display( )
    }
    
    func pick_icons( event: String ) {
        if event == "wedding" {
            current_steps = all_steps
        }
        else {
            current_steps = all_steps
        }
    }
    
    @IBAction func toggle(_ sender: AnyObject) {
        if check_button.currentImage == #imageLiteral(resourceName: "checkmark.png") {
            check_button.setImage( #imageLiteral(resourceName: "red_x.png"), for: UIControlState.normal )
        }
        else {
            check_button.setImage( #imageLiteral(resourceName: "checkmark.png"), for: UIControlState.normal )
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func display( ) {
        curr_image.setImage( current_steps[step_index].pic, for: UIControlState.normal )
        step_label.text = current_steps[step_index].name
    }
    
    @IBAction func increment(_ sender: AnyObject) {
        if step_index == ( current_steps.count-1 ) {
            step_index = 0
        }
        else {
            step_index += 1
        }
        display( )
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
