//
//  WrappedUnkeyedDecodingContainer.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2019-04-26.
//

import Foundation

/// A container that wraps a WrappedUnkeyedDecodingContainer allowing to override the coding path
open class WrappedUnkeyedDecodingContainer: UnkeyedDecodingContainer {
    
    
    private var container: UnkeyedDecodingContainer
    public let codingPath: [CodingKey]
    
    private let disableRepackagingErrors: Bool
    
    public var count: Int? { return container.count }
    public var isAtEnd: Bool { return container.isAtEnd }
    public var currentIndex: Int { return container.currentIndex }
    
    public init(_ container: UnkeyedDecodingContainer, customCodingPath: [CodingKey]? = nil) {
        self.container = container
        self.codingPath = customCodingPath ?? container.codingPath
        self.disableRepackagingErrors = (customCodingPath == nil || (customCodingPath!.stringCodingPath == container.codingPath.stringCodingPath))
    }
    
    open func decodeNil() throws -> Bool {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(index: self.currentIndex),
                                                 disableRepackagingErrors) {
            return try container.decodeNil()
        }
    }
    
    open func decode(_ type: Bool.Type) throws -> Bool {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(index: self.currentIndex),
                                                 disableRepackagingErrors) {
            return try container.decode(type)
        }
    }
    
    open func decode(_ type: String.Type) throws -> String {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(index: self.currentIndex),
                                                 disableRepackagingErrors) {
            return try container.decode(type)
        }
    }
    
    open func decode(_ type: Double.Type) throws -> Double {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(index: self.currentIndex),
                                                 disableRepackagingErrors) {
            return try container.decode(type)
        }
    }
    
    open func decode(_ type: Float.Type) throws -> Float {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(index: self.currentIndex),
                                                 disableRepackagingErrors) {
            return try container.decode(type)
        }
    }
    
    open func decode(_ type: Int.Type) throws -> Int {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(index: self.currentIndex),
                                                 disableRepackagingErrors) {
            return try container.decode(type)
        }
    }
    
    open func decode(_ type: Int8.Type) throws -> Int8 {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(index: self.currentIndex),
                                                 disableRepackagingErrors) {
            return try container.decode(type)
        }
    }
    
    open func decode(_ type: Int16.Type) throws -> Int16 {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(index: self.currentIndex),
                                                 disableRepackagingErrors) {
            return try container.decode(type)
        }
    }
    
    open func decode(_ type: Int32.Type) throws -> Int32 {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(index: self.currentIndex),
                                                 disableRepackagingErrors) {
            return try container.decode(type)
        }
    }
    
    open func decode(_ type: Int64.Type) throws -> Int64 {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(index: self.currentIndex),
                                                 disableRepackagingErrors) {
            return try container.decode(type)
        }
    }
    
    open func decode(_ type: UInt.Type) throws -> UInt {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(index: self.currentIndex),
                                                 disableRepackagingErrors) {
            return try container.decode(type)
        }
    }
    
    open func decode(_ type: UInt8.Type) throws -> UInt8 {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(index: self.currentIndex),
                                                 disableRepackagingErrors) {
            return try container.decode(type)
        }
    }
    
    open func decode(_ type: UInt16.Type) throws -> UInt16 {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(index: self.currentIndex),
                                                 disableRepackagingErrors) {
            return try container.decode(type)
        }
    }
    
    open func decode(_ type: UInt32.Type) throws -> UInt32 {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(index: self.currentIndex),
                                                 disableRepackagingErrors) {
            return try container.decode(type)
        }
    }
    
    open func decode(_ type: UInt64.Type) throws -> UInt64 {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(index: self.currentIndex),
                                                 disableRepackagingErrors) {
            return try container.decode(type)
        }
    }
    
    open func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(index: self.currentIndex),
                                                 disableRepackagingErrors) {
            // TODO: -  Will need to figure out how to properly wrap
            // return try container.decode(type)
                                                    
            let d =  WrappedDecoder(try self.container.superDecoder(),
                                    customCodingPath: self.codingPath.appending(index: self.currentIndex))
            return try T(from: d)
        }
    }
    
    open func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(index: self.currentIndex),
                                                 disableRepackagingErrors) {
            let c = WrappedKeyedDecodingContainer(try container.nestedContainer(keyedBy: type),
                                                  customCodingPath: self.codingPath.appending(index: self.currentIndex))
        
            return KeyedDecodingContainer(c)
        }
    }
    
    open func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(index: self.currentIndex),
                                                 disableRepackagingErrors) {
            return WrappedUnkeyedDecodingContainer(try self.container.nestedUnkeyedContainer(),
                                                   customCodingPath: self.codingPath.appending(index: self.currentIndex))
        }
    }
    
    open func superDecoder() throws -> Decoder {
        return try WrappedCodingErrors.repackage(self.codingPath.appending(CodableKey.super),
                                                 disableRepackagingErrors) {
            return WrappedDecoder(try self.container.superDecoder(),
                                  customCodingPath: self.codingPath.appending(CodableKey.super))
        }
    }
}
