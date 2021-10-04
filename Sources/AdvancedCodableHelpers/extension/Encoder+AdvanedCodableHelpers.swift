//
//  Encoder+AdvanedCodableHelpers.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2021-02-25.
//

import Foundation
import BasicCodableHelpers
import SwiftClassCollections

/// Simple encoding to capture an encoded value
fileprivate class _SimpleEncoder: Encoder, SingleValueEncodingContainer {
    
    
    /// The path of coding keys taken to get to this point in encoding.
    var codingPath: [CodingKey] = []
    
    var userInfo: [CodingUserInfoKey : Any] = [:]
    
    var value: Any? = nil
    
    /// Returns an encoding container appropriate for holding multiple values
    /// keyed by the given key type.
    ///
    /// You must use only one kind of top-level encoding container. This method
    /// must not be called after a call to `unkeyedContainer()` or after
    /// encoding a value through a call to `singleValueContainer()`
    ///
    /// - parameter type: The key type to use for the container.
    /// - returns: A new keyed encoding container.
    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        fatalError("Unsupported Method")
    }
    
    /// Returns an encoding container appropriate for holding multiple unkeyed
    /// values.
    ///
    /// You must use only one kind of top-level encoding container. This method
    /// must not be called after a call to `container(keyedBy:)` or after
    /// encoding a value through a call to `singleValueContainer()`
    ///
    /// - returns: A new empty unkeyed container.
    func unkeyedContainer() -> UnkeyedEncodingContainer {
        fatalError("Unsupported Method")
    }
    
    /// Returns an encoding container appropriate for holding a single primitive
    /// value.
    ///
    /// You must use only one kind of top-level encoding container. This method
    /// must not be called after a call to `unkeyedContainer()` or
    /// `container(keyedBy:)`, or after encoding a value through a call to
    /// `singleValueContainer()`
    ///
    /// - returns: A new empty single value container.
    func singleValueContainer() -> SingleValueEncodingContainer {
        return self
    }
    
    /// Encodes a null value.
    ///
    /// - throws: `EncodingError.invalidValue` if a null value is invalid in the
    ///   current context for this format.
    /// - precondition: May not be called after a previous `self.encode(_:)`
    ///   call.
    func encodeNil() throws {
        self.value = nil
    }
    
    /// Encodes a single value of the given type.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    /// - precondition: May not be called after a previous `self.encode(_:)`
    ///   call.
    func encode(_ value: Bool) throws {
        self.value = value
    }
    
    /// Encodes a single value of the given type.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    /// - precondition: May not be called after a previous `self.encode(_:)`
    ///   call.
    func encode(_ value: String) throws {
        self.value = value
    }
    
    /// Encodes a single value of the given type.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    /// - precondition: May not be called after a previous `self.encode(_:)`
    ///   call.
    func encode(_ value: Double) throws {
        self.value = value
    }
    
    /// Encodes a single value of the given type.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    /// - precondition: May not be called after a previous `self.encode(_:)`
    ///   call.
    func encode(_ value: Float) throws {
        self.value = value
    }
    
    /// Encodes a single value of the given type.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    /// - precondition: May not be called after a previous `self.encode(_:)`
    ///   call.
    func encode(_ value: Int) throws {
        self.value = value
    }
    
    /// Encodes a single value of the given type.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    /// - precondition: May not be called after a previous `self.encode(_:)`
    ///   call.
    func encode(_ value: Int8) throws {
        self.value = value
    }
    
    /// Encodes a single value of the given type.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    /// - precondition: May not be called after a previous `self.encode(_:)`
    ///   call.
    func encode(_ value: Int16) throws {
        self.value = value
    }
    
    /// Encodes a single value of the given type.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    /// - precondition: May not be called after a previous `self.encode(_:)`
    ///   call.
    func encode(_ value: Int32) throws {
        self.value = value
    }
    
    /// Encodes a single value of the given type.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    /// - precondition: May not be called after a previous `self.encode(_:)`
    ///   call.
    func encode(_ value: Int64) throws {
        self.value = value
    }
    
    /// Encodes a single value of the given type.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    /// - precondition: May not be called after a previous `self.encode(_:)`
    ///   call.
    func encode(_ value: UInt) throws {
        self.value = value
    }
    
    /// Encodes a single value of the given type.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    /// - precondition: May not be called after a previous `self.encode(_:)`
    ///   call.
    func encode(_ value: UInt8) throws {
        self.value = value
    }
    
    /// Encodes a single value of the given type.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    /// - precondition: May not be called after a previous `self.encode(_:)`
    ///   call.
    func encode(_ value: UInt16) throws {
        self.value = value
    }
    
    /// Encodes a single value of the given type.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    /// - precondition: May not be called after a previous `self.encode(_:)`
    ///   call.
    func encode(_ value: UInt32) throws {
        self.value = value
    }
    
    /// Encodes a single value of the given type.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    /// - precondition: May not be called after a previous `self.encode(_:)`
    ///   call.
    func encode(_ value: UInt64) throws {
        self.value = value
    }
    
    /// Encodes a single value of the given type.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    /// - precondition: May not be called after a previous `self.encode(_:)`
    ///   call.
    func encode<T>(_ value: T) throws where T : Encodable {
        self.value = value
    }
}

