//
//  WrappedKeyedToSingleValueDecodingContainer.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2021-10-03.
//

import Foundation

public class WrappedKeyedToSingleValueDecodingContainer<Key>: SingleValueDecodingContainer where Key: CodingKey {
    
    private var container: KeyedDecodingContainer<Key>
    public let codingPath: [CodingKey]
    
    private let disableRepackagingErrors: Bool
    
    
    public init<Container>(_ container: Container,
                           customCodingPath: [CodingKey]? = nil) where Container : KeyedDecodingContainerProtocol, Key == Container.Key {
        if let c = container as? KeyedDecodingContainer<Key> { self.container = c }
        else { self.container =  KeyedDecodingContainer(container)}
        self.codingPath = customCodingPath ?? container.codingPath
        self.disableRepackagingErrors = (customCodingPath == nil || (customCodingPath!.stringCodingPath == container.codingPath.stringCodingPath))
    }
    
    public func decodeNil() -> Bool {
        return false
    }
    
    private func triggerTypeMissmatch<R>() throws -> R {
        throw DecodingError.typeMismatch(R.self, .init(codingPath: self.codingPath,
                                                       debugDescription: "Unsupported type",
                                                       underlyingError: nil))
    }
    
    public func decode(_ type: Bool.Type) throws -> Bool {
        return try self.triggerTypeMissmatch()
    }
    
    public func decode(_ type: String.Type) throws -> String {
        return try self.triggerTypeMissmatch()
    }
    
    public func decode(_ type: Double.Type) throws -> Double {
        return try self.triggerTypeMissmatch()
    }
    
    public func decode(_ type: Float.Type) throws -> Float {
        return try self.triggerTypeMissmatch()
    }
    
    public func decode(_ type: Int.Type) throws -> Int {
        return try self.triggerTypeMissmatch()
    }
    
    public func decode(_ type: Int8.Type) throws -> Int8 {
        return try self.triggerTypeMissmatch()
    }
    
    public func decode(_ type: Int16.Type) throws -> Int16 {
        return try self.triggerTypeMissmatch()
    }
    
    public func decode(_ type: Int32.Type) throws -> Int32 {
        return try self.triggerTypeMissmatch()
    }
    
    public func decode(_ type: Int64.Type) throws -> Int64 {
        return try self.triggerTypeMissmatch()
    }
    
    public func decode(_ type: UInt.Type) throws -> UInt {
        return try self.triggerTypeMissmatch()
    }
    
    public func decode(_ type: UInt8.Type) throws -> UInt8 {
        return try self.triggerTypeMissmatch()
    }
    
    public func decode(_ type: UInt16.Type) throws -> UInt16 {
        return try self.triggerTypeMissmatch()
    }
    
    public func decode(_ type: UInt32.Type) throws -> UInt32 {
        return try self.triggerTypeMissmatch()
    }
    
    public func decode(_ type: UInt64.Type) throws -> UInt64 {
        return try self.triggerTypeMissmatch()
    }
    
    public func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        return try type.init(from: WrappedKeyedDecoder(self.container))
    }
}
