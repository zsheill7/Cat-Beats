//
//  MetronomeViewController.swift
//  Metronome-Swift
//
//  Created by Nikolas Gelo on 10/8/14.
//  Copyright (c) 2014 Nikolas Gelo. All rights reserved.
//

import UIKit

import AVFoundation

class MetronomeViewController: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var DJCatButton: UIButton!
    @IBOutlet weak var glassesCatButton: UIButton!
    @IBOutlet weak var hissingCatButton: UIButton!
    @IBOutlet weak var happyCatButton: UIButton!
    
    @IBOutlet weak var tempoTextField: UITextField!
    @IBOutlet weak var tempoStepper: UIStepper!
    
    @IBOutlet weak var playButton: UIButton!

    var metronomeTimer: NSTimer!
    var metronomeSoundURL: NSURL!
    var metronomeIsOn = false
    
    var metronomeSoundPlayer: AVAudioPlayer!
    
    
    var happyCatToggleState = 1
    var DJCatToggleState = 1
    var hissingCatToggleState = 1
    var glassesCatToggleState = 1
    
    let happyCatImage = UIImage(named: "happy")
    let DJCatImage = UIImage(named: "DJ-cat")
    let hissingCatImage = UIImage(named: "hissing")
    let glassesCatImage = UIImage(named: "glasses")
    
    var currentResource:String!
    var currentType:String!
    var tempo: NSTimeInterval = 60 {
        didSet {
            tempoTextField.text = String(format: "%.0f", tempo)
            tempoStepper.value = Double(tempo)
        }
    }
    
    @IBAction func tempoChanged(var tempoStepper: UIStepper) {
        // Save the new tempo.
        tempo = tempoStepper.value
    }
    
    @IBAction func toggleMetronome(var toggleMetronomeButton: UIButton) {
        // If the metronome is currently on, stop the metronome and change
        // the image of the toggle metronome button to the "Play" image and
        // its tint color to green.
        if metronomeIsOn {
            // Mark the metronome as off.
            metronomeIsOn = false
            
            // Stop the metronome.
            metronomeTimer?.invalidate()
            metronomeSoundPlayer.stop()
            
            // Change the toggle metronome button's image to "Play" and tint
            // color to green.
            toggleMetronomeButton.setImage(UIImage(named: "Play"), forState: .Normal)
            toggleMetronomeButton.tintColor = UIColor.greenColor()
            
            // Enable the metronome stepper.
            tempoStepper.enabled = true
            
            // Enable editing the tempo text field.
            tempoTextField.enabled = true
        }
            
        // If the metronome is currently off, start the metronome and change
        // the image of the toggle metronome button to the "Start" image and
        // its tint color to green
        else {
            // Mark the metronome as on.
            metronomeIsOn = true
            
            setSoundPlayer(currentResource, type: currentType)
            
            
            print("\(currentResource), \(currentType)")
            // Start the metronome.
            let metronomeTimeInterval:NSTimeInterval = 60.0 / tempo
            metronomeTimer = NSTimer.scheduledTimerWithTimeInterval(metronomeTimeInterval, target: self, selector: Selector("playMetronomeSound"), userInfo: nil, repeats: true)
            metronomeTimer?.fire()
            
            // Change the toggle metronome button's image to "Stop" and tint
            // color to red.
            toggleMetronomeButton.setImage(UIImage(named: "Stop"), forState: .Normal)
            toggleMetronomeButton.tintColor = UIColor.redColor()
            
            // Disable the metronome stepper.
            tempoStepper.enabled = false
            
            // Hide the keyboard
            tempoTextField.resignFirstResponder()
            
            // Disable editing the tempo text field.
            tempoTextField.enabled = false
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       
        // Hide the keyboard
        tempoTextField.resignFirstResponder()
    }
    
    func playMetronomeSound() {
        let currentTime = CFAbsoluteTimeGetCurrent()
        //print("Play metronome sound @ \(currentTime)")
        
        metronomeSoundPlayer.play()
    }

    // MARK: - UIViewController
    // MARK: Managing the View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir-Black", size: 30)!]

        
        // Set the inital value of the tempo.
        tempo = 120
        self.tempoTextField.delegate = self
        // Initialize the sound player
        setSoundPlayer("metronomeClick", type: "mp3")
        
        playButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
        DJCatButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
        happyCatButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
        glassesCatButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
        hissingCatButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
    }
    
    @IBAction func happyCatPressed(sender: AnyObject) {
        dispatch_async(dispatch_get_main_queue(), {
            if self.happyCatToggleState == 1 {
            self.happyCatButton.highlighted = true
                
                self.setSoundPlayer("KittenMoan", type: "wav")
                
                
                self.happyCatToggleState = 2
                
                self.hissingCatButton.highlighted = false
                self.DJCatButton.highlighted = false
                self.glassesCatButton.highlighted = false
                
                self.hissingCatToggleState = 1
                self.DJCatToggleState = 1
                self.glassesCatToggleState = 1
            } else {
            self.happyCatButton.highlighted = false
                self.happyCatToggleState = 1
                
            }
            
        })
        
        
    }
    
    
    @IBAction func hissingCatPressed(sender: AnyObject) {
        dispatch_async(dispatch_get_main_queue(), {
            if self.hissingCatToggleState == 1 {
                self.hissingCatButton.highlighted = true
                
                self.setSoundPlayer("cat hiss", type: "wav")
                self.hissingCatToggleState = 2
                
                self.happyCatButton.highlighted = false
                self.DJCatButton.highlighted = false
                self.glassesCatButton.highlighted = false
                
                self.happyCatToggleState = 1
                self.DJCatToggleState = 1
                self.glassesCatToggleState = 1
            } else {
                self.hissingCatButton.highlighted = false
                self.hissingCatToggleState = 1
                
            }
            
        })
    }
    @IBAction func DJCatPressed(sender: AnyObject) {
        dispatch_async(dispatch_get_main_queue(), {
            if self.DJCatToggleState == 1 {
                self.DJCatButton.highlighted = true
                
               
                    
                self.setSoundPlayer("Meow_dubstep", type: "wav")
            
                
                self.DJCatToggleState = 2
                
                self.glassesCatButton.highlighted = false
                self.happyCatButton.highlighted = false
                self.hissingCatButton.highlighted = false
                
                self.happyCatToggleState = 1
                self.glassesCatToggleState = 1
                self.hissingCatToggleState = 1
                
            } else {
                self.DJCatButton.highlighted = false
                self.DJCatToggleState = 1
            }
            
        })
    }
    
    @IBAction func glassesCatPressed(sender: AnyObject) {
        dispatch_async(dispatch_get_main_queue(), {
            if self.glassesCatToggleState == 1 {
                self.glassesCatButton.highlighted = true
                
                self.setSoundPlayer("Meow Mix 2", type: "wav")
                
                
                self.glassesCatToggleState = 2
                
                self.happyCatButton.highlighted = false
                self.DJCatButton.highlighted = false
                self.hissingCatButton.highlighted = false
                
                self.happyCatToggleState = 1
                self.DJCatToggleState = 1
                self.hissingCatToggleState = 1

            } else {
                self.glassesCatButton.highlighted = false
                self.glassesCatToggleState = 1
            }
            
        })
    }
    
    @IBAction func defaultSoundPressed(sender: AnyObject) {
        setSoundPlayer("metronomeClick", type: "mp3")
        
        self.glassesCatButton.highlighted = false
        self.happyCatButton.highlighted = false
        self.hissingCatButton.highlighted = false
        self.DJCatButton.highlighted = false
        
        self.happyCatToggleState = 1
        self.glassesCatToggleState = 1
        self.hissingCatToggleState = 1
        self.DJCatToggleState = 1
    }
    func setSoundPlayer(resource: String, type: String) {
        
        
            let metronomeSoundURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(resource, ofType: type)!)
        print("\(currentResource), \(currentType)")
        
        currentResource = resource
        currentType = type
        
        
        if resource == "Meow Mix 2"{
            print("here")
            print(self.tempo)
            if self.tempo > 124 || self.tempo < 119 {
                print("here2")
                self.metronomeSoundPlayer.enableRate = true
                let rate = Float(self.tempo / 123)
                self.metronomeSoundPlayer.rate = rate
                print(self.metronomeSoundPlayer.rate)
            }
        } else if resource == "Meow Mix" {
            let rate = Float(self.tempo / 123)
            
            self.metronomeSoundPlayer.rate = rate
        } else if resource == "Meow_dubstep" || resource == "Meow_dubstep medium" || resource == "Meow_dubstep short" {
            if self.tempo > 130 {
                
                self.currentResource = "Meow_dubstep short"
                self.currentType = "wav"
            } else if self.tempo > 80 {
                self.currentResource = "Meow_dubstep medium"
                self.currentType = "wav"
            } /*else {
                self.currentResource = "Meow_dubstep"
                self.currentType = "wav"
            }*/
        } else if resource == "KittenMoan" || resource == "KittenMoanMedium" || resource == "KittenMoanShort" {
            if self.tempo > 130 {
                
                self.currentResource = "KittenMoanShort"
                self.currentType = "mp3"
            } else if self.tempo > 100 {
                self.currentResource = "KittenMoanMedium"
                self.currentType = "mp3"
            } else {
                self.currentResource = "KittenMoan"
                self.currentType = "wav"
            }
        }
        
        self.metronomeSoundPlayer = try? AVAudioPlayer(contentsOfURL: metronomeSoundURL)
        self.metronomeSoundPlayer.prepareToPlay()
        
        

        
        
    }

   
    // MARK: - UIResponder
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let currentTempo = Double((tempoTextField.text)!)!
        tempo =  currentTempo
         print("hello")
        return true
    }
}

