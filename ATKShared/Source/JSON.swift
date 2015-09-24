//
//  JSON.swift
//  JSON
//
//  Created by Donald Hays on 2/13/15.
//  Copyright (c) 2015 Donald Hays. All rights reserved.
//

import Foundation

public enum JSON: CustomStringConvertible {
    case JSONArray([JSON])
    case JSONObject([String: JSON])
    case JSONString(String)
    case JSONNumber(Double)
    case JSONBool(Bool)
    case JSONNull

    public subscript(index: Int) -> JSON {
        if let array = self.array {
            if index < 0 || index >= array.count {
                return .JSONNull
            } else {
                return array[index]
            }
        } else {
            return .JSONNull
        }
    }

    public subscript(key: String) -> JSON {
        return object?[key] ?? .JSONNull
    }

    public var array: [JSON]? {
        switch self {
        case .JSONArray(let value):
            return value
        default:
            return nil
        }
    }

    public var object: [String: JSON]? {
        switch self {
        case .JSONObject(let value):
            return value
        default:
            return nil
        }
    }

    public var string: String? {
        switch self {
        case .JSONString(let value):
            return value
        case .JSONNumber(let value):
            return "\(value)"
        default:
            return nil
        }
    }

    public var url: NSURL? {
        switch self {
        case .JSONString(let value):
            if let url = NSURL(string: value) {
                return url
            }
            else if let escaped = (value as NSString).stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) {
                return NSURL(string: escaped)
            }
        default:
            return nil
        }
        return nil
    }

    public var date: NSDate? {
        switch self {
        case .JSONString:
            return nil
        case .JSONNumber(let value):
            return NSDate(timeIntervalSince1970: value)
        default:
            return nil
        }
    }

    public var number: Double? {
        switch self {
        case .JSONNumber(let value):
            return value
        case .JSONBool(let value):
            return value ? 1 : 0
        default:
            return nil
        }
    }

    public var integer: Int? {
        switch self {
        case .JSONNumber(let value):
            return Int(value)
        case .JSONBool(let value):
            return value ? 1 : 0
        default:
            return nil
        }
    }

    public var bool: Bool? {
        switch self {
        case .JSONBool(let value):
            return value
        case .JSONNumber(let value):
            return value != 0
        default:
            return nil
        }
    }

    public var null: Bool {
        switch self {
        case .JSONNull:
            return true
        default:
            return false
        }
    }

    public var JSONString: String {
        switch self {
        case .JSONArray(let value):
            let components = value.map {$0.JSONString}
            let merged = components.joinWithSeparator(",")
            return "[\(merged)]"
        case .JSONObject(let value):
            let keys = Array(value.keys)
            let components = keys.map {"\(self.serializeString($0)):\(value[$0]!.JSONString)"}
            let merged = components.joinWithSeparator(",")
            return "{\(merged)}"
        case .JSONString(let value):
            return serializeString(value)
        case .JSONNumber(let value):
            return "\(value)"
        case .JSONBool(let value):
            return "\(value)"
        case .JSONNull:
            return "null"
        }
    }

    public var JSONData: NSData {
        let string = self.JSONString as NSString
        let data: NSData? = string.dataUsingEncoding(NSUTF8StringEncoding)
        return data!
    }

    public var description: String {
        return self.JSONString
    }

    static func fromObject(object: AnyObject) -> JSON {
        if let object = object as? NSDictionary {
            var output: [String: JSON] = [:]
            for (key, value) in object {
                output[key as! String] = fromObject(value)
            }
            return .JSONObject(output)
        } else if let object = object as? NSArray {
            return .JSONArray((object as [AnyObject]).map(fromObject))
        } else if let object = object as? NSString {
            return .JSONString(object as String)
        } else if let object = object as? NSNumber {
            return .JSONNumber(object.doubleValue)
        }

        return .JSONNull
    }

    public static func fromData(data: NSData) -> (json: JSON?, error: NSError?) {
        var error: NSError? = nil
        let result: AnyObject?
        do {
            result = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        } catch let error1 as NSError {
            error = error1
            result = nil
        }

        if let result: AnyObject = result {
            return (fromObject(result), nil)
        } else {
            return (nil, error!)
        }
    }

    public static func fromString(string: String)  -> (json: JSON?, error: NSError?) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
        return fromData(data)
    }

    public init() {
        self = .JSONNull
    }

    public init(_ array: [JSON]?) {
        if let array = array {
            self = .JSONArray(array)
        } else {
            self = .JSONNull
        }
    }

    public init(_ object: [String: JSON]?) {
        if let object = object {
            self = .JSONObject(object)
        } else {
            self = .JSONNull
        }
    }

    public init(_ string: String?) {
        if let string = string {
            self = .JSONString(string)
        } else {
            self = .JSONNull
        }
    }

    public init(_ url: NSURL?) {
        if let absoluteString = url?.absoluteString {
            self = .JSONString(absoluteString)
        } else {
            self = .JSONNull
        }
    }

    public init(_ date: NSDate?) {
//        if let date = date {
//            self = .JSONString(date.iso8601Representation)
//        } else {
            self = .JSONNull
//        }
    }

    public init(_ number: Double?) {
        if let number = number {
            self = .JSONNumber(number)
        } else {
            self = .JSONNull
        }
    }

    public init(_ integer: Int?) {
        if let integer = integer {
            self = .JSONNumber(Double(integer))
        } else {
            self = .JSONNull
        }
    }

    public init(_ bool: Bool?) {
        if let bool = bool {
            self = .JSONBool(bool)
        } else {
            self = .JSONNull
        }
    }

    // MARK: -
    // MARK: Private API
    private func serializeString(string: String) -> String {
        var output: String = "\""

        for character in string.characters {
            switch String(character) {
            case "\"":
                output += "\\\""
            case "\\":
                output += "\\\\"
            case "/":
                output += "\\/"
            case "\u{8}":
                output += "\\b"
            case "\u{12}":
                output += "\\f"
            case "\n":
                output += "\\n"
            case "\r":
                output += "\\r"
            case "\t":
                output += "\\t"
            default:
                output += String(character)
            }
        }

        output += "\""
        return output
    }
}

extension JSON: ArrayLiteralConvertible {
    public init(arrayLiteral elements: JSON...) {
        self = .JSONArray(elements)
    }
}

extension JSON: DictionaryLiteralConvertible {
    public init(dictionaryLiteral elements: (String, JSON)...) {
        var dictionary: [String: JSON] = [:]
        for (key, value) in elements {
            dictionary[key] = value
        }

        self = .JSONObject(dictionary)
    }
}

extension JSON: StringLiteralConvertible {
    public init(stringLiteral value: String) {
        self = .JSONString(value)
    }

    public init(extendedGraphemeClusterLiteral value: String) {
        self = .JSONString(value)
    }

    public init(unicodeScalarLiteral value: String) {
        self = .JSONString(value)
    }
}

extension JSON: IntegerLiteralConvertible {
    public init(integerLiteral value: Int) {
        self = .JSONNumber(Double(value))
    }
}

extension JSON: FloatLiteralConvertible {
    public init(floatLiteral value: Double) {
        self = .JSONNumber(value)
    }
}

extension JSON: BooleanLiteralConvertible {
    public init(booleanLiteral value: Bool) {
        self = .JSONBool(value)
    }
}

extension JSON: NilLiteralConvertible {
    public init(nilLiteral: ()) {
        self = .JSONNull
    }
}
