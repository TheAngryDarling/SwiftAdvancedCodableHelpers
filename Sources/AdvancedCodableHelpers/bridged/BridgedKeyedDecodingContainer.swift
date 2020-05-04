//
//  BridgedKeyDecodingContainer.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2018-11-05.
//

import Foundation

/// A decoding container class that bridges from one CodingKey type to another CodingKey type
public class BridgedKeyedDecodingContainer<FromKey, ToKey>: KeyedDecodingContainerProtocol where FromKey: CodingKey, ToKey: CodingKey {
    public typealias Key = ToKey
    
    /// The real container being used
    private var container: KeyedDecodingContainer<FromKey>
    /// The path of coding keys taken to get to this point in decoding.
    public let codingPath: [CodingKey]
    /// All the keys the `Decoder` has for this container.
    ///
    /// Different keyed containers from the same `Decoder` may return different
    /// keys here; it is possible to encode with multiple key types which are
    /// not convertible to one another. This should report all keys present
    /// which are convertible to the requested type.
    public var allKeys: [Key] {
        //return self.container.allKeys.compactMap({return Key(stringValue: $0.stringValue)})
        var rtn: [Key] = []
        for k in self.container.allKeys {
            if let key = Key(stringValue: k.stringValue) {
                rtn.append(key)
            }
        }
        return rtn
    }
    
    /// Creates a new Bridged Decoding Container
    ///
    /// - Parameters:
    ///   - container: The real container to retrieve the data from
    ///   - customCodingPath: Optional coding path to override the existing coding path.
    public init(_ container: KeyedDecodingContainer<FromKey>, customCodingPath: [CodingKey]? = nil) {
        self.container = container
        self.codingPath = customCodingPath ?? container.codingPath
    }
    
    /// Creates a new Bridged Deocding Container
    ///
    /// - Parameters:
    ///   - container: The real container to retrieve the data from
    ///   - customCodingPath: Optional coding path to override the existing coding path.
    public init<Container>(_ container: Container, customCodingPath: [CodingKey]? = nil) where FromKey == Container.Key, Container : KeyedDecodingContainerProtocol {
        self.container = KeyedDecodingContainer(container)
        self.codingPath = customCodingPath ?? container.codingPath
    }
    
    /// Helpful method of creating a KeyedDecodingContainer out of the current container
    ///
    /// - Returns: Returns a KeyedDecodingContainer wrapped around this instance
    public func toKeyedContainer() -> KeyedDecodingContainer<Key> {
        return KeyedDecodingContainer<Key>(self)
    }
    
    
    /// Converts a coding key from the wrapped to the key type of the stored container
    ///
    /// - Parameter from: Original key to convert
    /// - Returns: Returns
    /// - Throws: DecodingError.keyNotFound
    private func convertKey(_ from: Key) throws -> FromKey {
        guard let rtn = FromKey(stringValue: from.stringValue) else {
            throw DecodingError.keyNotFound(from, DecodingError.Context.init(codingPath: self.codingPath, debugDescription: "Could not convert key '\(from.stringValue)' of type \(type(of: from)) to type \(FromKey.self)"))
        }
        return rtn
    }
    
    /// Returns a Boolean value indicating whether the decoder contains a value
    /// associated with the given key.
    ///
    /// The value associated with `key` may be a null value as appropriate for
    /// the data format.
    ///
    /// - parameter key: The key to search for.
    /// - returns: Whether the `Decoder` has an entry for the given key.
    public func contains(_ key: Key) -> Bool {
        guard let fKey = FromKey(stringValue: key.stringValue) else { return false }
        return self.container.contains(fKey)
    }
    
    /// Decodes a null value for the given key.
    ///
    /// - parameter key: The key that the decoded value is associated with.
    /// - returns: Whether the encountered value was null.
    /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry
    ///   for the given key.
    public func decodeNil(forKey key: Key) throws -> Bool {
        return try self.container.decodeNil(forKey: try convertKey(key))
    }
    
