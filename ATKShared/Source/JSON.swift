//
//  JSON.swift
//  JSON
//
//  Created by Donald Hays on 2/13/15.
//  Copyright (c) 2015 Donald Hays. All rights reserved.
//

import Foundation

public enum JSON: CustomStringConvertible {
    case jsonArray([JSON])
    case jsonObject([String: JSON])
    case jsonString(String)
    case jsonNumber(Double)
    case jsonBool(Bool)
    case jsonNull

    public subscript(index: Int) -> JSON {
        if let array = self.array {
            if index < 0 || index >= array.count {
                return .jsonNull
            } else {
                return array[index]
            }
        } else {
            return .jsonNull
        }
    }

    public subscript(key: String) -> JSON {
        return object?[key] ?? .jsonNull
    }

    public var array: [JSON]? {
        switch self {
        case .jsonArray(let value):
            return value
        default:
            return nil
        }
    }

    public var object: [String: JSON]? {
        switch self {
        case .jsonObject(let value):
            return value
        default:
            return nil
        }
    }

    public var string: String? {
        switch self {
        case .jsonString(let value) where !value.isEmpty:
            return value
        case .jsonNumber(let value):
            return "\(value)"
        default:
            return nil
        }
    }

    public var url: URL? {
        switch self {
        case .jsonString(let value):
            if let url = URL(string: value) {
                return url
            }
            else if let escaped = (value as NSString).addingPercentEscapes(using: String.Encoding.utf8.rawValue) {
                return URL(string: escaped)
            }
        default:
            return nil
        }
        return nil
    }

    public var date: Date? {
        switch self {
        case .jsonString:
            return nil
        case .jsonNumber(let value):
            return Date(timeIntervalSince1970: value)
        default:
            return nil
        }
    }

    public var number: Double? {
        switch self {
        case .jsonNumber(let value):
            return value
        case .jsonBool(let value):
            return value ? 1 : 0
        default:
            return nil
        }
    }

    public var integer: Int? {
        switch self {
        case .jsonNumber(let value):
            return Int(value)
        case .jsonBool(let value):
            return value ? 1 : 0
        default:
            return nil
        }
    }

    public var bool: Bool? {
        switch self {
        case .jsonBool(let value):
            return value
        case .jsonNumber(let value):
            return value != 0
        default:
            return nil
        }
    }

    public var null: Bool {
        switch self {
        case .jsonNull:
            return true
        default:
            return false
        }
    }

    public var JSONString: String {
        switch self {
        case .jsonArray(let value):
            let components = value.map {$0.JSONString}
            let merged = components.joined(separator: ",")
            return "[\(merged)]"
        case .jsonObject(let value):
            let keys = Array(value.keys)
            let components = keys.map {"\(self.serializeString($0)):\(value[$0]!.JSONString)"}
            let merged = components.joined(separator: ",")
            return "{\(merged)}"
        case .jsonString(let value):
            return serializeString(value)
        case .jsonNumber(let value):
            return "\(value)"
        case .jsonBool(let value):
            return "\(value)"
        case .jsonNull:
            return "null"
        }
    }

    public var JSONData: Data {
        let string = self.JSONString as NSString
        let data: Data? = string.data(using: String.Encoding.utf8.rawValue)
        return data!
    }

    public var description: String {
        return self.JSONString
    }

    static func fromObject(_ object: AnyObject) -> JSON {
        if let object = object as? NSDictionary {
            var output: [String: JSON] = [:]
            for (key, value) in object {
                output[key as! String] = fromObject(value as AnyObject)
            }
            return .jsonObject(output)
        } else if let object = object as? NSArray {
            return .jsonArray((object as [AnyObject]).map(fromObject))
        } else if let object = object as? NSString {
            return .jsonString(object as String)
        } else if let object = object as? NSNumber {
            return .jsonNumber(object.doubleValue)
        }

        return .jsonNull
    }

    public static func fromData(_ data: Data) -> (json: JSON?, error: NSError?) {
        var error: NSError? = nil
        let result: AnyObject?
        do {
            result = try JSONSerialization.jsonObject(with: data, options: []) as AnyObject
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

    public static func fromString(_ string: String)  -> (json: JSON?, error: NSError?) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)!
        return fromData(data)
    }

    public init() {
        self = .jsonNull
    }

    public init(_ array: [JSON]?) {
        if let array = array {
            self = .jsonArray(array)
        } else {
            self = .jsonNull
        }
    }

    public init(_ object: [String: JSON]?) {
        if let object = object {
            self = .jsonObject(object)
        } else {
            self = .jsonNull
        }
    }

    public init(_ string: String?) {
        if let string = string {
            self = .jsonString(string)
        } else {
            self = .jsonNull
        }
    }

    public init(_ url: URL?) {
        if let absoluteString = url?.absoluteString {
            self = .jsonString(absoluteString)
        } else {
            self = .jsonNull
        }
    }

    public init(_ date: Date?) {
//        if let date = date {
//            self = .JSONString(date.iso8601Representation)
//        } else {
            self = .jsonNull
//        }
    }

    public init(_ number: Double?) {
        if let number = number {
            self = .jsonNumber(number)
        } else {
            self = .jsonNull
        }
    }

    public init(_ integer: Int?) {
        if let integer = integer {
            self = .jsonNumber(Double(integer))
        } else {
            self = .jsonNull
        }
    }

    public init(_ bool: Bool?) {
        if let bool = bool {
            self = .jsonBool(bool)
        } else {
            self = .jsonNull
        }
    }

    // MARK: -
    // MARK: Private API
    fileprivate func serializeString(_ string: String) -> String {
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

extension JSON: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: JSON...) {
        self = .jsonArray(elements)
    }
}

extension JSON: ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (String, JSON)...) {
        var dictionary: [String: JSON] = [:]
        for (key, value) in elements {
            dictionary[key] = value
        }

        self = .jsonObject(dictionary)
    }
}

extension JSON: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = .jsonString(value)
    }

    public init(extendedGraphemeClusterLiteral value: String) {
        self = .jsonString(value)
    }

    public init(unicodeScalarLiteral value: String) {
        self = .jsonString(value)
    }
}

extension JSON: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = .jsonNumber(Double(value))
    }
}

extension JSON: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = .jsonNumber(value)
    }
}

extension JSON: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) {
        self = .jsonBool(value)
    }
}

extension JSON: ExpressibleByNilLiteral {
    public init(nilLiteral: ()) {
        self = .jsonNull
    }
}
