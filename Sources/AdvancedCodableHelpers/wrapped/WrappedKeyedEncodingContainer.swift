//
//  WrappedKeyedEncodingContainer.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2019-04-26.
//

import Foundation

/// A container that wraps a WrappedKeyedEncodingContainer allowing to override the coding path
open class WrappedKeyedEncodingContainer<Key>: KeyedEncodingContainerProtocol where Key: CodingKey {
    private var container: KeyedEncodingContainer<Key>
    public let codingPath: [CodingKey]
    
    private let disableRepackagingErrors: Bool
    
    
    public init<Container>(_ container: Container,
                           customCodingPath: [CodingKey]? = nil) where Container : KeyedEncodingContainerProtocol, Key == Container.Key {
        if let c = container as? KeyedEncodingContainer<Key> { self.container = c }
        else { self.container =  KeyedEncodingContainer(container)}
        self.codingPath = customCodingPath ?? container.codingPath
        self.disableRepackagingErrors = (customCodingPath == nil || (customCodingPath!.stringCodingPath == container.codingPath.stringCodingPath))
    }
    
    public func toKeyedContainer() -> KeyedEncodingContainer<Key> {
        return KeyedEncodingContainer<Key>(self)
    }
    
    open func encodeNil(forKey key: Key) throws {
        try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            try self.container.encodeNil(forKey: key)
        }
    }
    
    open func encode(_ value: Bool, forKey key: Key) throws {
        try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            try self.container.encode(value, forKey: key)
        }
    }
    
    open func encode(_ value: String, forKey key: Key) throws {
        try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            try self.container.encode(value, forKey: key)
        }
    }
    
    open func encode(_ value: Double, forKey key: Key) throws {
        try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            try self.container.encode(value, forKey: key)
        }
    }
    
    open func encode(_ value: Float, forKey key: Key) throws {
        try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            try self.container.encode(value, forKey: key)
        }
    }
    
    open func encode(_ value: Int, forKey key: Key) throws {
        try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            try self.container.encode(value, forKey: key)
        }
    }
    
    open func encode(_ value: Int8, forKey key: Key) throws {
        try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            try self.container.encode(value, forKey: key)
        }
    }
    
    open func encode(_ value: Int16, forKey key: Key) throws {
        try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            try self.container.encode(value, forKey: key)
        }
    }
    
    open func encode(_ value: Int32, forKey key: Key) throws {
        try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            try self.container.encode(value, forKey: key)
        }
    }
    
    open func encode(_ value: Int64, forKey key: Key) throws {
        try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            try self.container.encode(value, forKey: key)
        }
    }
    
    open func encode(_ value: UInt, forKey key: Key) throws {
        try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            try self.container.encode(value, forKey: key)
        }
    }
    
    open func encode(_ value: UInt8, forKey key: Key) throws {
        try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            try self.container.encode(value, forKey: key)
        }
    }
    
    open func encode(_ value: UInt16, forKey key: Key) throws {
        try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            try self.container.encode(value, forKey: key)
        }
    }
    
    open func encode(_ value: UInt32, forKey key: Key) throws {
        try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            try self.container.encode(value, forKey: key)
        }
    }
    
    open func encode(_ value: UInt64, forKey key: Key) throws {
        try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            try self.container.encode(value, forKey: key)
        }
    }
    
    open func encode<T>(_ value: T, forKey key: Key) throws where T : Encodable {
        try WrappedCodingErrors.repackage(self.codingPath.appending(key), disableRepackagingErrors) {
            // TODO: -  Will need to figure out how to properly wrap
            // try self.container.encode(value, forKey: key)
            let e = self.superEncoder(forKey: key)
            try value.encode(to: e)
        }
    }
    
    open func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type,
                                           forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        
        let c = WrappedKeyedEncodingContainer<NestedKey>(self.container.nestedContainer(keyedBy: keyType, forKey: key),
                                                         customCodingPath: self.codingPath.appending(key))
        return KeyedEncodingContainer(c)
        
    }
    
    open func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
        
        return WrappedUnkeyedEncodingContainer(self.container.nestedUnkeyedContainer(forKey: key),
                                               customCodingPath: self.codingPath.appending(key)).codableObject()

    }
    
    open func superEncoder() -> Encoder {
         return WrappedEncoder(self.container.superEncoder(),
                              customCodingPath: self.codingPath.appending(stringValue: "super"))
    }
    
    open  func superEncoder(forKey key: Key) -> Encoder {
        return WrappedEncoder(self.container.superEncoder(forKey: key),
                              customCodingPath: self.codingPath.appending(key))
    }
}
