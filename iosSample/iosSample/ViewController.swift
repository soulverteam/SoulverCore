//
//  ViewController.swift
//  iosSample
//
//  Created by Zac Cohan on 8/2/20.
//  Copyright © 2020 Zac Cohan. All rights reserved.
//

import UIKit
import SoulverCore

class ViewController: UIViewController {
    
    let calculator = Calculator(customization: .standard)
    
    @IBOutlet weak var outputField: UILabel!
    @IBOutlet weak var expressionField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calculateAnswer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                self.expressionField.becomeFirstResponder()
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        self.calculateAnswer()
        
    }
    
    func calculateAnswer() {
        
        let result = calculator.calculate(self.expressionField.text ?? "")
        
        self.outputField.text = result.stringValue
        
    }
}

