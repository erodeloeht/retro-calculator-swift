//
//  ViewController.swift
//  retro-Calculator
//
//  Created by Lisong Xu on 2/17/16.
//  Copyright © 2016 Lisong Xu. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = .Empty
    var result = ""
    
    
    @IBOutlet weak var outputLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // play sound
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
    }
    
    @IBAction func numberPressed(sender: UIButton!) {
        playSound()
        let digit = sender.currentTitle
        
        if digit == "." && runningNumber.rangeOfString(".") != nil {return}
        
        if runningNumber == "" && digit == "." {
            runningNumber = "0"
        }
        runningNumber += digit!


        
        outputLbl.text = runningNumber
        
    }
    


    @IBAction func onDividePressed(sender: UIButton) {
        playSound()
//        if runningNumber != "" {
            processOperation(.Divide)
//        }
    }

    @IBAction func onMultiplyPressed(sender: UIButton) {
        playSound()
//        if runningNumber != "" {
            processOperation(.Multiply)
//        }
    }
    
    @IBAction func onSubtracttPressed(sender: UIButton) {
        playSound()
//        if runningNumber != "" {
            processOperation(.Subtract)
//        }
    }
    
    @IBAction func onAddPressed(sender: UIButton) {
        playSound()
//        if runningNumber != "" {
            processOperation(.Add)
//        }
    }
    
    @IBAction func onEqualPressed(sender: UIButton) {
        playSound()
        processOperation(currentOperation)
    }
    
    @IBAction func clear(sender: UIButton) {
        playSound()
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        currentOperation = .Empty
        result = ""
        outputLbl.text = "0"
        
    }
    


    func processOperation(op: Operation) {
        
        if currentOperation != Operation.Empty {
            
            
            if runningNumber != ""  {
                rightValStr = runningNumber
                runningNumber = ""
            
                if currentOperation == .Multiply {
                    result = String(Double(leftValStr)! * Double(rightValStr)!)
                
                } else if currentOperation == .Divide {
                    result = String(Double(leftValStr)! / Double(rightValStr)!)
                
                
                } else if currentOperation == .Subtract {
                    result = String(Double(leftValStr)! - Double(rightValStr)!)
                
                } else if currentOperation == .Add {
                    result = String(Double(leftValStr)! + Double(rightValStr)!)
                
                }
            
            leftValStr = result
            outputLbl.text = result
            
            
            }
            currentOperation = op
            
            
        } else {
            if runningNumber != "" {
                leftValStr = runningNumber
                runningNumber = ""
                currentOperation = op
            }
        }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
}

