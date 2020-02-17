//
//  ViewController.swift
//  MacSample
//
//  Created by Zac Cohan on 8/2/20.
//  Copyright © 2020 Zac Cohan. All rights reserved.
//

import Cocoa
import SoulverCore

class ViewController: NSViewController, NSTextFieldDelegate {

    @IBOutlet weak var outputLabel: NSTextField!
    @IBOutlet weak var expressionField: NSTextField!
    
    let calculator = Calculator(customization: .standard)

    func controlTextDidChange(_ obj: Notification) {
        self.calculateAnswer()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        self.calculateAnswer()
    }
    
    func calculateAnswer() {
        
        let result = calculator.calculate(expressionField.stringValue)
        
        self.outputLabel.stringValue = result.stringValue
        
    }

    
}

