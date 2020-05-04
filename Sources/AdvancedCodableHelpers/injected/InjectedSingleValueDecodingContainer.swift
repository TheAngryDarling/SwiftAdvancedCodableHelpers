//
//  InjectedSingleValueDecodingContainer.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2018-11-06.
//

import Foundation
import Nillable

/// A single value decoding container that allows the coder to inject an extra value into the decoding process
///
/// Unsupported functions: superDecoder(), nestedContainer(keyedBy:)
public class InjectedSingleValueDecodingContainer: SingleValueDecodingContainer {
    public let codingPath: [CodingKey]
    
    private let object: Any
    
    public fileprivate(set) var currentIndex: Int = 0
    
    public init(_ codingPath: [CodingKey], object: Any) {
        self.codingPath = codingPath
        self.object = object
    }
    
    public func decodeNil() -> Bool {
        guard isNil(self.object) else { return false }
        
        return true
    }
    
    public func decode(_ type: Bool.Type) throws -> Bool {
        guard let v = object as? Bool else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.object)
        }
        
        return v
    }
    
    public func decode(_ type: String.Type) throws -> String {
        guard let v = self.object as? String else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.object)
        }
        
        return v
    }
    
    public func decode(_ type: Double.Type) throws -> Double {
        guard let v = self.object as? Double else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.object)
        }
        
        return v
    }
    
    public func decode(_ type: Float.Type) throws -> Float {
        guard let v = self.object as? Float else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.object)
        }
        
        return v
    }
    
    public func decode(_ type: Int.Type) throws -> Int {
        guard let v = self.object as? Int else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.object)
        }
        
        return v
    }
    
    public func decode(_ type: Int8.Type) throws -> Int8 {
        guard let v = self.object as? Int8 else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.object)
        }
        
        return v
    }
    
    public func decode(_ type: Int16.Type) throws -> Int16 {
        guard let v = self.object as? Int16 else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.object)
        }
        
        return v
    }
    
    public func decode(_ type: Int32.Type) throws -> Int32 {
        guard let v = self.object as? Int32 else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.object)
        }
        
        return v
    }
    
    public func decode(_ type: Int64.Type) throws -> Int64 {
        guard let v = self.object as? Int64 else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.object)
        }
        
        return v
    }
    
    public func decode(_ type: UInt.Type) throws -> UInt {
        guard let v = self.object as? UInt else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.object)
        }
        
        
        return v
    }
    
    public func decode(_ type: UInt8.Type) throws -> UInt8 {
        guard let v = self.object as? UInt8 else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.object)
        }
        
        return v
    }
    
    public func decode(_ type: UInt16.Type) throws -> UInt16 {
        guard let v = self.object as? UInt16 else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.object)
        }
        
        return v
    }
    
    public func decode(_ type: UInt32.Type) throws -> UInt32 {
        guard let v = self.object as? UInt32 else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.object)
        }
        
        
        return v
    }
    
    public func decode(_ type: UInt64.Type) throws -> UInt64 {
        guard let v = self.object as? UInt64 else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.object)
        }
        
        return v
    }
    
    public func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        guard let v = self.object as? T else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.object)
        }
        
        return v
    }
    
    public func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        guard let v = self.object as? [String: Any] else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.object)
        }
        var newPath: [CodingKey] = []
        newPath.append(contentsOf: self.codingPath)
        newPath.append(CodableKey(index: self.currentIndex))
        
        return InjectedKeyedDecodingContainer<NestedKey>(newPath, injections: v).toKeyedContainer()
    }
    
    public func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        guard let v = self.object as? [Any] else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: [Any].self, reality: self.object)
        }
        var newPath: [CodingKey] = []
        newPath.append(contentsOf: self.codingPath)
        newPath.append(CodableKey(index: self.currentIndex))

        return InjectedUnkeyedDecodingContainer(newPath, objects: v)
    }
    
    public func superDecoder() throws -> Decoder {
        var newPath: [CodingKey] = []
        newPath.append(contentsOf: self.codingPath)
        newPath.append(CodableKey(index: self.currentIndex))
        
        if let v = self.object as? [String: Any] {
            let container = InjectedKeyedDecodingContainer<CodableKey>(newPath, injections: v)
            return WrappedKeyedDecoder(container)
        } else if let v = self.object as? [Any] {
            let container = InjectedUnkeyedDecodingContainer(newPath, objects: v)
            return WrappedUnkeyedDecoder(container)
        } else {
            let container = InjectedSingleValueDecodingContainer(newPath, object: self.object)
            return WrappedSingleValueDecoder(container)
        }
    }
    
    
}
