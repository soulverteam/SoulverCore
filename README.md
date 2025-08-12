![SoulverCore Icon](SoulverCoreIcon.png)

# What is SoulverCore?

SoulverCore is a **natural language math engine** written in Swift and used by the popular notepad calculator [Soulver](https://soulver.app). 

It is offered here as a **closed-source** xcframework. A license is required for commercial use, but it may be used for personal & non-commercial projects.

## Design goals of SoulverCore

- Sensible defaults for most use cases (the same defaults used by Soulver)
- A high level of customizability (set phrase variables, add new units, & define custom natural language functions)
- Excellent performance (7k+ calculations/second on Apple silicon devices)
- No 3rd party dependencies

## Requirements

- Xcode 15+
- Swift 5.9+
- SoulverCore is distributed as a binary framework (.xcframework) and includes builds for macOS (universal), iOS/iPadOS, and Mac Catalyst. Builds for other Apple platforms & Linux are available on request.
- The minimum system requirements are macOS 10.15 Catalina & iOS 13 (the first releases to support Swift Concurrency features)

## Installation using the Swift Package Manager (SPM)

In Xcode, go File > Swift Packages > Add Package Dependency, and paste in the URL of this repository (https://github.com/soulverteam/SoulverCore).

## Manual Installation

Clone this repository, and drag `SoulverCore.xcframework` into the `Frameworks, Libraries, and Embedded Content` section of the General settings for your Mac or iOS target.

## Getting Started

To calculate the result of a single expression, use a `Calculator` object:

```swift
import SoulverCore

let calculator = Calculator(customization: .standard)
let result = calculator.calculate("123 + 456")
print("The answer is \(result.stringValue)") // prints 579
```

SoulverCore can perform all sorts of calculations, including unit conversions, date & calendar math, rate calculations, percentage phrase functions, time zone conversions, and much more.

```swift
calculator.calculate("65 kg in pounds") // 143.3 lb
calculator.calculate("40 is what % of 90") // 44.44%
calculator.calculate("$150 is 25% on what") // $120
calculator.calculate("3:45pm + 4 hr 10 min") // 7:55 pm
calculator.calculate("9:35am in New York to Japan") // 10:35 pm
calculator.calculate("January 30 2020 + 3 months 2 weeks 5 days") // May 19, 2020
calculator.calculate("$25k over 10 years at 7.5%") // $51,525.79 (compound interest)
```

See the [Soulver Documentation](https://documentation.soulver.app/syntax-reference/general) for all supported syntaxes. 

Like Soulver, SoulverCore supports annotating your calculations with commenting words for context that have no effect on the result:

```swift
calculator.calculate("$10 for lunch + 15% tip") // $11.50
calculator.calculate("$25/hour * 14 hours of work") // $350.00
```

## Variables

Pass a `VariableList` into the calculate function to perform a calculation using variables:

```swift
let variableList = VariableList(variables:
    [
        Variable(name: "variable 1", value: "123"),
        Variable(name: "variable 2", value: "456"),
    ]
)
calculator.calculate("variable 1 + variable 2", with: variableList) // 579        
```

## Output Formatting

Use a `FormattingPreferences` to specify how your result should be formatted. Use this to specify how many decimal places of precision to include, and whether to add thousands separators, etc.

```swift
var formattingPreferences = FormattingPreferences()
formattingPreferences.dp = 2 // decimal places
calculator.formattingPreferences = formattingPreferences

calculator.calculate("π") // 3.14
```

## International

SoulverCore respects the decimal separator and thousands separator of your device's system locale. 

You may also convert the standard EngineCustomization to another locale:

```swift

let europeanLocale = Locale(identifier: "de_DE")
let localizedCustomization = EngineCustomization.standard.convertTo(locale: europeanLocale)

let calculator = Calculator(customization: localizedCustomization)

 /// In Germany a comma is used as a decimal separator
calculator.calculate("1,2 + 3,4") // 4,6
```

In addition to English, SoulverCore is fully localized into German, Russian, French, Spanish & simplified Chinese and the various number & date formats of these locales are also supported.

Note that non-English languages are *additive*, meaning that, for instance, a German user would be able to use both English & German syntaxes.

## Live Real-World & Crypto-Currency Rates

The `.standard` `EngineCustomization` uses hard-coded rates for 190 real-world & crypto-currencies. To support currency conversions, you should provide SoulverCore with live rates by setting the `currencyRateProvider` property on your calculator's `EngineCustomization` to an object conforming to `CurrencyRateProvider`.

SoulverCore includes one `CurrencyRateProvider` out-of-the-box that fetches 33 popular currency rates from the [European Central Bank](https://www.ecb.europa.eu/stats/eurofxref/).

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

## Performance

Most expressions are evaluated by SoulverCore in less than half a millisecond ⚡️. 

So while SoulverCore classes **are thread-safe**, there is typically no need to perform single calculations off the main thread of your application.

## Natural Language String Parsing with SoulverCore

__Data point parsing from strings__

SoulverCore can help you parse data out from strings in a type-safe way. It uses a natural and memorable syntax that's much more user friendly than regex for many tasks.

See [StringParsing](https://github.com/soulverteam/StringParsing) for more information. 

__Natural language date parsing from strings__

SoulverCore includes a powerful natural language date parsing engine that is much more versatile than Foundation's `DataDetector`. It can be used to add a natural language date input field to your scheduling or calendar app (similar to features found in [Things](https://culturedcode.com/things/support/articles/9780167/) and [Fantastical](https://flexibits.com/fantastical-ios/help/adding)).

See [DateParsing](https://github.com/soulverteam/DateParsing) for more information.

## SoulverCore for Windows

SoulverCore is also available for Windows as a dynamic link library (.dll). 

Since static linking is not yet supported by [Swift on Windows](https://www.swift.org/blog/swift-everywhere-windows-interop/), SoulverCore for Windows requires including several additional dynamic library files that contain Foundation and the Swift runtime.

See [SoulverCore for Windows](https://github.com/soulverteam/SoulverCore-Windows) for more information.

## Complete SoulverCore API Documentation

Browse the complete documentation for SoulverCore [here](https://soulverteam.github.io/SoulverCore-Documentation/documentation/soulvercore/).

Alternatively, a [DocC archive](https://developer.apple.com/documentation/docc) compatibile with Xcode or [Dash](https://kapeli.com/dash) is available for [download](https://github.com/SoulverTeam/SoulverCore/releases/latest/download/SoulverCore.doccarchive.zip).

## Licence

You may use SoulverCore in personal or private projects. Please [email us](mailto:contact@soulver.app) if you wish to use SoulverCore in a publicly available, or commercial project.

We have various options available depending on your user base size, including a free license (with attribution). 
