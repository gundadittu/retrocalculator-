//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Aditya Gunda on 8/1/17.
//  Copyright © 2017 Aditya Gunda. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber: String = ""
    
    enum Operation: String {
        case Divide = "/"
        case Subtract = "-"
        case Add = "+"
        case Multiply = "x"
        case Empty = "Empty"
    }
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    var currentOperation: Operation = Operation.Empty

    @IBOutlet weak var outputLabel: UILabel!
    
    @IBAction func onEqual(_ sender: Any) {
        processOperation(operation: currentOperation)
    }
    
    @IBAction func onAdd(_ sender: Any) {
        let op = Operation.Add
        processOperation(operation: op)
    }
    
    @IBAction func onSubtract(_ sender: Any) {
        let op = Operation.Subtract
        processOperation(operation: op)
    }
    
    @IBAction func onMultiply(_ sender: Any) {
        let op = Operation.Multiply
        processOperation(operation: op)
    }
    
    @IBAction func onDivide(_ sender: Any) {
        let op = Operation.Divide
        processOperation(operation: op)

    }
    
    @IBAction func onClear(_ sender: Any) {
        outputLabel.text = "0"
        leftValStr = ""
        rightValStr = ""
        runningNumber = ""
        currentOperation = Operation.Empty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        outputLabel.text = "0"
        let path = Bundle.main.path(forResource: "btn",ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func numberPressed(_ sender: UIButton!) {
        playSound()
        runningNumber+="\(sender.tag)"
        outputLabel.text = runningNumber
    }
  
    
    func playSound(){
        if btnSound.isPlaying {
            btnSound.stop()
        }
          btnSound.play()
    }
    
    func processOperation(operation: Operation){
        playSound()
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                if currentOperation == Operation.Multiply{
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                    
                } else if currentOperation == Operation.Divide{
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"

                    
                } else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"

                    
                } else if currentOperation == Operation.Add{
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"

                    
                }
                leftValStr = result
                outputLabel.text = result
            }
        } else {
         //first time operator is pressed 
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
            
            
        }
    }
    
        
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

