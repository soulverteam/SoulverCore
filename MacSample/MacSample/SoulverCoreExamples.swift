//
//  Examples.swift
//  MacSample
//
//  Created by Zac Cohan on 18/2/20.
//  Copyright © 2020 Zac Cohan. All rights reserved.
//

import Foundation
import SoulverCore

/// For dynamic place geocoding
import CoreLocation

class SoulverCoreExamples {
    
    class func runAllExamples() {

        // Single line examples
        SoulverCoreExamples().runningSimpleCalculation()
        SoulverCoreExamples().checkingTheTypeOfAResult()
        SoulverCoreExamples().settingVariables()
        SoulverCoreExamples().gettingARawAnswerWithoutFormatting()
        SoulverCoreExamples().showingAnAnswerTo2dp()
        SoulverCoreExamples().enablingAutomaticResultConversion()
        SoulverCoreExamples().makingAnEquivalenceCustomUnit()
        SoulverCoreExamples().makingAGenericCustomUnit()
        SoulverCoreExamples().usingAEuropeanLocale()
        SoulverCoreExamples().customizingHowAmbiguousExpressionsAreHandled()
        SoulverCoreExamples().findingADate()
        SoulverCoreExamples().findingADateInterval()
        SoulverCoreExamples().gettingMetadataAboutAnExpression()
        SoulverCoreExamples().drillingDownIntoTheComponentsOfAnExpression()
        SoulverCoreExamples().convertingAResultIntoOtherForms()

        // Custom functions
        SoulverCoreExamples().basicCustomFunction()
        SoulverCoreExamples().valueFromWebFetchingCustomFunction()
        
        // Currency rates
        SoulverCoreExamples().liveCurrencyRatesExample()
        SoulverCoreExamples().customCurrencyRateProviderExample()
        
        // Dynamic places & distance functions
        SoulverCoreExamples().timeInDynamicallyFetchedPlaceExample()
        SoulverCoreExamples().distanceBetweenPlacesExample()

        // Multi-line examples
        SoulverCoreExamples().simpleMultiLineCalculation()
        SoulverCoreExamples().calculatingAQuickTotal()
        SoulverCoreExamples().usingLineReferences()
        
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
        
        let notationPreferences = NotationPreferences(notationStyle: .off, upperNotationThreshold: .trillion)
        
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
    
