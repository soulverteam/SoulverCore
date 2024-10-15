import SoulverCore

public struct StringParsingExamples {
    
    public static func runAllExamples() {
        
        self.runBasicPercentageExtraction()
        self.runPayrollExtraction()
        self.runDataExtractionAndReduceFromArray()
        self.runWhitespaceStandardization()
        self.runNumberFormatStandardization()
        self.runTemperatureStringArrayConversion()
        self.runCustomTypeParsingExample()
        
    }
    
    static func runBasicPercentageExtraction() {
        
        let percent = "Results of likeness test: 83% match".find(.percentage)!
        print(percent)
        
    }
    
    static func runPayrollExtraction() {
        
        // this string has inconsistent whitespace between entities, but this isn't a problem for us
        let payrollEntry = "CREDIT            03/02/2022            Payroll from employer                $200.23"
        let data = payrollEntry.find(.date, .currency)!
        
        print(data.0) // Either February 3, or March 2, depending on your system locale
        print(data.1) // UnitExpression object (use .value to get the decimalValue, and .unit.identifier to get the currency code)
        
    }
    
    static func runDataExtractionAndReduceFromArray() {
        
        let amounts = ["Zac spent $50", "Molly spent US$81.9 (with her 10% discount)", "Jude spent $43.90 USD"].find(.currency)
        
        let totalAmount = amounts.reduce(0.0) {
            $0 + $1.value
        }
        
        print(totalAmount)
        
    }
    
    static func runWhitespaceStandardization() {
        
        let standardized = "CREDIT            03/02/2022            Payroll from employer                $200.23".replacingAll(.whitespace) { whitespace in
            return " "
        }
        
        print(standardized)
        
    }
    
    static func runNumberFormatStandardization() {
        let standardized = "10.330,99 8.330,22 330,99".replacingAll(.number, locale: Locale(identifier: "en_DE")) { number in
            
            return NumberFormatter.localizedString(from: number as NSNumber, number: .decimal)
            
        }
        
        print(standardized)
        
    }
    
    static func runTemperatureStringArrayConversion() {
        
        let convertedTemperatures = ["25 °C", "12.5 degrees celsius", "-22.6 C"].replacingAll(.temperature) { celsius in
            
            let measurementC: Measurement<UnitTemperature> = Measurement(value: (celsius.value as NSDecimalNumber).doubleValue, unit: .celsius)
            let measurementF = measurementC.converted(to: .fahrenheit)
            
            let formatter = MeasurementFormatter()
            formatter.unitOptions = .providedUnit
            return formatter.string(from: measurementF)
            
        }
        
        print(convertedTemperatures)
        
    }
    
    static func runCustomTypeParsingExample() {
        
        let container1 = Container("Color: blue, size: medium, volume: 12.5 cm3".find(.color, .size, .volume)!)
        let container2 = Container("Color: red, size: small, volume: 6.2 cm3".find(.color, .size, .volume)!)
        let container3 = Container("Color: yellow, size: large, volume: 17.82 cm3".find(.color, .size, .volume)!)
        
        _ = [container1, container2, container3]
        
    }
    
    
}


// MARK: - Custom Types for the Custom Parsing Example

enum Color: String, RawRepresentable {
    case blue
    case red
    case yellow
}

enum Size: String, RawRepresentable {
    case small
    case medium
    case large
}

struct Container {
    
    let color: Color
    let size: Size
    let volume: Decimal
    
    init(_ data: (Color, Size, UnitExpression)) {
        
        self.color = data.0
        self.size = data.1
        self.volume = data.2.value
        
    }
    
}

// MARK: -  Implementation of parsers for the custom types above

/// In both cases, we simply check to see if we can create an enum case from the token's stringValue

struct ColorParser: DataFromTokenParser {
    typealias DataType = Color
    
    func parseDataFrom(token: SoulverCore.Token) -> Color? {
        return Color(rawValue: token.stringValue.lowercased())
    }
}

struct SizeParser: DataFromTokenParser {
    typealias DataType = Size
    
    func parseDataFrom(token: SoulverCore.Token) -> Size? {
        return Size(rawValue: token.stringValue.lowercased())
    }
}

extension DataPoint {
    
    static var color: DataPoint<ColorParser> {
        return DataPoint<ColorParser>(parser: ColorParser())
    }
    
    static var size: DataPoint<SizeParser> {
        return DataPoint<SizeParser>(parser: SizeParser())
    }
    
}