public enum DynamicElementEncodingErrors: Error {
    /// Error occurs when real conatiner has not be set before the end of the dynamicElementEncoding call
    case realContainerNotSet
}

public extension Encoder {
    
    /// Provides an easy method to encode an array of encodable objects in a dynamic way
    ///
    /// The following rules apply when encoding:
    /// 1. If collection count is 1, encodes the object as a single value and not an array
    /// 2. Encodes as a regular array
    ///
    /// - Parameters:
    ///   - collection: The collection to encode
    ///   - encoder: The encoder to encode the objects to
    @discardableResult
    func encodeToSingleOrArray<C>(_ collection: C) throws -> SingleOrArrayEncodedAs  where C: Collection, C.Element: Encodable {
        
        if collection.count == 1 {
            var container = self.singleValueContainer()
            try container.encode(collection[collection.startIndex])
            return .single
        } else {
            var container = self.unkeyedContainer()
            for o in collection {
                try container.encode(o)
            }
            return .array
        }
    }
    
    /// Tests to see if two CodingKey arrays match
    ///
    /// - Parameters:
    ///   - lhs: CodingPath A
    ///   - rhs: CodingPath B
    /// - Returns: Returns true of the two arrays equal, otherwise false
    private func codingKeysMatch(_ lhs: [CodingKey], _ rhs: [CodingKey]) -> Bool {
        guard lhs.count == rhs.count else { return false }
        for i in 0..<lhs.count {
            if lhs[i].stringValue != rhs[i].stringValue { return false }
        }
        return true
    }
    /// Provides an easy way of encoding an array of objects like a dictionary using one of the object properties as the key.
    ///
    /// Note: Array order is not guarenteed.  This is dependant on how the the EncodingType handles Dictionaries
    ///
    ///     struct EncodingElement: Encodable {
    ///         let id: String
    ///         let variableA: Int
    ///         let variableB: Bool
    ///     }
    ///
    ///     let objects: [EncodingElement] = [...]
    ///
    ///     try CodableHelpers.sequences.dynamicElementEncoding(objects, to: encoder, elementKey: "id")
    ///
    ///     // This converts the encoded objects to (in JSON)
    ///     {
    ///         "{id}": { variableA: 3, variableB: false },
    ///         ...
    ///     }
    ///
    /// - Parameters:
    ///   - s: Sequence of Encodable elements to dynamically encode
    ///   - elementKey: The CodingKey within the Element to encode to
    func dynamicElementEncoding<S>(_ s: S,
                                   usingKey elementKey: String) throws where S: Sequence, S.Element: Encodable {
        var container = self.container(keyedBy: CodableKey.self)
        
        for (_, element) in s.enumerated() { // Loop through each element in the sequrence
            // Create a new encoding container for the element.
            // This container is a filetered delayed container, meaining
            // 1. Filtered, calls filter method to filter out specific objects based on filter method
            // 2. Delayed, delays the actual writting of the object to the encoder until the root Delayed Encoder initialzeContainer has been called
            //    Any call to encode after the initializeContainer has been will directly be encoded to the real encoder
            let dContainer = FilteredDelayedKeyedEncodingContainer<CodableKey>(codingPath: container.codingPath) { root, c, method, key, value in
                var allowEncodingOfProperty: Bool = true
                
                if let k = key, let v = value, self.codingKeysMatch(c.codingPath, container.codingPath) && k.stringValue == elementKey {
                    var workingValue = v
                    if let eV = workingValue as? Encodable, type(of: workingValue) != String.self {
                        let simpleEncoder = _SimpleEncoder()
                        // propogate user info from parent encoder to simple encoder
                        simpleEncoder.userInfo = self.userInfo
                        simpleEncoder.codingPath = c.codingPath
                        try eV.encode(to: simpleEncoder)
                        guard let sV = simpleEncoder.value else {
                            var workingCodingKey = c.codingPath
                            if let k =  key { workingCodingKey.append(k) }
                            throw DecodingError._typeMismatch(at: workingCodingKey, expectation: String.self, reality: simpleEncoder.value as Any)
                        }
                        workingValue = sV
                    }
                    
                    guard let keyValue = workingValue as? String else {
                        var workingCodingKey = c.codingPath
                        if let k =  key { workingCodingKey.append(k) }
                        throw DecodingError._typeMismatch(at: workingCodingKey, expectation: String.self, reality: workingValue)
                    }
                    
                    let nameKey = CodableKey(stringValue: keyValue)
                    
                    // This must be called once or encoding won't happen
                    try (root as! FilteredDelayedKeyedEncodingContainer<CodableKey>).initializeContainer(fromParent: &container,
                                                                                                         forKey: nameKey)
                    
                    allowEncodingOfProperty = false
                }
                
                return allowEncodingOfProperty
                
            }
            
            
            let subEncoder = WrappedKeyedEncoder(dContainer)
            
            try element.encode(to: subEncoder)
            guard dContainer.wasContainerSet else {
                //fatalError("Real container was not set")
                throw DynamicElementEncodingErrors.realContainerNotSet
            }
        }
    }
    