    func enablingAutomaticResultConversion() {
        
        let calculator = Calculator(customization: .standard)
        
        var formattingPreferences = FormattingPreferences()
        
        /// Automatically perform a common conversion for a single unit expression, like Spotlight
        
        formattingPreferences.resultConversionBehavior = .automatic
        calculator.formattingPreferences = formattingPreferences
        
        let result = calculator.calculate("28 C") /// degrees celsius
        
        print(result.stringValue) // automatically converted to 82.4 °F

    }
    
    
    func makingAnEquivalenceCustomUnit() {
        
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
    
    func makingAGenericCustomUnit() {
        
        // Edit the engine customization to add new units
        var customization: EngineCustomization = .standard
        
        customization.customUnits = [
            CustomUnit(name: "flops", definition: 1.0, equivalentUnit: .undefined),
        ]
        
        let calculator = Calculator(customization: customization)
        
        let result = calculator.calculate("45 flops/s for 8 minutes")
        
        print(result.stringValue) // 21,600 fops
        
    }
    
    func usingAEuropeanLocale() {
        
        // Provide a European locale where the decimal character is set to a ","
        
        let europeanLocale = Locale(identifier: "en_DE")
        
        let customization = EngineCustomization.standard.convertTo(locale: europeanLocale)
        
        let calculator = Calculator(customization: customization)
        
        let result = calculator.calculate("1,2 + 3,4")
        
        print(result.stringValue) // 4,6
        
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
        
        if result.isEmptyResult {
            print("Result is empty")
        }
                
    }
    
    
    func findingADate() {
        
        if let date = "11/03".dateValue {
            print("Found a date: \(DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none))")
        }
        
    }
    
    
    func findingADateInterval() {
        
        if let dateInterval = "See Jude on Monday 3pm - 4:30pm".dateIntervalValue {
            print("Found a date interval: \(DateIntervalFormatter().string(from: dateInterval)!)")
        }
        
    }
    

    func gettingMetadataAboutAnExpression() {
        
        let calculator = Calculator(customization: .standard)
        
        let currencyConversion = "10 USD in CAD"
        
        let expressionMetadata = calculator.calculate(currencyConversion).parsedExpression!.metadata
        
        /// Quickly extract data from the expression that matches a particular form
        switch expressionMetadata.form {
        case .conversion(let fromUnit, let toUnit, let quantity):
            print("Convert \(quantity) from \(fromUnit.symbol) to \(toUnit.symbol)")
            break
            
    /// There are many other expression 'forms' available via this property, this is just an example of the conversion form
            
        default:
            break
        }
        
    }


    func drillingDownIntoTheComponentsOfAnExpression() {
        
        /* This approach is more low level than the function above, and gives you specific information about each token parsed */
        
        let calculator = Calculator(customization: .standard)
        
        let currencyConversion = "10 USD in CAD"
        let currencyConversionTokens = calculator.calculate(currencyConversion).parsedExpression!

        /* The first line contains a unit expression, whitspace and a date */
        print(currencyConversionTokens[0].type) // unit expression
        print(currencyConversionTokens[1].type) // whitespace
        print(currencyConversionTokens[2].type) // converter
        
        let dateCalculation = "01/02/20 + 3 weeks"
        
        /* Let's examine the second line: 01/02/20 + 3 weeks */
        let dateCalculationTokens = calculator.calculate(dateCalculation).parsedExpression!

        /* The second line contains a datestamp, whitespace, an operator, another whitspace and a timespan */
        
        print(dateCalculationTokens[0].type) // datestamp
        print(dateCalculationTokens[2].type) // operator
        print(dateCalculationTokens[4].type) // unit expression
        
        /* Let's look more closely at the operator in the second line */
        let operatorToken = dateCalculationTokens[2]
        
        print(operatorToken.stringValue) // '+'
        print(operatorToken.range) // NSMakeRange(9, 1)
        print(operatorToken.subType) // additionOperator
        
    }
    

    func convertingAResultIntoOtherForms() {
        
        let calculator = Calculator(customization: .standard)
        let decimalResult = calculator.calculate("456")
        
        let alternativeDecimalFormats = AlternativeResultGenerator(customization: .standard).alternativeResultsFor(result: decimalResult)
        
        for alternativeDecimalForm in alternativeDecimalFormats {
            print(alternativeDecimalForm.format.title.capitalized + ": \(alternativeDecimalForm.calculationResult.stringValue)")
        }
        
        let timeResult = calculator.calculate("31 hours 20 minutes")
        
        let alternativeTimeFormats = AlternativeResultGenerator(customization: .standard).alternativeResultsFor(result: timeResult)
        
        for alternativeTimeFormats in alternativeTimeFormats {
            print(alternativeTimeFormats.format.title.capitalized + ": \(alternativeTimeFormats.calculationResult.stringValue)")
        }
        
        let dateResult = calculator.calculate("tomorrow 9am")
        
        let alternativeDateFormats = AlternativeResultGenerator(customization: .standard).alternativeResultsFor(result: dateResult)
        
        for alternativeDateFormat in alternativeDateFormats {
            print(alternativeDateFormat.format.title.capitalized + ": \(alternativeDateFormat.calculationResult.stringValue)")
        }
        
    }
    
    
    // MARK: -  Custom Functions
    
    func basicCustomFunction() {
        
        var customization: EngineCustomization = .standard
        
        /// A prototype expression is an example of what the user will type to invoke your function
        /// - For example, the following function will trigger for any phrase with the form 'number before x', where x is some number
        
        customization.customFunctions = [CustomFunction(prototypeExpression: "number before 9", handler: { parameters in
            
            guard let parameterDecimalValue = parameters[0].decimalValue else {
                return EvaluationResult.none
            }
            
            return .decimal(parameterDecimalValue - 1.0)
            
        })]
        
        let calculator = Calculator(customization: customization)
        let result = calculator.calculate("number before 35")
        
        print(result.stringValue) // prints '34'

        
    }
    
    func valueFromWebFetchingCustomFunction() {
        
        /// Declare a new function for the phrase 'apple stock price', and return '.pending' from its synchronous handler
        
        var webFetchingCustomFunction = CustomFunction(prototypeExpression: "apple stock price", handler: { parameters in
            
            /* It's **essential** to return a .pending result from the synchronous handler because we support synchronous evaluation in SoulverCore */
            
            return .pending
        })
                                                   
        /// Now implement the function's background handler to fetch a value from the internet asynchronously
        
        webFetchingCustomFunction.backgroundHandler = { parameters in
            
            /// A web API that provides Apple's stock price as a json feed
            let url = URL(string: "https://eodhistoricaldata.com/api/real-time/AAPL.US?fmt=json&api_token=2hd961i6758jo0.84621073")!
                        
            /// fetch the data asynchronously
            let (data, _) = try await URLSession.shared.data(from: url)
            
            /// Convert the response into json
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
              // appropriate error handling
                return .failed
            }
            
            /// Pull out the close price and convert to decimal (the number type used by SoulverCore)
            if let closePrice = json["close"] as? Double {
                return .decimal(Decimal(closePrice))
            }

            return .failed
        }
        
        /// Add the custom function to a calculator via an EngineCustomization
        var customization: EngineCustomization = .standard
        customization.customFunctions = [webFetchingCustomFunction]
        
        let calculator = Calculator(customization: customization)

        /// Invoke calculation asynchronously
        Task {
            let result = await calculator.calculateInBackground("apple stock price")
            print(result.stringValue) // prints '34'
        }

    }
    
        
    // MARK: -  Update Currency Rates
    