    /// Decodes a value of the given type for the given key.
    ///
    /// - parameter type: The type of value to decode.
    /// - parameter key: The key that the decoded value is associated with.
    /// - returns: A value of the requested type, if present for the given key
    ///   and convertible to the requested type.
    /// - throws: `DecodingError.typeMismatch` if the encountered encoded value
    ///   is not convertible to the requested type.
    /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry
    ///   for the given key.
    /// - throws: `DecodingError.valueNotFound` if `self` has a null entry for
    ///   the given key.
    public func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        return try self.container.decode(type, forKey: try convertKey(key))
    }
    
    /// Decodes a value of the given type for the given key.
    ///
    /// - parameter type: The type of value to decode.
    /// - parameter key: The key that the decoded value is associated with.
    /// - returns: A value of the requested type, if present for the given key
    ///   and convertible to the requested type.
    /// - throws: `DecodingError.typeMismatch` if the encountered encoded value
    ///   is not convertible to the requested type.
    /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry
    ///   for the given key.
    /// - throws: `DecodingError.valueNotFound` if `self` has a null entry for
    ///   the given key.
    public func decode(_ type: String.Type, forKey key: Key) throws -> String {
        return try self.container.decode(type, forKey: try convertKey(key))
    }
    
    /// Decodes a value of the given type for the given key.
    ///
    /// - parameter type: The type of value to decode.
    /// - parameter key: The key that the decoded value is associated with.
    /// - returns: A value of the requested type, if present for the given key
    ///   and convertible to the requested type.
    /// - throws: `DecodingError.typeMismatch` if the encountered encoded value
    ///   is not convertible to the requested type.
    /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry
    ///   for the given key.
    /// - throws: `DecodingError.valueNotFound` if `self` has a null entry for
    ///   the given key.
    public func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        return try self.container.decode(type, forKey: try convertKey(key))
    }
    
    /// Decodes a value of the given type for the given key.
    ///
    /// - parameter type: The type of value to decode.
    /// - parameter key: The key that the decoded value is associated with.
    /// - returns: A value of the requested type, if present for the given key
    ///   and convertible to the requested type.
    /// - throws: `DecodingError.typeMismatch` if the encountered encoded value
    ///   is not convertible to the requested type.
    /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry
    ///   for the given key.
    /// - throws: `DecodingError.valueNotFound` if `self` has a null entry for
    ///   the given key.
    public func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        return try self.container.decode(type, forKey: try convertKey(key))
    }
    
    /// Decodes a value of the given type for the given key.
    ///
    /// - parameter type: The type of value to decode.
    /// - parameter key: The key that the decoded value is associated with.
    /// - returns: A value of the requested type, if present for the given key
    ///   and convertible to the requested type.
    /// - throws: `DecodingError.typeMismatch` if the encountered encoded value
    ///   is not convertible to the requested type.
    /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry
    ///   for the given key.
    /// - throws: `DecodingError.valueNotFound` if `self` has a null entry for
    ///   the given key.
    public func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        return try self.container.decode(type, forKey: try convertKey(key))
    }
    
    /// Decodes a value of the given type for the given key.
    ///
    /// - parameter type: The type of value to decode.
    /// - parameter key: The key that the decoded value is associated with.
    /// - returns: A value of the requested type, if present for the given key
    ///   and convertible to the requested type.
    /// - throws: `DecodingError.typeMismatch` if the encountered encoded value
    ///   is not convertible to the requested type.
    /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry
    ///   for the given key.
    /// - throws: `DecodingError.valueNotFound` if `self` has a null entry for
    ///   the given key.
    public func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        return try self.container.decode(type, forKey: try convertKey(key))
    }
    
    /// Decodes a value of the given type for the given key.
    ///
    /// - parameter type: The type of value to decode.
    /// - parameter key: The key that the decoded value is associated with.
    /// - returns: A value of the requested type, if present for the given key
    ///   and convertible to the requested type.
    /// - throws: `DecodingError.typeMismatch` if the encountered encoded value
    ///   is not convertible to the requested type.
    /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry
    ///   for the given key.
    /// - throws: `DecodingError.valueNotFound` if `self` has a null entry for
    ///   the given key.
    public func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        return try self.container.decode(type, forKey: try convertKey(key))
    }
    
    /// Decodes a value of the given type for the given key.
    ///
    /// - parameter type: The type of value to decode.
    /// - parameter key: The key that the decoded value is associated with.
    /// - returns: A value of the requested type, if present for the given key
    ///   and convertible to the requested type.
    /// - throws: `DecodingError.typeMismatch` if the encountered encoded value
    ///   is not convertible to the requested type.
    /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry
    ///   for the given key.
    /// - throws: `DecodingError.valueNotFound` if `self` has a null entry for
    ///   the given key.
    public func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        return try self.container.decode(type, forKey: try convertKey(key))
    }
    
    /// Decodes a value of the given type for the given key.
    ///
    /// - parameter type: The type of value to decode.
    /// - parameter key: The key that the decoded value is associated with.
    /// - returns: A value of the requested type, if present for the given key
    ///   and convertible to the requested type.
    /// - throws: `DecodingError.typeMismatch` if the encountered encoded value
    ///   is not convertible to the requested type.
    /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry
    ///   for the given key.
    /// - throws: `DecodingError.valueNotFound` if `self` has a null entry for
    ///   the given key.
    public func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        return try self.container.decode(type, forKey: try convertKey(key))
    }
    
    /// Decodes a value of the given type for the given key.
    ///
    /// - parameter type: The type of value to decode.
    /// - parameter key: The key that the decoded value is associated with.
    /// - returns: A value of the requested type, if present for the given key
    ///   and convertible to the requested type.
    /// - throws: `DecodingError.typeMismatch` if the encountered encoded value
    ///   is not convertible to the requested type.
    /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry
    ///   for the given key.
    /// - throws: `DecodingError.valueNotFound` if `self` has a null entry for
    ///   the given key.
    public func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        return try self.container.decode(type, forKey: try convertKey(key))
    }
    
    /// Decodes a value of the given type for the given key.
    ///
    /// - parameter type: The type of value to decode.
    /// - parameter key: The key that the decoded value is associated with.
    /// - returns: A value of the requested type, if present for the given key
    ///   and convertible to the requested type.
    /// - throws: `DecodingError.typeMismatch` if the encountered encoded value
    ///   is not convertible to the requested type.
    /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry
    ///   for the given key.
    /// - throws: `DecodingError.valueNotFound` if `self` has a null entry for
    ///   the given key.
    public func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        return try self.container.decode(type, forKey: try convertKey(key))
    }
    
    /// Decodes a value of the given type for the given key.
    ///
    /// - parameter type: The type of value to decode.
    /// - parameter key: The key that the decoded value is associated with.
    /// - returns: A value of the requested type, if present for the given key
    ///   and convertible to the requested type.
    /// - throws: `DecodingError.typeMismatch` if the encountered encoded value
    ///   is not convertible to the requested type.
    /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry
    ///   for the given key.
    /// - throws: `DecodingError.valueNotFound` if `self` has a null entry for
    ///   the given key.
    public func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        return try self.container.decode(type, forKey: try convertKey(key))
    }
    
    /// Decodes a value of the given type for the given key.
    ///
    /// - parameter type: The type of value to decode.
    /// - parameter key: The key that the decoded value is associated with.
    /// - returns: A value of the requested type, if present for the given key
    ///   and convertible to the requested type.
    /// - throws: `DecodingError.typeMismatch` if the encountered encoded value
    ///   is not convertible to the requested type.
    /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry
    ///   for the given key.
    /// - throws: `DecodingError.valueNotFound` if `self` has a null entry for
    ///   the given key.
    public func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        return try self.container.decode(type, forKey: try convertKey(key))
    }
    
    /// Decodes a value of the given type for the given key.
    ///
    /// - parameter type: The type of value to decode.
    /// - parameter key: The key that the decoded value is associated with.
    /// - returns: A value of the requested type, if present for the given key
    ///   and convertible to the requested type.
    /// - throws: `DecodingError.typeMismatch` if the encountered encoded value
    ///   is not convertible to the requested type.
    /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry
    ///   for the given key.
    /// - throws: `DecodingError.valueNotFound` if `self` has a null entry for
    ///   the given key.
    public func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        return try self.container.decode(type, forKey: try convertKey(key))
    }
    
    /// Decodes a value of the given type for the given key.
    ///
    /// - parameter type: The type of value to decode.
    /// - parameter key: The key that the decoded value is associated with.
    /// - returns: A value of the requested type, if present for the given key
    ///   and convertible to the requested type.
    /// - throws: `DecodingError.typeMismatch` if the encountered encoded value
    ///   is not convertible to the requested type.
    /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry
    ///   for the given key.
    /// - throws: `DecodingError.valueNotFound` if `self` has a null entry for
    ///   the given key.
    public func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T : Decodable {
        return try self.container.decode(type, forKey: try convertKey(key))
    }
    
    /// Returns the data stored for the given key as represented in a container
    /// keyed by the given key type.
    ///
    /// - parameter type: The key type to use for the container.
    /// - parameter key: The key that the nested container is associated with.
    /// - returns: A keyed decoding container view into `self`.
    /// - throws: `DecodingError.typeMismatch` if the encountered stored value is
    ///   not a keyed container.
    public func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        return try self.container.nestedContainer(keyedBy: type, forKey: try convertKey(key))
    }
    
    /// Returns the data stored for the given key as represented in an unkeyed
    /// container.
    ///
    /// - parameter key: The key that the nested container is associated with.
    /// - returns: An unkeyed decoding container view into `self`.
    /// - throws: `DecodingError.typeMismatch` if the encountered stored value is
    ///   not an unkeyed container.
    public func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
        return try self.container.nestedUnkeyedContainer(forKey: try convertKey(key))
    }
    
    /// Returns a `Decoder` instance for decoding `super` from the container
    /// associated with the default `super` key.
    ///
    /// Equivalent to calling `superDecoder(forKey:)` with
    /// `Key(stringValue: "super", intValue: 0)`.
    ///
    /// - returns: A new `Decoder` to pass to `super.init(from:)`.
    /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry
    ///   for the default `super` key.
    /// - throws: `DecodingError.valueNotFound` if `self` has a null entry for
    ///   the default `super` key.
    public func superDecoder() throws -> Decoder {
        return try self.container.superDecoder()
    }
    
    /// Returns a `Decoder` instance for decoding `super` from the container
    /// associated with the given key.
    ///
    /// - parameter key: The key to decode `super` for.
    /// - returns: A new `Decoder` to pass to `super.init(from:)`.
    /// - throws: `DecodingError.keyNotFound` if `self` does not have an entry
    ///   for the given key.
    /// - throws: `DecodingError.valueNotFound` if `self` has a null entry for
    ///   the given key.
    public func superDecoder(forKey key: Key) throws -> Decoder {
        return try self.container.superDecoder(forKey: try convertKey(key))
    }
    
}