    /// Encode a dictionary to a encoder
    ///
    /// - Parameters:
    ///   - dictionary: Any dictionary type where the Key is DictionaryKeyCodable and Value is Any where can cast to Encodable
    func encodeAnyDictionary<D>(_ dictionary: D) throws where D: SDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
        var container = self.container(keyedBy: CodableKey.self)
        try container._encodeAnyDictionary(dictionary)
    }
    
    /// Encode an optional dictionary to a container
    ///
    /// - Parameters:
    ///   - dictionary: Any dictionary type where the Key is DictionaryKeyCodable and Value is Any where can cast to Encodable
    ///   - container: The container to encode to
    /// - Returns: Returns a bool indicator if an object was encoded or not
    @discardableResult
    func encodeAnyDictionaryIfPresent<D>(_ dictionary: D?) throws -> Bool where D: SDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
        guard let d = dictionary else { return false }
        try self.encodeAnyDictionary(d)
        return true
    }
    
    /// Encodes an array of Any to the container
    ///
    /// Note: All objects within the array must implement the Encodable protocol
    ///
    /// - Parameters:
    ///   - array: The array of objects to encode
    /// - Throws: EncodingError.invalidValue if the object can not encoded
    func encode<S>(_ array: S) throws where S: Sequence, S.Element == Any {
        var container = self.unkeyedContainer()
        try container._encodeAnyArray(array)
    }
    
    /// Encodes an array of Any to an UnkeyedEncodingContainer if possible
    ///
    /// Note: All objects within the array must implement the Encodable protocol
    ///
    /// - Parameters:
    ///   - array: The array of objects to encode
    /// - Returns: Returns an indicator if the object was encoded or not
    /// - Throws: EncodingError.invalidValue if the object can not encoded
    @discardableResult
    func encodeIfPresent<S>(_ array: S?) throws -> Bool where S: Sequence, S.Element == Any {
        guard let a = array else { return false }
        try self.encode(a)
        return true
    }
}