    func liveCurrencyRatesExample() {

        /// This is a currency rate provider that fetches 33 popular fiat currencies from the European Central Bank, no API key required
        let ecbCurrencyRateProvider = ECBCurrencyRateProvider()
        
        /// Create a customization with this rate provider
        var customizationWithLiveCurrencyRates = EngineCustomization.standard
        customizationWithLiveCurrencyRates.currencyRateProvider = ecbCurrencyRateProvider
        
        /// Create a calculator that uses this customization
        let calculator = Calculator(customization: customizationWithLiveCurrencyRates)
        
        Task {
            let success = await ecbCurrencyRateProvider.updateRates()
            
            if success {
                // The standard customization will now have access to the latest currency rates
                let result = calculator.calculate("10 USD in EUR")
                print(result.stringValue)
            }
            
        }
                
    }

    /// To support live rates for currencies, create a class that conforms to CurrencyRateProvider
    /// - There is a single method to implement that returns the rate for a given currency code (in terms of how much 1.0 USD buys of the requested currency)
    /// - For example 1 USD buys roughly $1.39 AUD, so the return value for "AUD" should be 1.39
    /// - Rates are requested from rate providers when an expression is parsed. This is so that you don't need to recreate your LineCollection or Calculator objects with new EngineCustomizations anytime your currency rate data source is updated
    
    class MockBitcoinRateProvider: CurrencyRateProvider {
        
        /// This method is called on demand when a given currency code is used in an expression
        /// - This example returns a hard-coded number, but for production apps you should download and cache accurate rates for the currency codes you support
        /// https://currencylayer.com and https://openexchangerates.org are two good sources for accurate currency rates with easy to use APIs

        func rateFor(request: CurrencyRateRequest) -> Decimal? {
            
            if request.currencyCode == "BTC" {
                /// We need to return the amount of BTC that 1 USD can purchase
                /// - If your data source returns a number in terms of the amount 1 BTC can purchase of USD, remember to take the reciprocal before returning the value: i.e 1 / $29,835.31 = 0.0000335173
                return 0.0000335173
            }
            
            /// SoulverCore will ignore the currency in the expression if you return nil from this method
            return nil
        

        }
                
    }
    
