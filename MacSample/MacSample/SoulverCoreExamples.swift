//
//  Examples.swift
//  MacSample
//
//  Created by Zac Cohan on 18/2/20.
//  Copyright © 2020 Zac Cohan. All rights reserved.
//

import Foundation
import SoulverCore

class SoulverCoreExamples {
    
    class func runAllExamples() {

        // Single line examples
        SoulverCoreExamples().runningSimpleCalculation()
        SoulverCoreExamples().checkingTheTypeOfAResult()
        SoulverCoreExamples().settingVariables()
        SoulverCoreExamples().gettingARawAnswerWithoutFormatting()
        SoulverCoreExamples().showingAnAnswerTo2dp()
        SoulverCoreExamples().creatingACustomUnit()
        SoulverCoreExamples().usingAEuropeanLocale()
        
        // Multi-line examples
        SoulverCoreExamples().simpleMultiLineCalculation()
        SoulverCoreExamples().calculatingAQuickTotal()
        SoulverCoreExamples().usingLineReferences()

        // Currency rates
        SoulverCoreExamples().updateCurrencyRatesExample()

    }
    
    
    // MARK: -  Single Line Calculations
    
    func runningSimpleCalculation() {
        
        // Step 1: Create a calculator
        let calculator = Calculator(customization: .standard)
        
        // Step 2: Give it a raw expression to be evaluated
        let result = calculator.calculate("123 + 456")
        
        // Step 3: Print the result's stringValue
        print(result.stringValue) // 579
        
    }
    
    func checkingTheTypeOfAResult() {
        
        let calculator = Calculator(customization: .standard)
        let result = calculator.calculate("10 km in m")
        
        switch result.evaluationResult {
        case .unitExpression(let unitExpression):
            print("The result is a unit expression: \(unitExpression)") // 10,000 m
        default:
            print("The result is not a unit expression")
        }
        
    }
    
    
    func settingVariables() {
        
        let calculator = Calculator(customization: .standard)
        
        // Create a variable list, assigning values to names
        let variableList = VariableList(variables:
            [
                Variable(name: "a", value: "123"),
                Variable(name: "b", value: "456"),
            ]
        )        
        
        let result = calculator.calculate("a + b", with: variableList)
        
        print(result.stringValue) // 579
        
    }
    
    func gettingARawAnswerWithoutFormatting() {
        
        let calculator = Calculator(customization: .standard)
        
        // Set the desired formatting preferences
        var formattingPreferences = FormattingPreferences()
        
        let notationPreferences = NotationPreferences(notationStyle: .off, upperNotationThreshold: .quadrillion, lowerNotationThreshold: .pico)
        
        formattingPreferences.notationPreferences = notationPreferences
        formattingPreferences.thousandsSeparatorDisabled = true
        calculator.formattingPreferences = formattingPreferences
        
        let result = calculator.calculate("10M") // 10 million
        
        print(result.stringValue) // 10000000
        
    }
    
    
    func showingAnAnswerTo2dp() {
        
        let calculator = Calculator(customization: .standard)
        
        // Set the desired formatting preferences
        var formattingPreferences = FormattingPreferences()
        formattingPreferences.dp = 2
        calculator.formattingPreferences = formattingPreferences
        
        let result = calculator.calculate("π") // pi
        
        print(result.stringValue) // 3.14
        
    }
    
    
    func creatingACustomUnit() {
        
        // Edit the engine customization to add new units
        var customization: EngineCustomization = .standard
        
        customization.customUnits = [
            CustomUnit(name: "parrots", definition: 15, equivalentUnit: .centimeters),
            CustomUnit(name: "python", definition: 570, equivalentUnit: .centimeters)
        ]
        
        let calculator = Calculator(customization: customization)
        
        let result = calculator.calculate("1 python in parrots")
        
        print(result.stringValue) // 38 parrots
        
    }
    
    func usingAEuropeanLocale() {
        
        // Provide a European locale where the decimal character is set to a ","
        
        let europeanLocale = Locale(identifier: "en_DE")
        let customization = EngineCustomization.standard.convertTo(locale: europeanLocale)
        
        let calculator = Calculator(customization: customization)
        
        let result = calculator.calculate("1,2 + 3,4")
        
        print(result.stringValue) // 4,6
        
    }
    
    
    
    // MARK: -  Multi-Line Calculations
    
    func simpleMultiLineCalculation() {
        
        let multiLineText =
        """
        a = 10
        b = 20
        c = a + b
        """
        
        // A 'line collection' manages a list of lines. A line collectio makes its own calculator, but you can still provide a customization to be used
        
        let lineCollection = LineCollection(multiLineText:
            multiLineText, customization: .standard)
        
        // Instruct the line collection to calculate the result of each line (synchronously)
        lineCollection.evaluateAll()
        
        // Use subscripts to get access to particular lines' results
        let result = lineCollection[2].result
        
        print(result!.stringValue) // 30
        
    }
    
    func calculatingAQuickTotal() {
        
        let multiLineText =
        """
        10
        20
        30
        """
        
        // A 'line collection' manages a list of lines. A line collection makes its own calculator, but you can still provide a customization to be used
        
        let lineCollection = LineCollection(multiLineText:
            multiLineText, customization: .standard)
        
        // Instruct the line collection to calculate the result of each line (synchronously)
        lineCollection.evaluateAll()
        
        // Use subscripts to get access to particular lines' results
        let result = lineCollection.quickSum
        
        print(result!.stringValue) // 60
        
    }
    
    
    func usingLineReferences() {
        
        let multiLineText =
        """
        10
        20
        """
        
        let lineCollection = LineCollection(multiLineText:
            multiLineText, customization: .standard)
        
        // A line collection can make a reference for any of its lines. You can use the reference in expressions downstream
        
        let referenceToFirstLine = lineCollection.makeReferenceForLineAt(lineIndex: 0)
        
        let referenceToSecondLine = lineCollection.makeReferenceForLineAt(lineIndex: 1)
        
        lineCollection.addLine("\(referenceToFirstLine) + \(referenceToSecondLine)")
        
        // Instruct the line collection to calculate the result of each line (synchronously)
        lineCollection.evaluateAll()
        
        // Use subscripts to get access to particular lines' results
        let result = lineCollection[2].result
        
        print(result!.stringValue) // 30
        
    }
    
// MARK: -  Update Currency Rates
    
    func updateCurrencyRatesExample() {
        
        CurrencyList.shared.refreshRates { (success) in
            
            if success {
                
                // The standard customization will now have the latest currency rates applied
                let calculator = Calculator(customization: .standard)
                let result = calculator.calculate("10 USD in EUR")
                print(result.stringValue)
                
            }
            
        }
        
    }
    
    
    
}
