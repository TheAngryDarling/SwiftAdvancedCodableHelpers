//
//  InjectedUnkeyedDecodingContainer.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2018-11-06.
//

import Foundation
import Nillable

/// An unkeyed decoding container that allows the coder to inject extra values into the decoding process
///
/// Unsupported functions: superDecoder(), nestedContainer(keyedBy:)
public class InjectedUnkeyedDecodingContainer: UnkeyedDecodingContainer {
    
    
    public let codingPath: [CodingKey]
    
    private let objects: [Any]
    
    public let count: Int?
    
    public var isAtEnd: Bool { return currentIndex == self.objects.count }
    
    public fileprivate(set) var currentIndex: Int = 0
    
    public init(_ codingPath: [CodingKey], objects: [Any]) {
        self.codingPath = codingPath
        self.objects = objects
        self.count = objects.count
    }
    
    public init(_ codingPath: [CodingKey], object: Any) {
        self.codingPath = codingPath
        if let vA = object as? [Any] { self.objects = vA }
        else { self.objects = [object] }
        self.count = 1
    }
    
    public func decodeNil() throws -> Bool {
        /*guard objects[self.currentIndex] is NSNull || ((objects[self.currentIndex] as? _OptionalProtocol)?.isNil ?? false)  else {
            return false
        }*/
        
        /*guard ((objects[self.currentIndex] as? Nillable)?.isNil ?? false) else {
            return false
        }*/
        guard isNil(objects[self.currentIndex]) else { return false }
        
        self.currentIndex += 1
        return true
    }
    
    public func decode(_ type: Bool.Type) throws -> Bool {
        guard let v = objects[self.currentIndex] as? Bool else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.objects[self.currentIndex])
        }
        self.currentIndex += 1
        return v
    }
    
    public func decode(_ type: String.Type) throws -> String {
        guard let v = objects[self.currentIndex] as? String else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.objects[self.currentIndex])
        }
        self.currentIndex += 1
        return v
    }
    
    public func decode(_ type: Double.Type) throws -> Double {
        guard let v = objects[self.currentIndex] as? Double else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.objects[self.currentIndex])
        }
        self.currentIndex += 1
        return v
    }
    
    public func decode(_ type: Float.Type) throws -> Float {
        guard let v = objects[self.currentIndex] as? Float else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.objects[self.currentIndex])
        }
        self.currentIndex += 1
        return v
    }
    
    public func decode(_ type: Int.Type) throws -> Int {
        guard let v = objects[self.currentIndex] as? Int else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.objects[self.currentIndex])
        }
        self.currentIndex += 1
        return v
    }
    
    public func decode(_ type: Int8.Type) throws -> Int8 {
        guard let v = objects[self.currentIndex] as? Int8 else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.objects[self.currentIndex])
        }
        self.currentIndex += 1
        return v
    }
    
    public func decode(_ type: Int16.Type) throws -> Int16 {
        guard let v = objects[self.currentIndex] as? Int16 else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.objects[self.currentIndex])
        }
        self.currentIndex += 1
        return v
    }
    
    public func decode(_ type: Int32.Type) throws -> Int32 {
        guard let v = objects[self.currentIndex] as? Int32 else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.objects[self.currentIndex])
        }
        self.currentIndex += 1
        return v
    }
    
    public func decode(_ type: Int64.Type) throws -> Int64 {
        guard let v = objects[self.currentIndex] as? Int64 else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.objects[self.currentIndex])
        }
        self.currentIndex += 1
        return v
    }
    
    public func decode(_ type: UInt.Type) throws -> UInt {
        guard let v = objects[self.currentIndex] as? UInt else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.objects[self.currentIndex])
        }
        self.currentIndex += 1
        
        return v
    }
    
    public func decode(_ type: UInt8.Type) throws -> UInt8 {
        guard let v = objects[self.currentIndex] as? UInt8 else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.objects[self.currentIndex])
        }
        self.currentIndex += 1
        return v
    }
    
    public func decode(_ type: UInt16.Type) throws -> UInt16 {
        guard let v = objects[self.currentIndex] as? UInt16 else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.objects[self.currentIndex])
        }
        self.currentIndex += 1
        return v
    }
    
    public func decode(_ type: UInt32.Type) throws -> UInt32 {
        guard let v = objects[self.currentIndex] as? UInt32 else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.objects[self.currentIndex])
        }
        self.currentIndex += 1
        
        return v
    }
    
    public func decode(_ type: UInt64.Type) throws -> UInt64 {
        guard let v = objects[self.currentIndex] as? UInt64 else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.objects[self.currentIndex])
        }
        self.currentIndex += 1
        return v
    }
    
    public func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        guard let v = objects[self.currentIndex] as? T else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.objects[self.currentIndex])
        }
        self.currentIndex += 1
        return v
    }
    
    public func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        guard let v = objects[self.currentIndex] as? [String: Any] else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: type, reality: self.objects[self.currentIndex])
        }
        
        var newPath: [CodingKey] = []
        newPath.append(contentsOf: self.codingPath)
        newPath.append(CodableKey(index: self.currentIndex))
        
        self.currentIndex += 1
        
        return InjectedKeyedDecodingContainer<NestedKey>(newPath, injections: v).toKeyedContainer()
    }
    
    public func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        guard let v = objects[self.currentIndex] as? [Any] else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: [Any].self, reality: self.objects[self.currentIndex])
        }
        var newPath: [CodingKey] = []
        newPath.append(contentsOf: self.codingPath)
        newPath.append(CodableKey(index: self.currentIndex))
        
        self.currentIndex += 1
        
        return InjectedUnkeyedDecodingContainer(newPath, objects: v)
        
    }
    
    public func superDecoder() throws -> Decoder {
        var newPath: [CodingKey] = []
        newPath.append(contentsOf: self.codingPath)
        newPath.append(CodableKey(index: self.currentIndex))
        
        if let v = objects[self.currentIndex] as? [String: Any] {
            let container = InjectedKeyedDecodingContainer<CodableKey>(newPath, injections: v)
            return WrappedKeyedDecoder(container)
        } else if let v = objects[self.currentIndex] as? [Any] {
            let container = InjectedUnkeyedDecodingContainer(newPath, objects: v)
            return WrappedUnkeyedDecoder(container)
        } else {
            let container = InjectedSingleValueDecodingContainer(newPath, object: objects[self.currentIndex])
            return WrappedSingleValueDecoder(container)
        }
    }
    
    
}


