![SoulverCore Icon](SoulverCoreIcon.png)

# What is SoulverCore?

SoulverCore is a math engine that calculates day-to-day mathematical expressions. It comes out of the popular notepad calculator app [Soulver](https://soulver.app), which has been available for the Mac since 2005. 

The design goals of SoulverCore are:
- Sensible defaults for most use-cases (common tasks work out-of-the-box)
- A high level of customizability (non-common tasks are possible, like adding phrase functions & new units)
- Exceptional performance

Additionally, SoulverCore has been designed to have no 3rd party dependencies & work across all Apple platforms.

## Some apps using SoulverCore

- [Lacona](https://lacona.app)
- [Toolbox Pro](https://toolboxpro.app)

## Performance
Most calculations are evaluated by SoulverCore in less than half a millisecond ⚡️! So, while SoulverCore classes are thread-safe, it's so fast that there is typically no need to perform single calculations off the main thread of your application.

## Requirements
- Xcode 14+
- Swift 5.7+
- SoulverCore is distributed as a binary framework (.xcframework) and includes builds for macOS (universal), iOS/iPadOS, and Mac Catalyst.
- The minimum system requirements are macOS 10.15 Catalina & iOS 13 (the first releases to support Swift Concurrency features)

## Installation using the Swift Package Manager (SPM)

Xcode 12 and later lets you integrate SoulverCore into your project using the Swift Package Manager. 

In Xcode, go File > Swift Packages > Add Package Dependency and paste in the URL of this repository (https://github.com/soulverteam/SoulverCore).

## Manual Installation

Drag `SoulverCore.xcframework` into the `Frameworks, Libraries, and Embedded Content` section of the General settings for your Mac or iOS target.

## Getting Started

To calculate the result of a single expression, use a `Calculator` object:

```swift
import SoulverCore

let calculator = Calculator(customization: .standard)
let result = calculator.calculate("123 + 456")
print("The answer is \(result.stringValue)") // prints 579
```

SoulverCore can perform all sorts of calculations, including unit conversions, date & calendar math, rate calculations, percentage phrase functions, time zone conversions, and much more. It also cleverly ignores "meaningless" words:

```swift
calculator.calculate("$10 for lunch + 15% tip") // $11.50
calculator.calculate("65 kg in pounds") // 143.3 lb
calculator.calculate("40 as % of 90") // 44.44%
calculator.calculate("$150 is 25% on what") // $120
calculator.calculate("$25/hour * 14 hours of work") // $350.00
calculator.calculate("January 30 2020 + 3 months 2 weeks 5 days") // May 19, 2020
calculator.calculate("9:35am in New York to Japan") // 10:35 pm
calculator.calculate("$25k over 10 years at 7.5%") // $51,525.79 (compound interest)

```

## Variables

Use a `VariableList` to set values for words or phrases in your expression:

```swift
let variableList = VariableList(variables:
    [
        Variable(name: "a", value: "123"),
        Variable(name: "b", value: "456"),
    ]
)
calculator.calculate("a + b", with: variableList) // 579        
```

## Locale Settings

SoulverCore respects the decimal separator and thousands separator of the system locale. Alternatively, you can convert the standard EngineCustomization to another locale:

```swift

let europeanLocale = Locale(identifier: "en_DE")
let localizedCustomization = EngineCustomization.standard.convertTo(locale: europeanLocale)

let calculator = Calculator(customization: localizedCustomization)

 /// In Germany a comma is used as a decimal separator
calculator.calculate("1,2 + 3,4") // 4,6
```

## Output Formatting

Use a `FormattingPreferences` to customize the way your result is formatted (how many decimal places to include, should the thousands separator be inserted, etc).

```swift
var formattingPreferences = FormattingPreferences()
formattingPreferences.dp = 2 // decimal places
calculator.formattingPreferences = formattingPreferences

calculator.calculate("π") // 3.14
```

## Live Real-World & Crypto-Currency Rates

The `.standard` `EngineCustomization` uses hard-coded rates for 190 real-world & crypto-currencies. You can (and should) provide SoulverCore with up-to-date rates by setting the `currencyRateProvider` on your `EngineCustomization` to an object that conforms to `CurrencyRateProvider`.

SoulverCore includes one `CurrencyRateProvider` you can use to fetch rates from the [European Central Bank](https://www.ecb.europa.eu/stats/eurofxref/) for 33 popular fiat currencies.

```swift
/// This is a currency rate provider that fetches 33 popular fiat currencies from the European Central Bank, no API key required
let ecbCurrencyRateProvider = ECBCurrencyRateProvider()

/// Create a customization with this rate provider
var customizationWithLiveCurrencyRates = EngineCustomization.standard
customizationWithLiveCurrencyRates.currencyRateProvider = ecbCurrencyRateProvider

/// Create a calculator that uses this customization
let calculator = Calculator(customization: customizationWithLiveCurrencyRates)

/// Update to the latest rates...
ecbCurrencyRateProvider.updateRates { success in
    
    if success {
        // The standard customization will now have access to the latest currency rates
        let result = calculator.calculate("10 USD in EUR")
        print(result.stringValue)
    }

}

```
 
You can create your own object that conforms to `CurrencyRateProvider` to provide rates for the currency codes you support. The `CurrencyRateProvider` protocol has a single method that returns the amount of a given currency that 1.0 USD can buy:

```swift
func rateFor(request: CurrencyRateRequest) -> Decimal? {

	let currencyCode = request.currencyCode // EUR, GBP, BTC, etc

	/// - Return an up-to-date rate in the form of how much 1 USD can purchase of the requested currency (i.e 1 USD = x EUR?)
	/// - If your rates are in terms of how much USD the requested currency can purchase (i.e 1 EUR = x USD?), remember to take the inverse by dividing 1 by your rate
            
	return <# Currency Rate #>
}
````

Rates are only requested from a `CurrencyRateProvider` at evaluation-time, so you don't need to recreate or `Calculator` with a new `EngineCustomization` when your currency rate data source is updated. However you must reevaluate your line or expression: the latest rates for any currencies used will be fetched from your provider, if necessary.

## Custom Units

You can add custom units to an `EngineCustomization` object required by the initializer on `Calculator`

```swift

/// A good omakase EngineCustomization (the same used by Soulver.app)
var customization: EngineCustomization = .standard

/// Set an array of custom units defined in terms of an existing unit in SoulverCore
customization.customUnits = [
    CustomUnit(name: "parrots", definition: 15, equivalentUnit: .centimeters),
    CustomUnit(name: "python", definition: 570, equivalentUnit: .centimeters)
]

/// Create a Calculator using this customization
let calculator = Calculator(customization: customization)

/// python and parrots are now recognized as units
calculator.calculate("1 python in parrots") // 38 parrots
```

## Custom Functions

The syntax of a function in SoulverCore is flexible. We support traditional C-style "func(x)" functions, Swift-style "calculate(withParameter: x)" functions, or even natural phrases like "calculate x". 

You can add custom functions objects to the `EngineCustomization` required by the initializer on `Calculator`. Here is an example of a custom function that takes 1 off a given number:

```swift

/// Get the default Engine Customization
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
```

## Localizations
In addition to English, SoulverCore is localized into German, Russian, and simplified Chinese. The additional languages are additive, meaning that, for instance, a German user would be able to use both English & German syntaxes.

## See Also

__Data extraction from strings__

See [SoulverStringParsing](https://github.com/soulverteam/SoulverStringParsing) to learn about how SoulverCore can help you parse data out from strings in a type-safe way. It uses a natural and memorable syntax that's much more user friendly than regex for many tasks.

__Adding calculation capabilities to an NSTextView or UITextView__

See the [SoulverTextKit](https://github.com/soulverteam/SoulverTextKit) project for an example of how to integrate the SoulverCore math engine into a standard macOS or iOS text view.

## Licence

You may use SoulverCore in personal or private projects. Please [email us](mailto:contact@soulver.app) if you wish to use SoulverCore in a publicly available, or commercial project.

We have various options available depending on your user base size, including a free license (with attribution). 
