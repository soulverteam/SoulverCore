<p align="center">
  <img src="SoulverCoreIcon.png" />
</p>

# What is SoulverCore?

SoulverCore is a math engine that evaluates day-to-day mathematical expressions. SoulverCore comes with sensible defaults and is also extremely customizable, with support for custom variables, units, functions and more.

# Can I rely on SoulverCore for my project?

SoulverCore is the math engine from the popular notepad calculator app [Soulver](https://soulver.app). Soulver has been available on Apple's platforms since 2005.

Soulver uses the **exact same** version of SoulverCore that is available to you here. As such, you can be confident that it will be maintained to support the latest versions of Apple's operating systems & hardware architectures.

Additionally, SoulverCore has been designed to have no 3rd party dependencies. It is written in 100% Swift.

Explore Soulver's [documentation](https://documentation.soulver.app) for information about the kinds of expressions supported by SoulverCore. And download [Soulver](https://soulver.app/download) itself and play around.

## Licence

You may use SoulverCore in personal or private projects. Please [email us](mailto:contact@soulver.app) if you wish to use SoulverCore in a publicly available, or commercial project. We have various options available depending on your needs, including a free (with attribution) license.

## Apps using SoulverCore

- [Lacona](https://lacona.app) - a powerful natural language assistant/launcher for macOS
- [Toolbox Pro](https://toolboxpro.app) - calculate with Soulver as part of your Siri Shortcuts on iOS

## Requirements

- Xcode 11+
- Swift 5+
- macOS 10.14.4+ (Intel or Apple Silicon) or iOS/iPadOS 12.2+

## Swift Package Manager Support

Xcode 12 and later lets you integrate SoulverCore into your project using the Swift Package Manager. 

In Xcode, go File > Swift Packages > Add Package Dependency and paste in the URL of this repository (https://github.com/soulverteam/SoulverCore).

## Carthage Support

SoulverCore supports [Carthage](https://github.com/Carthage/Carthage). Add the following binary dependency to your [Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile):

```
binary "https://soulver.app/core/SoulverCore.json"
```

## Manual Installation

Drag `SoulverCore.xcframework` into the `Frameworks, Libraries, and Embedded Content` section of the General settings for your Mac or iOS target.

## Getting Started

To calculate the result of a single expression, use a `Calculator` object:

```swift
import SoulverCore

let calculator = Calculator(customization: .standard)
let result = calculator.evaluate("123 + 456")
print("The answer is \(result.stringValue)") // prints 579
```

SoulverCore can perform all sorts of calculations, including unit conversions, date & calendar math, rate calculations, percentage phrase functions, time zone conversions, and much more. It also cleverly ignores "meaningless" words:

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

## Output Formatting

Use a `FormattingPreferences` to customize the way your result is formatted (how many decimal places to include, should the thousands separator be inserted, etc).

```swift
var formattingPreferences = FormattingPreferences()
formattingPreferences.dp = 2 // decimal places
calculator.formattingPreferences = formattingPreferences

calculator.calculate("π") // 3.14
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
calculator.evaluate("a + b", with: variableList) // 579        
```

## Custom Units

You can add custom units to an `EngineCustomization` object required by the intializer on `Calculator` or `LineCollection`.

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

## Locale Settings

SoulverCore respects the decimal separator and thousands separator of the system locale. Alternatively, you can convert the standard EngineCustomization to another locale:

```swift

let europeanLocale = Locale(identifier: "en_DE")
let localizedCustomization = EngineCustomization.standard.convertTo(locale: europeanLocale)

let calculator = Calculator(customization: localizedCustomization)

 /// In Germany a comma is used as a decimal separator
calculator.calculate("1,2 + 3,4") // 4,6
```

## Multi-line Calculations

Use a `LineCollection` to represent a collection of lines to be evaluated. Like `Calculator`, you can customize the way a LineCollection interprets expressions with an `EngineCustomization`.

```swift

let multiLineText =
"""
a = 10
b = 20
c = a + b
"""
        
let lineCollection = LineCollection(multiLineText:
    multiLineText, customization: .standard)

/// Calculate the result of each line (synchronously)
lineCollection.evaluateAll()

/// Use subscripts to get access to particular lines' results
let result = lineCollection[2].result // 30
```

## Currency Rates

The `.standard` `EngineCustomization` includes rates for 170 real-world currencies (that were accurate at the time the framework was last compiled).

You can (and should) update these currencies to the latest rates by setting valid API key credentials for [CurrencyLayer](https://currencylayer.com) (for fiat currencies) and [Nomics](https://nomics.com) (for crypto currencies) on the shared `CurrencyList`.

Alternatively use the `.popular` currency set to pull 33 common fiat currency rates from the [European Central Bank](https://exchangeratesapi.io), no API key required.

To fetch the latest rates, use SoulverCore's shared `CurrencyList`:

```swift

/// 33 popular currencies from the ECB, updated every weekday.

CurrencyList.shared.defaultCurrencySet = .popular 

CurrencyList.shared.refreshRates { (success) in
	
	if success {  
		/// The standard customization will now have the latest currency rates applied		
		
		let calculator = Calculator(customization: .standard)
		let result = calculator.calculate("10 USD in EUR")  		
	}
	
}

```

## Adding calculation capabilities to NSTextView/UITextView

Check out the [SoulverTextKit](https://github.com/soulverteam/SoulverTextKit) sample project for an example of how to integrate the SoulverCore math engine into a standard text view.


## Supported Languages

In addition to English, SoulverCore is fully localized into German 🇩🇪, Russian 🇷🇺, and simplified Chinese 🇨🇳. Support for romance languages (French, Spanish, etc) is planned for later in 2021.
