//
//  WrappedKeyedDecodingContainer.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2019-04-26.
//

import Foundation

/// A container that wraps a KeyedDecodingContainer allowing to override the coding path
open class WrappedKeyedDecodingContainer<Key>: KeyedDecodingContainerProtocol where Key: CodingKey {
    
    private var container: KeyedDecodingContainer<Key>
    public let codingPath: [CodingKey]
    open var allKeys: [Key] { return self.container.allKeys }
    
    private let disableRepackagingErrors: Bool
    
    
    public init<Container>(_ container: Container,
                           customCodingPath: [CodingKey]? = nil) where Container : KeyedDecodingContainerProtocol, Key == Container.Key {
        
        if let c = container as? KeyedDecodingContainer<Key> { self.container = c }
        else { self.container = KeyedDecodingContainer(container) }
        self.codingPath = customCodingPath ?? container.codingPath
        self.disableRepackagingErrors = (customCodingPath == nil || (customCodingPath!.stringCodingPath == container.codingPath.stringCodingPath))
    }
    
    
    public func toKeyedContainer() -> KeyedDecodingContainer<Key> {
        return KeyedDecodingContainer<Key>(self)
    }
    
    open func contains(_ key: Key) -> Bool {
        return self.container.contains(key)
    }
    
    open func decodeNil(forKey key: Key) throws -> Bool {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            return try self.container.decodeNil(forKey: key)
        }
    }
    
    open func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            return try self.container.decode(type, forKey: key)
        }
    }
    
    open func decode(_ type: String.Type, forKey key: Key) throws -> String {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            return try self.container.decode(type, forKey: key)
        }
    }
    
    open func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            return try self.container.decode(type, forKey: key)
        }
    }
    
    open func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            return try self.container.decode(type, forKey: key)
        }
    }
    
    open func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            return try self.container.decode(type, forKey: key)
        }
    }
    
    open func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            return try self.container.decode(type, forKey: key)
        }
    }
    
    open func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            return try self.container.decode(type, forKey: key)
        }
    }
    
    open func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            return try self.container.decode(type, forKey: key)
        }
    }
    
    open func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            return try self.container.decode(type, forKey: key)
        }
    }
    
    open func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            return try self.container.decode(type, forKey: key)
        }
    }
    
    open func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            return try self.container.decode(type, forKey: key)
        }
    }
    
    open func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            return try self.container.decode(type, forKey: key)
        }
    }
    
    open func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            return try self.container.decode(type, forKey: key)
        }
    }
    
    open func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            return try self.container.decode(type, forKey: key)
        }
    }
    
    open func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T : Decodable {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            // TODO: -  Will need to figure out how to properly wrap
            // return try self.container.decode(type, forKey: key)
            let d = try self.superDecoder(forKey: key)
            return try T(from: d)
            
        }
    }
    
    open func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type,
                                           forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
        let c = WrappedKeyedDecodingContainer<NestedKey>(try container.nestedContainer(keyedBy: type, forKey: key),
                                              customCodingPath: self.codingPath.appending(key))
        
            return KeyedDecodingContainer(c)
        }
    }
    
    open func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            return WrappedUnkeyedDecodingContainer(try self.container.nestedUnkeyedContainer(forKey: key),
                                                   customCodingPath: self.codingPath.appending(key))
        }
    }
    
    open func superDecoder() throws -> Decoder {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(CodableKey.super), disableRepackagingErrors) {
            return WrappedDecoder(try self.container.superDecoder(),
                                  customCodingPath: self.codingPath.appending(CodableKey.super))
        }
    }
    
    open func superDecoder(forKey key: Key) throws -> Decoder {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            return WrappedDecoder(try self.container.superDecoder(forKey: key),
                                  customCodingPath: self.codingPath.appending(key))
        }
    }
}
