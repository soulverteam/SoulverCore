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
        SoulverCoreExamples().disablingBracketComments()
        SoulverCoreExamples().customizingHowAmbiguousExpressionsAreHandled()
        SoulverCoreExamples().findingADate()
        
        // Multi-line examples
        SoulverCoreExamples().simpleMultiLineCalculation()
        SoulverCoreExamples().calculatingAQuickTotal()
        SoulverCoreExamples().usingLineReferences()
        SoulverCoreExamples().drillingDownIntoTheComponentsOfAnExpression()

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
    
    func disablingBracketComments() {
        
        // An engine customization includes a list of feature flags that can be toggled to change calculator behaviour
        
        // SoulverCore has a feature called bracket comments, which instructs the calculator to ignore single numbers in brackets.
        
        // If we want to return to a more traditional evaluation style, we need to set the feature flags property on the customization
        
        var flags = EngineFeatureFlags()
        flags.bracketComments = false
        
        var customization: EngineCustomization = .standard
        customization.featureFlags = flags
        
        let calculator = Calculator(customization: customization)
        let result = calculator.calculate("5 (10)")
        print(result.stringValue) // 50
    }
    
    
    
    func customizingHowAmbiguousExpressionsAreHandled() {
        
        // When faced with an ambiguous expression, like "123 456", SoulverCore will (by default) select the last number as the answer.
        
        // If you prefer to have no answer in ambiguous cases like these, there's a feature flag for that
        
        var flags = EngineFeatureFlags()
        flags.inAmbiguityPreferSomethingToNothing = false
        
        var customization: EngineCustomization = .standard
        customization.featureFlags = flags
        
        let calculator = Calculator(customization: customization)
        let result = calculator.calculate("123 456")
        
        print(result.isEmptyResult) // true
        print(result.stringValue) // empty string
        
    }
    
    
    func findingADate() {
        
        var customization = EngineCustomization.standard
        
        // With this option, SoulverCore will attempt to parse a date from the expression (when ordinarily it might interpret it as plain arithmatic or a unit calculation)
        
        customization.featureFlags.seeksFutureDate = true
        
        let calculator = Calculator(customization: customization)
        
        // 11th of March (or 3rd of November in the US), not 11 divided by 3
        
        if let date = calculator.dateFor("11/03")?.date {
            
            print("Found a date \(DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none))")
            
            
        }
        
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
    
    func drillingDownIntoTheComponentsOfAnExpression() {
        
        let multiLineText =
        """
        10 USD in CAD
        01/02/20 + 3 weeks
        """
                
        let lineCollection = LineCollection(multiLineText:
            multiLineText, customization: .standard)
        
        lineCollection.evaluateAll()
        
        /* Use subscripts to get access to particular lines' 'parsed expression' as a 'token list' */
        
        /* Let's examine the first line: '10 USD in CAD' */
        let firstLineTokens = lineCollection[0].parsedExpression!.tokens

        /* The first line contains a unit expression, whitspace and a date */
        print(firstLineTokens[0].type) // unit expression
        print(firstLineTokens[1].type) // whitespace
        print(firstLineTokens[2].type) // converter
        
        /* Let's examine the second line: 01/02/20 + 3 weeks */
        let secondLineTokens = lineCollection[1].parsedExpression!.tokens

        /* The second line contains a datestamp, whitespace, an operator, another whitspace and a timespan */
        
        print(secondLineTokens[0].type) // datestamp
        print(secondLineTokens[2].type) // operator
        print(secondLineTokens[4].type) // timespan
        
        /* Let's look more closely at the operator in the second line */
        let operatorToken = secondLineTokens[2]
        
        print(operatorToken.stringValue) // '+'
        print(operatorToken.range) // NSMakeRange(9, 1)
        print(operatorToken.subType) // additionOperator
        
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
        
        // Use the .popular default currency set to fetch 33 popular currency rates from the European Central Bank (updated every weekday).
        
        CurrencyList.shared.defaultCurrencySet = .popular
        
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
