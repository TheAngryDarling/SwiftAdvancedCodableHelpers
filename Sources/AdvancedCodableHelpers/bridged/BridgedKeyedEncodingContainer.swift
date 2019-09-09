//
//  BridgedKeyEncodingContainer.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2018-11-05.
//

import Foundation

/// A encoding container that bridges from one CodingKey type to another CodingKey type
public class BridgedKeyedEncodingContainer<FromKey, ToKey>: KeyedEncodingContainerProtocol where FromKey: CodingKey, ToKey: CodingKey {
    public typealias Key = ToKey
    
    public enum BridgedEncodingError: Error {
        case keyNotFound(CodingKey, EncodingError.Context)
    }
    
    private var container: KeyedEncodingContainer<FromKey>
    
    /// The path of coding keys taken to get to this point in encoding.
    public let codingPath: [CodingKey]
    
    /// Creates a new Bridged Encoding Container
    ///
    /// - Parameters:
    ///   - container: The real container to write the data to
    public init(_ container: KeyedEncodingContainer<FromKey>) {
        self.container = container
        self.codingPath = container.codingPath
    }
    /// Creates a new Bridged Encoding Container
    ///
    /// - Parameters:
    ///   - container: The real container to write the data to
    public init<Container>(_ container: Container) where FromKey == Container.Key, Container : KeyedEncodingContainerProtocol {
        self.container = KeyedEncodingContainer(container)
        self.codingPath = container.codingPath
    }
    
    /// Helpful method of creating a KeyedEncodingContainer out of the current container
    ///
    /// - Returns: Returns a KeyedEncodingContainer wrapped around this instance
    public func toKeyedContainer() -> KeyedEncodingContainer<Key> {
        return KeyedEncodingContainer<Key>(self)
    }
    
    
    /// Converts a coding key from the wrapped to the key type of the stored container
    ///
    /// - Parameter from: Original key to convert
    /// - Returns: Returns
    /// - Throws: BridgedEncodingError.keyNotFound
    private func convertKey(_ from: Key) throws -> FromKey {
        guard let rtn = FromKey(stringValue: from.stringValue) else {
            throw BridgedEncodingError.keyNotFound(from, EncodingError.Context.init(codingPath: self.codingPath, debugDescription: "Could not convert key '\(from.stringValue)' of type \(type(of: from)) to type \(FromKey.self)"))
            //fatalError("Invalid Key")
        }
        return rtn
    }
    
    /// Encodes a null value for the given key.
    ///
    /// - parameter key: The key to associate the value with.
    /// - throws: `EncodingError.invalidValue` if a null value is invalid in the
    ///   current context for this format.
    public func encodeNil(forKey key: Key) throws {
        try self.container.encodeNil(forKey: try convertKey(key))
    }
    
