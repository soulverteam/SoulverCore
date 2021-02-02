<p align="center">
  <img src="SoulverCoreIcon.png" />
</p>

# SoulverCore
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

SoulverCore is a framework that lets you evaluate day-to-day mathematical expressions. It has a very simple API with sensible defaults. It is also quite customizable. You can also access SoulverCore via a [web-based API](https://rapidapi.com/soulver-soulvercloud/api/evaluate-expression).

## Requirements

- Xcode 11+
- Swift 5+

## Supported Platforms

SoulverCore is distributed as a binary framework (.xcframework) and supports macOS (Intel & Apple Silicon), iOS, iPadOS & Catalyst. 

- macOS 10.14.4+
- iOS/iPadOS 12.2+

## Installation

Drag `SoulverCore.xcframework` into the `Frameworks, Libraries, and Embedded Content` section of the General settings for your Mac or iOS target.

## Getting Started

To calculate the result of a single expression, use a `Calculator` object:

```swift
import SoulverCore

let calculator = Calculator(customization: .standard)
let result = calculator.evaluate("123 + 456")
print("The answer is \(result.stringValue)") // prints 579
```

SoulverCore has a lot of features apart from basic arithmetic. These include unit conversions, date & calendar calculations, rate calculations, percentage phrase functions, and time zone conversions. It also cleverly ignores "meaningless" words:

```swift
calculator.evaluate("$10 for lunch + 15% tip") // $11.50
calculator.evaluate("65 kg in pounds") // 154.32 lb
calculator.evaluate("40 as % of 90") // 25%
calculator.evaluate("$150 is 25% on what") // $120
calculator.evaluate("$25/hour * 14 hours of work") // $350.00
calculator.evaluate("January 30 2020 + 3 months 2 weeks 5 days") // 19 May
calculator.evaluate("9:35am in New York to Japan") // 10:35 pm
calculator.evaluate("$25k over 10 years at 7.5%") // $51,525.79 (compound interest)

```

## Features

Explore Soulver's [documentation](https://documentation.soulver.app) for information on all the features in SoulverCore. Or download [Soulver](https://soulver.app/download) itself and play around.

## Variables

Use a `VariableList` to customize variables in your expression:

```swift
let variableList = VariableList(variables:
    [
        Variable(name: "a", value: "123"),
        Variable(name: "b", value: "456"),
    ]
)
calculator.evaluate("a + b", with: variableList) // 579        
```
## Output Formatting

Use a `FormattingPreferences` to customize the formatting of your result.

```swift
var formattingPreferences = FormattingPreferences()
formattingPreferences.dp = 2 // decimal places
calculator.formattingPreferences = formattingPreferences

calculator.calculate("π") // 3.14
```

## Custom Units

You can add custom units to an `EngineCustomization` object.

```swift

var customization: EngineCustomization = .standard

customization.customUnits = [
    CustomUnit(name: "parrots", definition: 15, equivalentUnit: .centimeters),
    CustomUnit(name: "python", definition: 570, equivalentUnit: .centimeters)
]

let calculator = Calculator(customization: customization)
calculator.calculate("1 python in parrots") // 38 parrots
```

## Locale settings

SoulverCore respects the decimal separator and thousands separator of the current locale. Alternatively, convert the standard EngineCustomization to another locale:

```swift

let europeanLocale = Locale(identifier: "en_DE") // In Germany a comma is used as the decimal separator
let localizedCustomization = EngineCustomization.standard.convertTo(locale: europeanLocale)

let calculator = Calculator(customization: localizedCustomization)
calculator.calculate("1,2 + 3,4") // 4,6
```

## Multi-line calculations

Use a `LineCollection` to represent a list of lines to be evaluated. The `LineCollection` creates its own calculator, though you can still pass in your own customization.

```swift

let multiLineText =
"""
a = 10
b = 20
c = a + b
"""
        
let lineCollection = LineCollection(multiLineText:
    multiLineText, customization: .standard)

// Calculate the result of each line (synchronously)
lineCollection.evaluateAll()

// Use subscripts to get access to particular lines' results
let result = lineCollection[2].result // 30
```

## Line References

A line collection manages dependencies between lines. You can also get a "reference" to a line. A reference is a single unicode character, which is a placeholder for the line's answer (which will be substituted in during evaluation).

```swift

let multiLineText =
"""
10
20
"""

let lineCollection = LineCollection(multiLineText:
    multiLineText, customization: .standard)

let referenceToFirstLine = lineCollection.makeReferenceForLineAt(lineIndex: 0)
let referenceToSecondLine = lineCollection.makeReferenceForLineAt(lineIndex: 1)

lineCollection.addLine("\(referenceToFirstLine) + \(referenceToSecondLine)")

// Calculate the result of each line
lineCollection.evaluateAll()

print(lineCollection[2].result!.stringValue) // 30
```

## Currency Rates

The standard customization comes with rates for 170 real-world currencies, that were accurate at the time the framework was last compiled. You can update these currencies to the latest rates by setting valid API key credentials for [CurrencyLayer](https://currencylayer.com) and [Nomics](https://nomics.com) on the shared CurrencyList. Alternatively use the `.popular` default currency set to pull 33 currency rates from the [European Central Bank](https://exchangeratesapi.io), no API key required.

To fetch the latest rates, use SoulverCore's shared `CurrencyList`:

```swift

CurrencyList.shared.defaultCurrencySet = .popular // 33 popular currencies from the ECB, updated every weekday.

CurrencyList.shared.refreshRates { (success) in
	
	if success {  
		// The standard customization will now have the latest currency rates applied		
		let calculator = Calculator(customization: .standard)
		let result = calculator.calculate("10 USD in EUR")  		
	}
	
}

```

## Additional languages

SoulverCore is localized into German, Russian, and simplified Chinese. Support for romance languages is planned for 2021.

## Swift Package Manager Support

Xcode 12 and later lets you integrate SoulverCore into your project using the Swift Package Manager. 

In Xcode, go File > Swift Packages > Add Package Dependency and paste in the URL of this repository (https://github.com/soulverteam/SoulverCore).

## Carthage Support

SoulverCore supports [Carthage](https://github.com/Carthage/Carthage). Add the following binary dependency to your [Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile):

```
binary "https://soulver.app/core/SoulverCore.json"
```

## Apps using SoulverCore

- [Soulver](https://soulver.app) - a popular notepad calculator for macOS
- [Lacona](https://lacona.app) - a powerful natural language assistant/launcher for macOS
- [Toolbox Pro](https://toolboxpro.app) - calculate with Soulver as part of your Siri Shortcuts on iOS

## Licence

You may use SoulverCore in personal/private projects. Please [email us](mailto:contact@soulver.app) if you wish to use SoulverCore in a publicly available or commercial project. We have various options available depending on your needs and userbase size.