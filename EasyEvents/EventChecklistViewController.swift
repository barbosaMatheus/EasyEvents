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
    var event_type: String = ""
    
    //button showing current icon
    @IBOutlet weak var curr_image: UIButton!

    //button indicates wether a task is done
    @IBOutlet weak var check_button: UIButton!
    
    //step description label
    @IBOutlet weak var step_label: UILabel!
    
    //db information
    var dbUsername: String = ""
    var dbPassword: String = ""
    var event_id: Int = 1 //database id attribute for the current event
    
    //array holding all steps for any event
    let all_steps: [(pic:UIImage,name:String,done:Bool)] = [(#imageLiteral(resourceName: "date.png"),"Event Date",true),(#imageLiteral(resourceName: "budget.png"),"Budget",false),(#imageLiteral(resourceName: "catering.png"),"Catering",false),(#imageLiteral(resourceName: "details.png"),"Details & Decorations",false),(#imageLiteral(resourceName: "party_favor.png"),"Party Favors",false),(#imageLiteral(resourceName: "flowers.png"),"Flowers",false),(#imageLiteral(resourceName: "guests.png"),"Guestlist",false),(#imageLiteral(resourceName: "invite.png"),"Invitations",false),(#imageLiteral(resourceName: "license.png"),"Marriage License & Officiant",false),(#imageLiteral(resourceName: "music.png"),"Music/Entertainment",false),(#imageLiteral(resourceName: "party.png"),"Reception/Party",false),(#imageLiteral(resourceName: "photographer.png"),"Photographer",false),(#imageLiteral(resourceName: "registration.png"),"Registration",false),(#imageLiteral(resourceName: "theme.png"),"Theme",false),(#imageLiteral(resourceName: "ty_cards.png"),"\'Thank You\' Cards",false),(#imageLiteral(resourceName: "venue.png"),"Venue/Location",false),(#imageLiteral(resourceName: "wardrobe.png"),"Wardrobe",false)]
    
    //current event object loaded
    //var current_event: Event = Event.init( _title: "", _date: "", type: "" )

    //array holding the steps needed for the current type of event
    var current_steps: [(pic:UIImage,name:String,done:Bool)] = []
    
    //aray index for the current step being displayed
    var step_index: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor( patternImage: UIImage( named: "MAD_EE_Background.png" )! )
        self.navigationItem.title = "\(event) Checklist"
        //self.event_type = "Wedding"
        // Do any additional setup after loading the view.
        
        check_button.setImage( #imageLiteral(resourceName: "checkmark.png"), for: UIControlState.normal )
        //current_event = Event.init( _title: event, _date: "00/00/00", type: "Wedding" ) //TODO: this is temp and hardcoded*/
        
        //grab stuff from the database
        let url = URL( string:"https://cs.okstate.edu/~asaph/steps.php?u=\(self.dbUsername)&p=\(self.dbPassword)&i=\(self.event_id)" )!
        let config = URLSessionConfiguration.default
        let session = URLSession( configuration: config )
        
        let task = session.dataTask( with: url, completionHandler: { (data, response, error) in
            guard error == nil else {
                print("Error in session call: \(error)")
                return
            }
            
            guard let result = data else {
                print( "No data\n" )
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject( with: result, options: .allowFragments ) as? [[String: AnyObject]]
                
                //loop through steps
                for step in json! {
                    //get attributes from json
                    guard let i = step["step_index"] as? String else {
                        return
                    }
                    let index = Int( i )
                    
                    guard let c = step["completed"] as? String else {
                        return
                    }
                    let completed = c == "1" ? true : false
                    
                    //make the steps and put into array
                    var this_step: (pic:UIImage,name:String,done:Bool) = self.all_steps[index!]
                    this_step.done = completed
                    self.current_steps.append( this_step )
                }
                
                DispatchQueue.main.async {
                    self.display( )
                }
                
            } catch {
                print( "Error serializing JSON Data: \(error)" )
            }
        } )
        
        task.resume( )
    }
    
    @IBAction func toggle(_ sender: AnyObject) {
        if check_button.currentImage == #imageLiteral(resourceName: "red_x.png") { //if red x
            check_button.setImage( #imageLiteral(resourceName: "checkmark.png"), for: UIControlState.normal ) //toggle image
            current_steps[step_index].done = true //toggle flag in event obj
        }
        else {//if checkmark
            check_button.setImage( #imageLiteral(resourceName: "red_x.png"), for: UIControlState.normal )
            current_steps[step_index].done = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //display the current step status to the screen
    func display( ) {
        //change center image accordingly
        curr_image.setImage( current_steps[step_index].pic, for: UIControlState.normal )
        
        //change label accordingly
        step_label.text = current_steps[step_index].name
        
        //choose red x or checkmark and change bottom image accordingly
        let img = current_steps[step_index].done == true ? #imageLiteral(resourceName: "checkmark.png") : #imageLiteral(resourceName: "red_x.png")
        check_button.setImage( img, for: UIControlState.normal )
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