    func customCurrencyRateProviderExample() {

        /// Create a customization that uses your custom rate provider
        var customizationWithBitcoinRate = EngineCustomization.standard
        customizationWithBitcoinRate.currencyRateProvider = MockBitcoinRateProvider()
        
        /// Create a calculator that uses this customization
        let calculator = Calculator(customization: customizationWithBitcoinRate)
        
        /// Rates will now be fetched from the provider when necessary
        let result = calculator.calculate("1 BTC in USD")
        print(result.stringValue) /// ₿29,835.31
                
    }
    
    // MARK: - Dynamic Places
    
    class ExamplePlaceDataProvider: SoulverCore.PlaceDataProvider {
        
        func placeDataFor(request: String) async throws -> SoulverCore.PlaceData? {

            let geocoder = CLGeocoder()
            let placemarks = try await geocoder.geocodeAddressString(request)
            
            guard let placemark = placemarks.first else {
                return nil
            }
            
            guard let timezone = placemark.timeZone else {
                print("No timezone in this placemark")
                return nil
            }
            
            let name = placemark.name ?? request
            
            if let location = placemark.location {
                return SoulverCore.PlaceData(name: name, timeZone: timezone, coordinates: PlaceData.Coordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
            }
            
            return nil
        }
        
        func distanceBetween(location1: SoulverCore.PlaceData.Coordinates, location2: SoulverCore.PlaceData.Coordinates) -> SoulverCore.UnitExpression? {
            
            let location1 = CLLocation(latitude: location1.latitude, longitude: location1.longitude)
            let location2 = CLLocation(latitude: location2.latitude, longitude: location2.longitude)
            
            let distanceInMeters = location1.distance(from: location2)
                                    
            return UnitExpression.with(unit: .kilometers, and: Decimal(distanceInMeters) / 1000.0)
        }
        
    }
    
    func timeInDynamicallyFetchedPlaceExample() {
        
        /// Create a customization that uses your custom rate provider
        var customizationWithPlaceProvider = EngineCustomization.standard
        customizationWithPlaceProvider.placeDataProvider = ExamplePlaceDataProvider()
        
        /// You must explicitly enable dynamic place queries on your engine customization's feature flags
        customizationWithPlaceProvider.featureFlags.dynamicPlaceQueries = true
        
        /// Create a calculator that uses this customization
        let calculator = Calculator(customization: customizationWithPlaceProvider)
        
        Task {
            /// this calculator now supports calculations with dynamically fetched places
            /// use the async/await calculateInBackground function on `Calculator` (as dynamic place resolving is done off the main thread)
            let result = await calculator.calculateInBackground("time in Ubud")
            print("time in Ubud is \(result.stringValue)")
            
        }
    }
    
    func distanceBetweenPlacesExample() {
        
        /// Create a customization that uses your custom rate provider
        var customizationWithPlaceProvider = EngineCustomization.standard
        customizationWithPlaceProvider.placeDataProvider = ExamplePlaceDataProvider()
        
        /// Create a calculator that uses this customization
        let calculator = Calculator(customization: customizationWithPlaceProvider)
        
        /// this calculator now supports calculations involving calls to CoreLocation
        let result = calculator.calculate("distance between rome and milan")
        print("distance between rome and milan is \(result.stringValue)")
        
    }

    // MARK: -  Multi-Line Calculations
    
    func simpleMultiLineCalculation() {
        
        let multiLineText =
        """
        a = 10
        b = 20
        c = a + b
        """
        
        // A 'line collection' manages a list of lines. A line collection makes its own calculator, but you can still provide a customization to be used
        
        let lineCollection = LineCollection(multiLineText:
            multiLineText, customization: .soulver)
        
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
            multiLineText, customization: .soulver)
        
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
            multiLineText, customization: .soulver)
        
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

    
}
