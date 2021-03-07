//
//  DictionaryKeyCodable.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2019-03-30.
//

import Foundation

public struct _DictionaryKeyCodableLock {
    fileprivate init() { }
}

/// Protocol used to define init on DictionaryKeyCodable
internal protocol DictionaryKeyCodableStringInit {
    init?(_ description: String)
}


/// Dictionary Codable Keys
/// Used to define available coding keys.
/// Protocol is locked for implementation, but available for checking
public protocol DictionaryKeyCodable: Codable {
    /// Poor way of locking down implementation of DictionaryKeyCodable to package while conditional use is still made publically available
    static var _dictionaryKeyCodableProtoLock: _DictionaryKeyCodableLock { get }
}

internal extension DictionaryKeyCodable {
    var dynamicCodingKey: CodableKey {
        if let v = self as? String {
            return CodableKey(stringValue: v)
        } else if let v = self as? Bool {
            return CodableKey(stringValue: "\(v)")
        } else if let v = self as? Int {
            return CodableKey(intValue: v)
        } else if let v = self as? Int8 {
            return CodableKey(intValue: Int(v))
        } else if let v = self as? Int16 {
            return CodableKey(intValue: Int(v))
        } else if let v = self as? Int32 {
            return CodableKey(intValue: Int(v))
        } else if let v = self as? Int64 {
            return CodableKey(intValue: Int(v))
        } else if let v = self as? UInt8 {
            return CodableKey(intValue: Int(v))
        } else if let v = self as? UInt16 {
            return CodableKey(intValue: Int(v))
        } else if let v = self as? UInt32 {
            return CodableKey(intValue: Int(v))
        } else {
            fatalError("Invalid DictionaryKeyCodable.  Expected either String or Int")
        }
    }
}

extension String: DictionaryKeyCodable {
    public static var _dictionaryKeyCodableProtoLock: _DictionaryKeyCodableLock { return _DictionaryKeyCodableLock() }
}

extension Bool: DictionaryKeyCodable, DictionaryKeyCodableStringInit {
    public static var _dictionaryKeyCodableProtoLock: _DictionaryKeyCodableLock { return _DictionaryKeyCodableLock() }
}
extension Int: DictionaryKeyCodable, DictionaryKeyCodableStringInit {
    public static var _dictionaryKeyCodableProtoLock: _DictionaryKeyCodableLock { return _DictionaryKeyCodableLock() }
}

extension Int8: DictionaryKeyCodable, DictionaryKeyCodableStringInit {
    public static var _dictionaryKeyCodableProtoLock: _DictionaryKeyCodableLock { return _DictionaryKeyCodableLock() }
}

extension UInt8: DictionaryKeyCodable, DictionaryKeyCodableStringInit {
    public static var _dictionaryKeyCodableProtoLock: _DictionaryKeyCodableLock { return _DictionaryKeyCodableLock() }
}

extension Int16: DictionaryKeyCodable, DictionaryKeyCodableStringInit {
    public static var _dictionaryKeyCodableProtoLock: _DictionaryKeyCodableLock { return _DictionaryKeyCodableLock() }
}

extension UInt16: DictionaryKeyCodable, DictionaryKeyCodableStringInit {
    public static var _dictionaryKeyCodableProtoLock: _DictionaryKeyCodableLock { return _DictionaryKeyCodableLock() }
}

extension Int32: DictionaryKeyCodable, DictionaryKeyCodableStringInit {
    public static var _dictionaryKeyCodableProtoLock: _DictionaryKeyCodableLock { return _DictionaryKeyCodableLock() }
}

extension UInt32: DictionaryKeyCodable, DictionaryKeyCodableStringInit {
    public static var _dictionaryKeyCodableProtoLock: _DictionaryKeyCodableLock { return _DictionaryKeyCodableLock() }
}

extension Int64: DictionaryKeyCodable, DictionaryKeyCodableStringInit {
    public static var _dictionaryKeyCodableProtoLock: _DictionaryKeyCodableLock { return _DictionaryKeyCodableLock() }
}