    /// Encodes the given value for the given key.
    ///
    /// - parameter value: The value to encode.
    /// - parameter key: The key to associate the value with.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    public func encode(_ value: Bool, forKey key: Key) throws {
        try self.container.encode(value, forKey: try convertKey(key))
    }
    
    /// Encodes the given value for the given key.
    ///
    /// - parameter value: The value to encode.
    /// - parameter key: The key to associate the value with.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    public func encode(_ value: String, forKey key: Key) throws {
        try self.container.encode(value, forKey: try convertKey(key))
    }
    
    /// Encodes the given value for the given key.
    ///
    /// - parameter value: The value to encode.
    /// - parameter key: The key to associate the value with.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    public func encode(_ value: Double, forKey key: Key) throws {
        try self.container.encode(value, forKey: try convertKey(key))
    }
    
    /// Encodes the given value for the given key.
    ///
    /// - parameter value: The value to encode.
    /// - parameter key: The key to associate the value with.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    public func encode(_ value: Float, forKey key: Key) throws {
        try self.container.encode(value, forKey: try convertKey(key))
    }
    
    /// Encodes the given value for the given key.
    ///
    /// - parameter value: The value to encode.
    /// - parameter key: The key to associate the value with.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    public func encode(_ value: Int, forKey key: Key) throws {
        try self.container.encode(value, forKey: try convertKey(key))
    }
    
    /// Encodes the given value for the given key.
    ///
    /// - parameter value: The value to encode.
    /// - parameter key: The key to associate the value with.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    public func encode(_ value: Int8, forKey key: Key) throws {
        try self.container.encode(value, forKey: try convertKey(key))
    }
    
    /// Encodes the given value for the given key.
    ///
    /// - parameter value: The value to encode.
    /// - parameter key: The key to associate the value with.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    public func encode(_ value: Int16, forKey key: Key) throws {
        try self.container.encode(value, forKey: try convertKey(key))
    }
    
    /// Encodes the given value for the given key.
    ///
    /// - parameter value: The value to encode.
    /// - parameter key: The key to associate the value with.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    public func encode(_ value: Int32, forKey key: Key) throws {
        try self.container.encode(value, forKey: try convertKey(key))
    }
    
    /// Encodes the given value for the given key.
    ///
    /// - parameter value: The value to encode.
    /// - parameter key: The key to associate the value with.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    public func encode(_ value: Int64, forKey key: Key) throws {
        try self.container.encode(value, forKey: try convertKey(key))
    }
    
    /// Encodes the given value for the given key.
    ///
    /// - parameter value: The value to encode.
    /// - parameter key: The key to associate the value with.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    public func encode(_ value: UInt, forKey key: Key) throws {
        try self.container.encode(value, forKey: try convertKey(key))
    }
    
    /// Encodes the given value for the given key.
    ///
    /// - parameter value: The value to encode.
    /// - parameter key: The key to associate the value with.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    public func encode(_ value: UInt8, forKey key: Key) throws {
        try self.container.encode(value, forKey: try convertKey(key))
    }
    
    /// Encodes the given value for the given key.
    ///
    /// - parameter value: The value to encode.
    /// - parameter key: The key to associate the value with.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    public func encode(_ value: UInt16, forKey key: Key) throws {
        try self.container.encode(value, forKey: try convertKey(key))
    }
    
    /// Encodes the given value for the given key.
    ///
    /// - parameter value: The value to encode.
    /// - parameter key: The key to associate the value with.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    public func encode(_ value: UInt32, forKey key: Key) throws {
        try self.container.encode(value, forKey: try convertKey(key))
    }
    
    /// Encodes the given value for the given key.
    ///
    /// - parameter value: The value to encode.
    /// - parameter key: The key to associate the value with.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    public func encode(_ value: UInt64, forKey key: Key) throws {
        try self.container.encode(value, forKey: try convertKey(key))
    }
    
    /// Encodes the given value for the given key.
    ///
    /// - parameter value: The value to encode.
    /// - parameter key: The key to associate the value with.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    public func encode<T>(_ value: T, forKey key: Key) throws where T : Encodable {
        try self.container.encode(value, forKey: try convertKey(key))
    }
    
    /// Stores a keyed encoding container for the given key and returns it.
    ///
    /// - parameter keyType: The key type to use for the container.
    /// - parameter key: The key to encode the container for.
    /// - returns: A new keyed encoding container.
    public func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        return self.container.nestedContainer(keyedBy: keyType, forKey: try! convertKey(key))
    }
    
    /// Stores an unkeyed encoding container for the given key and returns it.
    ///
    /// - parameter key: The key to encode the container for.
    /// - returns: A new unkeyed encoding container.
    public func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
        return self.container.nestedUnkeyedContainer(forKey: try! convertKey(key))
    }
    
    /// Stores a new nested container for the default `super` key and returns A
    /// new encoder instance for encoding `super` into that container.
    ///
    /// Equivalent to calling `superEncoder(forKey:)` with
    /// `Key(stringValue: "super", intValue: 0)`.
    ///
    /// - returns: A new encoder to pass to `super.encode(to:)`.
    public func superEncoder() -> Encoder {
        return self.container.superEncoder()
    }
    
    /// Stores a new nested container for the given key and returns A new encoder
    /// instance for encoding `super` into that container.
    ///
    /// - parameter key: The key to encode `super` for.
    /// - returns: A new encoder to pass to `super.encode(to:)`.
    public func superEncoder(forKey key: Key) -> Encoder {
        return self.container.superEncoder(forKey: try! convertKey(key))
    }
}
