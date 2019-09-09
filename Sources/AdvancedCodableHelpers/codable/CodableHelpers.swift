//
//  AdvancedCodableHelpers.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2019-03-23.
//

import Foundation
import SwiftClassCollections
import Nillable
import BasicCodableHelpers



/// Strcture namespace that contains all helper methods for working with Encodable/Decodable
public struct CodableHelpers {
    
    private init() { }
    
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
    
    /// Tests to see if two CodingKey arrays match
    ///
    /// - Parameters:
    ///   - lhs: CodingPath A
    ///   - rhs: CodingPath B
    /// - Returns: Returns true of the two arrays equal, otherwise false
    private static func codingKeysMatch(_ lhs: [CodingKey], _ rhs: [CodingKey]) -> Bool {
        guard lhs.count == rhs.count else { return false }
        for i in 0..<lhs.count {
            if lhs[i].stringValue != rhs[i].stringValue { return false }
        }
        return true
    }
    
    /// Decodes a KeyedDecodingContainer into a SCArrayOrderedDictionary
    ///
    /// - Parameters:
    ///   - container: The decoding container to decode from
    ///   - excludingKeys: Any keys to exclude from the top level
    ///   - customDecoding: Custom decoder function for custom decoding of complex objects
    /// - Returns: Returns either SCArrayOrderedDictionary<String, Any> or SCArrayOrderedDictionary<Int, Any> depending on the CodableKey type
    private static func _decode(_ container: inout KeyedDecodingContainer<CodableKey>,
                                excludingKeys: [CodableKey],
                                customDecoding: (_ decoder: Decoder) throws -> Any?) throws -> Any {
        
        let keys = container.allKeys
        if keys.count > 0 && keys[0].intValue != nil {
            let rtn = SCArrayOrderedDictionary<Int, Any>()
            
            for key in keys {
                guard !excludingKeys.contains(where: { $0.stringValue == key.stringValue }) else {
                    continue
                }
                
                var customValue: Any? = nil
                do {
                    customValue = try customDecoding(WrappedPreKeyedDecoder(container, preKey: key))
                } catch { }
                
                if let v = customValue {
                    rtn[key.intValue!] = v
                } else if let v = try? container.decodeNil(forKey: key), v {
                    rtn[key.intValue!] = AnyNil //(nil as Any)
                } else if let v = try? container.decode(Int.self, forKey: key) {
                    rtn[key.intValue!] = v
                } else if let v = try? container.decode(UInt.self, forKey: key) {
                    rtn[key.intValue!] = v
                } else if let v = try? container.decode(Float.self, forKey: key) {
                    rtn[key.intValue!] = v
                } else if let v = try? container.decode(String.self, forKey: key) {
                    rtn[key.intValue!] = v
                } else if let v = try? container.decode(Double.self, forKey: key) {
                    rtn[key.intValue!] = v
                } else if let v = try? container.decode(Bool.self, forKey: key) {
                    rtn[key.intValue!] = v
                } else if let v = try? container.decode(Date.self, forKey: key) {
                    rtn[key.intValue!] = v
                } else if let v = try? container.decode(Data.self, forKey: key) {
                    rtn[key.intValue!] = v
                } else if var v = try? container.nestedContainer(keyedBy: CodableKey.self, forKey: key) {
                    rtn[key.intValue!] = try _decode(&v, excludingKeys: [], customDecoding: customDecoding)
                } else if var v = try? container.nestedUnkeyedContainer(forKey: key) {
                    rtn[key.intValue!] = try CodableHelpers.arrays.decode(&v, customDecoding: customDecoding)
                } else {
                    throw DecodingError.typeMismatch(Any.self,
                                                     DecodingError.Context(codingPath: container.codingPath.appending(key),
                                                                           debugDescription: "Unsupported type"))
                }
            }
            
            return rtn
        } else {
            let rtn = SCArrayOrderedDictionary<String, Any>()
            
            for key in keys {
                guard !excludingKeys.contains(where: { $0.stringValue == key.stringValue }) else {
                    continue
                }
                
                var customValue: Any? = nil
                do {
                    customValue = try customDecoding(WrappedPreKeyedDecoder(container, preKey: key))
                } catch { }
                
                if let v = customValue {
                    rtn[key.stringValue] = v
                } else if let v = try? container.decodeNil(forKey: key), v {
                    rtn[key.stringValue] = AnyNil //(nil as Any)
                } else if let v = try? container.decode(Int.self, forKey: key) {
                    rtn[key.stringValue] = v
                } else if let v = try? container.decode(UInt.self, forKey: key) {
                    rtn[key.stringValue] = v
                } else if let v = try? container.decode(Float.self, forKey: key) {
                    rtn[key.stringValue] = v
                } else if let v = try? container.decode(String.self, forKey: key) {
                    rtn[key.stringValue] = v
                } else if let v = try? container.decode(Double.self, forKey: key) {
                    rtn[key.stringValue] = v
                } else if let v = try? container.decode(Bool.self, forKey: key) {
                    rtn[key.stringValue] = v
                } else if let v = try? container.decode(Date.self, forKey: key) {
                    rtn[key.stringValue] = v
                } else if let v = try? container.decode(Data.self, forKey: key) {
                    rtn[key.stringValue] = v
                } else if var v = try? container.nestedContainer(keyedBy: CodableKey.self, forKey: key) {
                    rtn[key.stringValue] = try _decode(&v, excludingKeys: [], customDecoding: customDecoding)
                } else if var v = try? container.nestedUnkeyedContainer(forKey: key) {
                    rtn[key.stringValue] = try CodableHelpers.arrays.decode(&v, customDecoding: customDecoding)
                } else {
                    throw DecodingError.typeMismatch(Any.self,
                                                     DecodingError.Context(codingPath: container.codingPath.appending(key),
                                                                           debugDescription: "Unsupported type"))
                }
            }
            
            return rtn
        }
    }
    
    /// A collection of helper methods for working with Sequence's
    public struct sequences {
        
        
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
        ///   - encoder: The encoder to encode the objects to
        ///   - elementKey: The CodingKey within the Element to encode to
        public static func dynamicElementEncoding<S>(_ s: S,
                                                     to encoder: Encoder,
                                                     usingKey elementKey: String) throws where S: Sequence, S.Element: Encodable {
            var container = encoder.container(keyedBy: CodableKey.self)
            
            for (_, element) in s.enumerated() { // Loop through each element in the sequrence
                // Create a new encoding container for the element.
                // This container is a filetered delayed container, meaining
                // 1. Filtered, calls filter method to filter out specific objects based on filter method
                // 2. Delayed, delays the actual writting of the object to the encoder until the root Delayed Encoder initialzeContainer has been called
                //    Any call to encode after the initializeContainer has been will directly be encoded to the real encoder
                let dContainer = FilteredDelayedKeyedEncodingContainer<CodableKey>(codingPath: container.codingPath) { root, c, method, key, value in
                    var allowEncodingOfProperty: Bool = true
                    
                    if let k = key, let v = value, codingKeysMatch(c.codingPath, container.codingPath) && k.stringValue == elementKey {
                        var workingValue = v
                        if let eV = workingValue as? Encodable, type(of: workingValue) != String.self {
                            let simpleEncoder = _SimpleEncoder()
                            // propogate user info from parent encoder to simple encoder
                            simpleEncoder.userInfo = encoder.userInfo
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
                    fatalError("Real container was not set")
                }
                
                
            }
        }
        
        /// Private helper object for encoding dynamic keyed arrays
        fileprivate struct EncodableObject<Objects>: Encodable where Objects: Sequence, Objects.Element: Encodable {
            private let objects: Objects
            private let elementKey: String
            
            public init(objects: Objects, elementKey: String) {
                self.objects = objects
                self.elementKey = elementKey
            }
            
            public func encode(to encoder: Encoder) throws {
                try CodableHelpers.sequences.dynamicElementEncoding(objects, to: encoder, usingKey: elementKey)
            }
            
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
        ///     try CodableHelpers.sequences.dynamicElementEncoding(objects, to: encoder, usingKey: "id")
        ///
        ///     // This converts the encoded objects to (in JSON)
        ///     {
        ///         "{id}": { variableA: 3, variableB: false },
        ///         ...
        ///     }
        ///
        /// - Parameters:
        ///   - s: Sequence of Encodable elements to dynamically encode
        ///   - encoder: The encoder to encode the objects to
        ///   - elementKey: The CodingKey within the Element to encode to
        public static func dynamicElementEncoding<S, E>(_ s: S,
                                                     to encoder: E,
                                                     usingKey elementKey: String) throws -> E.EncodedData where S: Sequence, S.Element: Encodable, E: EncoderType {
            
            
            return try encoder.encode(EncodableObject(objects: s, elementKey: elementKey))
        }
        
        
        /// Provides an easy way of decoding dictionaries of objects like an array using the key as one of the object property values.
        ///
        /// Note: Array order is not guarenteed.  This is dependant on how the the DecodingType handles Dictionaries
        ///
        ///     struct EncodingElement: Decodable {
        ///         let id: String
        ///         let variableA: Int
        ///         let variableB: Bool
        ///     }
        ///
        ///     // JSON data that is in the decoder
        ///     {
        ///         "{id}": { variableA: 3, variableB: false },
        ///         ...
        ///     }
        ///
        ///     let objects = try dynamicElementDecoding(from: decoder, usingKey: "id") {
        ///         return try EncodingElement(from: $0)
        ///     }
        ///
        /// - Parameters:
        ///   - decoder: The decoder to decode the objects from
        ///   - elementKey: The coding key
        ///   - decodingFunc: Function used for decoding data into specific object type.  This helps when the array is a base type/protocol while the instances could be different inherited types
        /// - Returns: Returns an array of decoded objects
        public static func dynamicElementDecoding<Element>(from decoder: Decoder,
                                                           usingKey elementKey: String,
                                                           decodingFunc: (_ decoder: Decoder) throws -> Element) throws -> Array<Element> {
            var list: [Element] = []
            let container = try decoder.container(keyedBy: CodableKey.self)
            //print("Current Container Type: \(type(of: container)), Current coding path: \(container.codingPath.stringPath)")
            for key in container.allKeys {
                let elementContainer = try container.nestedContainer(keyedBy: CodableKey.self, forKey: key)
                //print("\t Sub Container Type: \(type(of: elementContainer)), Sub Key: \(key.stringValue), Sub coding path: \(elementContainer.codingPath.stringPath)")
                // Must decode element here
                let injectableContainer = WrappedInjectedKeyedDecodingContainer<CodableKey>(elementContainer,
                                                                                            injection: (key: elementKey, key.stringValue))
                //print("\t Sub2 Container Type: \(type(of: injectableContainer)), Sub Key: \(key.stringValue), Sub coding path: \(injectableContainer.codingPath.stringPath)")
                let subDecoder = WrappedKeyedDecoder<CodableKey>(injectableContainer)
                
                //print("\t Sub Decoder Type: \(type(of: subDecoder)), Sub Key: \(key.stringValue), Sub Decoder coding path: \(subDecoder.codingPath.stringPath)")
                
                let newElement = try decodingFunc(subDecoder)
                list.append(newElement)
            }
            
            return list
         }
        
        
        
        /// Provides an easy way of decoding dictionaries of objects like an array using the key as one of the object property values.
        ///
        /// Note: Array order is not guarenteed.  This is dependant on how the the DecodingType handles Dictionaries
        ///
        ///     struct EncodingElement: Decodable {
        ///         let id: String
        ///         let variableA: Int
        ///         let variableB: Bool
        ///     }
        ///
        ///     // JSON data that is in the decoder
        ///     {
        ///         "{id}": { variableA: 3, variableB: false },
        ///         ...
        ///     }
        ///
        ///     let objects = try dynamicElementDecoding(from: decoder, usingKey: "id", ofType: EncodingElement.self)
        ///
        /// - Parameters:
        ///   - decoder: The decoder to decode the objects from
        ///   - elementKey: The coding key
        ///   - ofType: The decodable type to decode to
        /// - Returns: Returns an array of decoded objects
        public static func dynamicElementDecoding<Element>(from decoder: Decoder,
                                                           usingKey elementKey: String,
                                                           ofType: Element.Type) throws -> Array<Element> where Element: Decodable {
            return try dynamicElementDecoding(from: decoder, usingKey: elementKey) { (decoder: Decoder) throws -> Element in
                return try Element(from: decoder)
            }
        }
        
        
        /// Provides an easy way of decoding dictionaries of objects like an array using the key as one of the object property values.
        ///
        /// Note: Array order is not guarenteed.  This is dependant on how the the DecodingType handles Dictionaries
        ///
        ///     struct EncodingElement: Decodable {
        ///         let id: String
        ///         let variableA: Int
        ///         let variableB: Bool
        ///     }
        ///
        ///     // JSON data that is in the decoder
        ///     {
        ///         "{id}": { variableA: 3, variableB: false },
        ///         ...
        ///     }
        ///
        ///     let objects = try dynamicElementDecoding(decoder: decoder, withData: data, usingKey: "id") {
        ///         return try EncodingElement(from: $0)
        ///     }
        ///
        /// - Parameters:
        ///   - decoder: The decoder to decode the data from
        ///   - data: The data to decode from
        ///   - elementKey: The coding key
        ///   - decodingFunc: Function used for decoding data into specific object type.  This helps when the array is a base type/protocol while the instances could be different inherited types
        /// - Returns: Returns an array of decoded objects
        public static func dynamicElementDecoding<D, Element>(from decoder: D,
                                                              withData data: D.EncodedData,
                                                              usingKey elementKey: String,
                                                              decodingFunc: (_ decoder: Decoder) throws -> Element) throws -> Array<Element> where D: DecoderType {
            let dc = try decoder.decode(DecoderCatcher.self, from: data)
            
            return try dynamicElementDecoding(from: dc.decoder, usingKey: elementKey, decodingFunc: decodingFunc)
            
            
            
        }
        
        /// Provides an easy way of decoding dictionaries of objects like an array using the key as one of the object property values.
        ///
        /// Note: Array order is not guarenteed.  This is dependant on how the the DecodingType handles Dictionaries
        ///
        ///     struct EncodingElement: Decodable {
        ///         let id: String
        ///         let variableA: Int
        ///         let variableB: Bool
        ///     }
        ///
        ///     // JSON data that is in the decoder
        ///     {
        ///         "{id}": { variableA: 3, variableB: false },
        ///         ...
        ///     }
        ///
        ///     let objects = try dynamicElementDecoding(decoder: decoder, withData: data, usingKey: "id", ofType: EncodingElement.self)
        ///
        /// - Parameters:
        ///   - decoder: The decoder to decode the data from
        ///   - data: The data to decode from
        ///   - elementKey: The coding key
        ///   - ofType: The decodable type to decode to
        /// - Returns: Returns an array of decoded objects
        public static func dynamicElementDecoding<D, Element>(from decoder: D,
                                                              withData data: D.EncodedData,
                                                              usingKey elementKey: String,
                                                              ofType: Element.Type) throws -> Array<Element> where D: DecoderType, Element: Decodable {
            
            return try dynamicElementDecoding(from: decoder, withData: data, usingKey: elementKey) { (decoder: Decoder) throws -> Element in
                return try Element(from: decoder)
            }
            
            
        }
    }
    
    
}

extension CodableHelpers {
    public struct arrays {
        private init() { }
        
        /// Encodes an array of Any to an UnkeyedEncodingContainer if possible
        ///
        /// Note: All objects within the array must implement the Encodable protocol
        ///
        /// - Parameters:
        ///   - array: The array of objects to encode
        ///   - container: The container to encode the objects to
        /// - Throws: EncodingError.invalidValue if the object can not encoded
        public static func encode<S>(_ array: S,
                                      to container: inout UnkeyedEncodingContainer) throws where S: Sequence, S.Element == Any {
            //let path = container.codingPath.last?.stringValue ?? ""
            for (i, v) in array.enumerated() {
                if let dV = v as? Dictionary<String, Any> {
                    var subContainer = container.nestedContainer(keyedBy: CodableKey.self)
                    try dictionaries.encode(dV, to: &subContainer)
                } else if let dV = v as? Dictionary<Int, Any> {
                    var subContainer = container.nestedContainer(keyedBy: CodableKey.self)
                    try dictionaries.encode(dV, to: &subContainer)
                } else if let dV = v as? SCDictionary<String, Any> {
                    var subContainer = container.nestedContainer(keyedBy: CodableKey.self)
                    try dictionaries.encode(dV, to: &subContainer)
                } else if let dV = v as? SCDictionary<Int, Any> {
                    var subContainer = container.nestedContainer(keyedBy: CodableKey.self)
                    try dictionaries.encode(dV, to: &subContainer)
                } else if let dV = v as? SCArrayOrderedDictionary<String, Any> {
                    var subContainer = container.nestedContainer(keyedBy: CodableKey.self)
                    try dictionaries.encode(dV, to: &subContainer)
                } else if let dV = v as? SCArrayOrderedDictionary<Int, Any> {
                    var subContainer = container.nestedContainer(keyedBy: CodableKey.self)
                    try dictionaries.encode(dV, to: &subContainer)
                } else if let aV = v as? Array<Any> {
                    var subContainer = container.nestedUnkeyedContainer()
                    try encode(aV, to: &subContainer)
                } else if let aV = v as? SCArray<Any> {
                    var subContainer = container.nestedUnkeyedContainer()
                    try encode(aV, to: &subContainer)
                } else if let nV = v as? Nillable, nV.isNil {
                    try container.encodeNil()
                } else if let eV = v as? Encodable {
                    let wrappedEncoder = WrappedSingleValueEncoder(container.superEncoder().singleValueContainer())
                    try eV.encode(to: wrappedEncoder)
                    /*let wrappedEncoder = WrappedUnKeyedEncoder(container)
                     try eV.encode(to: wrappedEncoder)*/
                } else {
                    let description = "Expected value to conform to Encodable but found \(type(of: v)) instead."
                    throw EncodingError.invalidValue(v, EncodingError.Context(codingPath: container.codingPath.appending(index: i), debugDescription: description))
                }
            }
        }
        
        /// Encodes an array of Any to a KeyedEncodingContainer if possible
        ///
        /// Note: All objects within the array must implement the Encodable protocol
        /// This will create an UnkeyedEncodingContainer with the key 'key' and call the
        /// encode(_: Sequence, to: UnkeyedEncodingContainer)
        ///
        /// - Parameters:
        ///   - array: The array of objects to encode
        ///   - container: The container to encode the objects to
        /// - Throws: EncodingError.invalidValue if the object can not encoded
        public static func encode<K, S>(_ array: S,
                                        in container: inout KeyedEncodingContainer<K>,
                                        forKey key: K) throws where S: SArray, S.Element == Any {
            var childContainer = container.nestedUnkeyedContainer(forKey: key)
            try self.encode(array, to: &childContainer)
        }
        
        /// Encodes an array of Any to a Encoder if possible
        ///
        /// Note: All objects within the array must implement the Encodable protocol
        /// This will create an UnkeyedEncodingContainer from the encoder then call
        /// encode(_: Sequence, to: UnkeyedEncodingContainer)
        ///
        /// - Parameters:
        ///   - array: The array of objects to encode
        ///   - encoder: The encoder to encode the array to
        /// - Throws: EncodingError.invalidValue if the object can not encoded
        public static func encode<S>(_ array: S,
                                     to encoder: Encoder) throws where S: SArray, S.Element == Any {
            var container = encoder.unkeyedContainer()
            try encode(array, to: &container)
        }
        
        /// A wrpper around a sequence of elements to encode
        private struct ContainedCodableArray<S>: Codable where S: SArray, S.Element == Any {
            fileprivate let array: S
            public init(_ s: S) { self.array = s }
            
            public init(from decoder: Decoder) throws {
                let a: Array<Any>!
                let customDecodingKey = CodingUserInfoKey(rawValue: "CodableHelper.customDecoding")!
                if let f = decoder.userInfo[customDecodingKey], let customDecoding = f as? ((_ decoder: Decoder) throws -> Any?) {
                    a = try CodableHelpers.arrays.decode(from: decoder, customDecoding: customDecoding)
                } else {
                    a = try CodableHelpers.arrays.decode(from: decoder)
                }
                if S.self == Array<Any>.self { self.array = a as! S }
                else { self.array = S(a) }
            }
            
            public func encode(to encoder: Encoder) throws {
                try CodableHelpers.arrays.encode(self.array, to: encoder)
            }
            
        }
        
        /// Encodes an array of Any to a Encoder if possible
        ///
        /// Note: All objects within the array must implement the Encodable protocol
        /// This will create an UnkeyedEncodingContainer from the encoder then call
        /// encode(_: Sequence, to: UnkeyedEncodingContainer)
        ///
        /// - Parameters:
        ///   - array: The array of objects to encode
        ///   - encoder: The encoder to encode the array to
        /// - Throws: EncodingError.invalidValue if the object can not encoded
        public static func encode<S, E>(_ array: S, to encoder: E) throws -> E.EncodedData  where E: EncoderType, S: SArray, S.Element == Any {
            let c = ContainedCodableArray(array)
            return try encoder.encode(c)
            
        }
        
        
        
        /// Decodes an Array<Any> from an UnkeyedDecodingContainer
        ///
        /// Decoding sequence tries as follows:
        ///    Int, UInt, Float, String, Double, Bool, Date, Data, Complex Object, Array
        ///
        /// - Parameters:
        ///   - container: The container to decode from
        ///   - customDecoding: a method for custom decoding of complex objects
        /// - Returns: Returns an array of decoded objects
        public static func decode(_ container: inout UnkeyedDecodingContainer,
                                  customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> Array<Any>  {
            var rtn: Array<Any> = Array<Any>()
            while !container.isAtEnd {
                
                var customValue: Any? = nil
                do {
                    customValue = try customDecoding(WrappedUnkeyedSingleValueDecoder(container))
                } catch { }
                
                if let v = customValue {
                    rtn.append(v)
                } else if let v = try? container.decodeNil(), v {
                    rtn.append(AnyNil) //If array was an optional array.  We should add the nil in.
                } else if let v = try? container.decode(Int.self) {
                    rtn.append(v)
                } else if let v = try? container.decode(UInt.self) {
                    rtn.append(v)
                } else if let v = try? container.decode(Float.self) {
                    rtn.append(v)
                } else if let v = try? container.decode(String.self) {
                    rtn.append(v)
                } else if let v = try? container.decode(Double.self) {
                    rtn.append(v)
                } else if let v = try? container.decode(Bool.self) {
                    rtn.append(v)
                } else if let v = try? container.decode(Date.self) {
                    rtn.append(v)
                } else if let v = try? container.decode(Data.self) {
                    rtn.append(v)
                } else if var v = try? container.nestedContainer(keyedBy: CodableKey.self) {
                    rtn.append(try _decode(&v, excludingKeys: [], customDecoding: customDecoding))
                } else if var v = try? container.nestedUnkeyedContainer() {
                    rtn.append(try decode(&v, customDecoding: customDecoding))
                } else {
                    throw DecodingError.typeMismatch(Any.self,
                                                     DecodingError.Context(codingPath: container.codingPath.appending(index: container.currentIndex),
                                                                           debugDescription: "Unsupported type"))
                }
            }
            return rtn
        }
        
        /// Decodes an Array<Any> from an UnkeyedDecodingContainer
        ///
        /// Decoding sequence tries as follows:
        ///    Int, UInt, Float, String, Double, Bool, Date, Data, Complex Object, Array
        ///
        /// - Parameters:
        ///   - container: The keyed container to decode from
        ///   - key: The keyed object to decode from
        ///   - customDecoding: a method for custom decoding of complex objects
        /// - Returns: Returns an array of decoded objects
        public static func decode<K>(in container: inout KeyedDecodingContainer<K>,
                                     forKey key: K,
                                     customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> [Any] {
            var childContainer = try container.nestedUnkeyedContainer(forKey: key)
            return try decode(&childContainer, customDecoding: customDecoding)
        }
        
        /// Decodes an Array<Any> from an UnkeyedDecodingContainer
        ///
        /// Decoding sequence tries as follows:
        ///    Int, UInt, Float, String, Double, Bool, Date, Data, Complex Object, Array
        ///
        /// - Parameters:
        ///   - decoder: The Decoder to decode from
        ///   - customDecoding: a method for custom decoding of complex objects
        /// - Returns: Returns an array of decoded objects
        public static func decode(from decoder: Decoder,
                                  customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> [Any]  {
            var container = try decoder.unkeyedContainer()
            return try decode(&container, customDecoding: customDecoding)
        }
        
        /// Decodes an Array<Any> from an UnkeyedDecodingContainer
        ///
        /// Decoding sequence tries as follows:
        ///    Int, UInt, Float, String, Double, Bool, Date, Data, Complex Object, Array
        ///
        /// - Parameters:
        ///   - data: The data to decode from
        ///   - decoder: The Decoder to decode from
        ///   - customDecoding: a method for custom decoding of complex objects
        /// - Returns: Returns an array of decoded objects
        public static func decode<D>(_ data: D.EncodedData,
                                     from decoder: D,
                                     customDecoding: @escaping (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> [Any]  where D: DecoderType {
    
            let key = CodingUserInfoKey(rawValue: "CodableHelper.customDecoding")!
            decoder.userInfo[key] = customDecoding
            defer { decoder.userInfo.removeValue(forKey: key) }
            let a = try decoder.decode(ContainedCodableArray<Array<Any>>.self,
                                       from: data)
            return a.array
        }
        
        
        
        
        /// Provides an easy method to encode an array of encodable objects in a dynamic way
        ///
        /// The following rules apply when encoding:
        /// 1. If collection is nil, nothing gets encoded
        /// 2. If collection count is 0, nothing gets encoded
        /// 3. If collection count is 1, encodes the object as a single value and not an array
        /// 4. Encodes as a regular array
        ///
        /// - Parameters:
        ///   - collection: The collection to encode
        ///   - encoder: The encoder to encode the objects to
        public static func encodeToSingleOrArrayIfPresent<C>(_ collection: C?,
                                                             to encoder: Encoder) throws where C: Collection, C.Element: Encodable {
            guard let array = collection else { return }
            guard array.count > 0 else { return }
            if array.count == 1 {
                var container = encoder.singleValueContainer()
                try container.encode(array[array.startIndex])
            } else {
                var container = encoder.unkeyedContainer()
                for o in array {
                    try container.encode(o)
                }
            }
        }
        
        /// Provides an easy method to encode an array of encodable objects in a dynamic way
        ///
        /// The following rules apply when encoding:
        /// 1. If collection is nil, nothing gets encoded
        /// 2. If collection count is 0, nothing gets encoded
        /// 3. If collection count is 1, encodes the object as a single value and not an array
        /// 4. Encodes as a regular array
        ///
        /// - Parameters:
        ///   - collection: The collection to encode
        ///   - container: The container to encode the collection to
        ///   - key: The coding key to encode the collection to
        public static func encodeToSingleOrArrayIfPresent<C, K>(_ collection: C?,
                                                                to container: inout KeyedEncodingContainer<K>,
                                                                forKey key: K) throws where C: Collection, C.Element: Encodable {
            guard let array = collection else { return }
            guard array.count > 0 else { return }
            if array.count == 1 {
                try container.encode(array[array.startIndex], forKey: key)
            } else {
                var container = container.nestedUnkeyedContainer(forKey: key)
                for o in array {
                    try container.encode(o)
                }
            }
        }
        
        /// Provides an easy method of decoding an optional/single value/array object into an array
        ///
        /// the following rules apply when decoding:
        /// 1. Tries to decode as a single value object and reutrns as a 1 element array
        /// 2. Tries to decode as an array of objects and returns it
        /// 3. returns nil
        ///
        /// - Parameters:
        ///   - decoder: Decoder to decode from
        ///   - customDecoding: Custom decoding of object type
        /// - Returns: Returns an array of elements that decoded
        public static func decodeFromSingleOrArrayIfPresent<Element>(from decoder: Decoder,
                                                                     customDecoding: (_ decoder: Decoder) throws -> Element) throws -> [Element]? where Element: Decodable {
            
            
            if let singleEncoder = try? decoder.singleValueContainer(),
               let v = try? customDecoding(WrappedSingleValueDecoder(singleEncoder)) { return [v] }
            //if let v = try? decoder.singleValueContainer().decode(Element.self) { return [v] }
            else if let container = try? decoder.unkeyedContainer() {
                let decoder = WrappedUnkeyedDecoder(container)
                var rtn: [Element] = []
                while !container.isAtEnd {
                    //let v = try container.decode(Element.self)
                    let v = try customDecoding(decoder)
                    rtn.append(v)
                }
                return rtn
            } else { return nil }
            
        }
        
        /// Provides an easy method of decoding an optional/single value/array object into an array
        ///
        /// The following rules apply when trying to decode:
        /// 1. Tries to decode as a single value object and reutrns as a 1 element array
        /// 2. Tries to decode as an array of objects and returns it
        /// 3. returns nil
        ///
        /// - Parameters:
        ///   - decoder: Decoder to decode from
        ///   - type: The object type to decode
        /// - Returns: Returns an array of elements that decoded
        public static func decodeFromSingleOrArrayIfPresent<Element>(from decoder: Decoder,
                                                                     ofType type: Element.Type) throws -> [Element]? where Element: Decodable {
            
            return try decodeFromSingleOrArrayIfPresent(from: decoder) {
                return try Element(from: $0)
            }
            
            /*if let v = try? decoder.singleValueContainer().decode(Element.self) { return [v] }
            else if var container = try? decoder.unkeyedContainer() {
                var rtn: [Element] = []
                while !container.isAtEnd {
                    let v = try container.decode(Element.self)
                    rtn.append(v)
                }
                return rtn
            } else { return nil }*/
            
        }
        
        
        /// Provides an easy method of decoding an optional/single value/array object into an array, or an empty array if no decoding options were available
        ///
        /// The following rules apply when decoding:
        /// 1. Tries to decode as a single value object and reutrns as a 1 element array
        /// 2. Tries to decode as an array of objects and returns it
        /// 3. returns empty array
        ///
        /// - Parameters:
        ///   - decoder: Decoder to decode from
        ///   - customDecoding: Custom decoding of object type
        /// - Returns: Returns an array of elements that decoded
        public static func decodeFromSingleOrArrayIfPresentWithEmptyDefault<Element>(from decoder: Decoder,
                                                                                     customDecoding: (_ decoder: Decoder) throws -> Element) throws -> [Element] where Element: Decodable {
            let rtn: [Element]? = try decodeFromSingleOrArrayIfPresent(from: decoder, customDecoding: customDecoding)
            return (rtn ?? [])
        }
        
        /// Provides an easy method of decoding an optional/single value/array object into an array, or an empty array if no decoding options were available
        ///
        /// The following rules apply when decoding:
        /// 1. Tries to decode as a single value object and reutrns as a 1 element array
        /// 2. Tries to decode as an array of objects and returns it
        /// 3. returns empty array
        ///
        /// - Parameters:
        ///   - decoder: Decoder to decode from
        ///   - type: The object type to decode
        /// - Returns: Returns an array of elements that decoded
        public static func decodeFromSingleOrArrayIfPresentWithEmptyDefault<Element>(from decoder: Decoder,
                                                                                     ofType type: Element.Type) throws -> [Element] where Element: Decodable {
            let rtn: [Element]? = try decodeFromSingleOrArrayIfPresent(from: decoder, ofType: type)
            return (rtn ?? [])
        }
        
        /// Provides an easy method of decoding an optional/single value/array object into an array, or nil if no decoding options were available
        ///
        /// The following rules apply when decoding:
        /// 1. Tries to decode as a single value object and reutrns as a 1 element array
        /// 2. Tries to decode as an array of objects and returns it
        /// 3. returns empty array
        ///
        /// - Parameters:
        ///   - decoder: Container to decode from
        ///   - key: Key to decode for
        ///   - customDecoding: Custom decoding of object type
        /// - Returns: Returns an array of elements that decoded or nil if no key found
        public static func decodeFromSingleOrArrayIfPresent<Element, K>(from container: KeyedDecodingContainer<K>,
                                                                        forKey key: K,
                                                                        customDecoding: (_ decoder: Decoder) throws -> Element) throws -> [Element]? where Element: Decodable {
            
            if let v = try? customDecoding(WrappedPreKeyedDecoder(container, preKey: key)) { return [v] }
            else if let container = try? container.nestedUnkeyedContainer(forKey: key) {
                let decoder = WrappedUnkeyedDecoder(container)
                var rtn: [Element] = []
                while !container.isAtEnd {
                    //let v = try container.decode(Element.self)
                    let v = try customDecoding(decoder)
                    rtn.append(v)
                }
                return rtn
            } else {
                return nil
            }
        }
        
        /// Provides an easy method of decoding an optional/single value/array object into an array, or nil if no decoding options were available
        ///
        /// The following rules apply when trying to decode:
        /// 1. Tries to decode as a single value object and reutrns as a 1 element array
        /// 2. Tries to decode as an array of objects and returns it
        /// 3. returns nil
        ///
        /// - Parameters:
        ///   - decoder: Decoder to decode from
        ///   - type: The object type to decode
        ///   - key: Key to decode for
        /// - Returns: Returns an array of elements that decoded or nil if no key found
        public static func decodeFromSingleOrArrayIfPresent<Element, K>(from container: KeyedDecodingContainer<K>,
                                                                        ofType: Element.Type,
                                                                        forKey key: K) throws -> [Element]? where Element: Decodable {
            
            if let v = try? container.decodeIfPresent(Element.self, forKey: key), let nv = v { return [nv] }
            else if let va = try? container.decodeIfPresent([Element].self, forKey: key){ return va }
            else { return nil }
        }
        
        /// Provides an easy method of decoding an optional/single value/array object into an array, or an empty array if no decoding options were available
        ///
        /// The following rules apply when decoding:
        /// 1. Tries to decode as a single value object and reutrns as a 1 element array
        /// 2. Tries to decode as an array of objects and returns it
        /// 3. returns empty array
        ///
        /// - Parameters:
        ///   - decoder: Container to decode from
        ///   - key: Key to decode for
        ///   - customDecoding: Custom decoding of object type
        /// - Returns: Returns an array of elements that decoded or an empty array if no key found
        public static func decodeFromSingleOrArrayIfPresentWithEmptyDefault<Element, K>(from container: KeyedDecodingContainer<K>,
                                                                                        forKey key: K,
                                                                                        customDecoding: (_ decoder: Decoder) throws -> Element) throws -> [Element] where Element: Decodable {
            
            let rtn: [Element]? = try decodeFromSingleOrArrayIfPresent(from: container, forKey: key, customDecoding: customDecoding)
            return (rtn ?? [])
        }
        
        /// Provides an easy method of decoding an optional/single value/array object into an array, or an empty array if no decoding options were available
        ///
        /// The following rules apply when trying to decode:
        /// 1. Tries to decode as a single value object and reutrns as a 1 element array
        /// 2. Tries to decode as an array of objects and returns it
        /// 3. returns nil
        ///
        /// - Parameters:
        ///   - decoder: Decoder to decode from
        ///   - type: The object type to decode
        ///   - key: Key to decode for
        /// - Returns: Returns an array of elements that decoded or an empty array if no key found
        public static func decodeFromSingleOrArrayIfPresentWithEmptyDefault<Element, K>(from container: KeyedDecodingContainer<K>,
                                                                                        ofType type: Element.Type,
                                                                                        forKey key: K) throws -> [Element] where Element: Decodable {
            
            let rtn: [Element]? = try decodeFromSingleOrArrayIfPresent(from: container, ofType: type, forKey: key)
            return (rtn ?? [])
        }
        
    }
}

extension CodableHelpers {
    
    public struct dictionaries {
        
        private init() { }
        
        
       
            
        /// Encode a dictionary to a container
        ///
        /// - Parameters:
        ///   - dictionary: Any dictionary type where the Key is DictionaryKeyCodable and Value is Any where can cast to Encodable
        ///   - container: The container to encode to
        public static func encode<D>(_ dictionary: D,
                                         to container: inout KeyedEncodingContainer<CodableKey>) throws where D: SDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
            for (key, v) in dictionary {
                
                if let dV = v as? Dictionary<String, Any> {
                    var subContainer = container.nestedContainer(keyedBy: CodableKey.self, forKey: key.dynamicCodingKey)
                    try encode(dV, to: &subContainer )
                } else if let dV = v as? Dictionary<Int, Any> {
                    var subContainer = container.nestedContainer(keyedBy: CodableKey.self, forKey: key.dynamicCodingKey)
                    try encode(dV, to: &subContainer)
                } else if let dV = v as? SCDictionary<String, Any> {
                    var subContainer = container.nestedContainer(keyedBy: CodableKey.self, forKey: key.dynamicCodingKey)
                    try encode(dV, to: &subContainer )
                } else if let dV = v as? SCDictionary<Int, Any> {
                    var subContainer = container.nestedContainer(keyedBy: CodableKey.self, forKey: key.dynamicCodingKey)
                    try encode(dV, to: &subContainer)
                } else if let dV = v as? SCArrayOrderedDictionary<String, Any> {
                    var subContainer = container.nestedContainer(keyedBy: CodableKey.self, forKey: key.dynamicCodingKey)
                    try encode(dV, to: &subContainer )
                } else if let dV = v as? SCArrayOrderedDictionary<Int, Any> {
                    var subContainer = container.nestedContainer(keyedBy: CodableKey.self, forKey: key.dynamicCodingKey)
                    try encode(dV, to: &subContainer)
                } else if let aV = v as? Array<Any> {
                    var subContainer = container.nestedUnkeyedContainer(forKey: key.dynamicCodingKey)
                    try arrays.encode(aV, to: &subContainer)
                } else if let aV = v as? SCArray<Any> {
                    var subContainer = container.nestedUnkeyedContainer(forKey: key.dynamicCodingKey)
                    try arrays.encode(aV, to: &subContainer)
                } else if let nV = v as? Nillable, nV.isNil {
                    try container.encodeNil(forKey: key.dynamicCodingKey)
                } else if let eV = v as? Encodable {
                    let wrappedEncoder = WrappedSingleValueEncoder(container.superEncoder(forKey: key.dynamicCodingKey).singleValueContainer())
                    try eV.encode(to: wrappedEncoder)
                    /*let wrappedEncoder = WrappedUnKeyedEncoder(container.nestedUnkeyedContainer(forKey: key.dynamicCodingKey))
                    try eV.encode(to: wrappedEncoder)
                    let wrappedEncoder = WrappedKeyedEncoder(container)
                    try eV.encode(to: wrappedEncoder)*/
                } else {
                    let description = "Expected value to conform to Encodable but found \(type(of: v)) instead."
                    throw EncodingError.invalidValue(v, EncodingError.Context(codingPath: container.codingPath.appending(key.dynamicCodingKey), debugDescription: description))
                }
            }
            
        }
        
        /// Encode a dictionary to a container
        ///
        /// - Parameters:
        ///   - dictionary: Any dictionary type where the Key is DictionaryKeyCodable and Value is Any where can cast to Encodable
        ///   - container: The container to encode to
        ///   - key: The key in the container to encode the dictionary to
        public static func encode<K, D>(_ dictionary: D,
                                        in container: inout KeyedEncodingContainer<K>,
                                        forKey key: K) throws where D: SDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
            var childContainer = container.nestedContainer(keyedBy: CodableKey.self, forKey: key)
            try self.encode(dictionary, to: &childContainer)
        }
        
        /// Encode an optional dictionary to a container
        ///
        /// - Parameters:
        ///   - dictionary: Any dictionary type where the Key is DictionaryKeyCodable and Value is Any where can cast to Encodable
        ///   - container: The container to encode to
        ///   - key: The key in the container to encode the dictionary to
        public static func encodeIfPresent<K, D>(_ dictionary: D?,
                                                 in container: inout KeyedEncodingContainer<K>,
                                                 forKey key: K) throws where D: SDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
            guard let d = dictionary else { return }
            try encode(d, in: &container, forKey: key)
        }
        
        /// Encode a dictionary to a container
        ///
        /// - Parameters:
        ///   - dictionary: Any dictionary type where the Key is DictionaryKeyCodable and Value is Any where can cast to Encodable
        ///   - encoder: The encoder to encode the dictionary to
        public static func encode<D>(_ dictionary: D,
                                     to encoder: Encoder) throws where D: SDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
            var container = encoder.container(keyedBy: CodableKey.self)
            try encode(dictionary, to: &container)
        }
        
        private struct ContainedCodableDictionary<D>: Codable where D: ReEncapsulatableDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
            fileprivate let dictionary: D
            public init(_ d: D) { self.dictionary = d }
            
            public init(from decoder: Decoder) throws {
                var customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }
                
                let customDecodingKey = CodingUserInfoKey(rawValue: "CodableHelper.customDecoding")!
                if let f = decoder.userInfo[customDecodingKey], let cF = f as? ((_ decoder: Decoder) throws -> Any?) {
                    customDecoding = cF
                }
                var excludingKeys: [D.Key] = []
                let excludingKeysKey = CodingUserInfoKey(rawValue: "CodableHelper.decoder.excludingKeys")!
                if let f = decoder.userInfo[excludingKeysKey], let cF = f as? [D.Key] {
                    excludingKeys = cF
                }
                
                let d: SCArrayOrderedDictionary<D.Key, D.Value> = try CodableHelpers.dictionaries.decode(from: decoder,
                                                                                                         excludingKeys: excludingKeys,
                                                                                                         customDecoding: customDecoding)
                self.dictionary = d.reencapsulate(dictionariesTo: D.ReEncapsulateType, arraysTo: .array) as! D
            }
            
            public func encode(to encoder: Encoder) throws {
                try CodableHelpers.dictionaries.encode(dictionary, to: encoder)
            }
            
        }
        
        /// Encode a dictionary to a container
        ///
        /// - Parameters:
        ///   - dictionary: Any dictionary type where the Key is DictionaryKeyCodable and Value is Any where can cast to Encodable
        ///   - encoder: The encoder to encode the dictionary to
        public static func encode<D, E>(_ dictionary: D, to encoder: E) throws -> E.EncodedData  where E: EncoderType, D: ReEncapsulatableDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
            let c = ContainedCodableDictionary(dictionary)
            return try encoder.encode(c)
            
        }
        
        /// Decode a Dictionary type based on return from the given container
        ///
        /// - Parameters:
        ///   - container: The container to decode the dictionary from
        ///   - excludingKeys: Any keys to exclude from the top level
        ///   - customDecoding: Function to try and do custom decoding of complex objects or nil if no custom decoded required
        /// - Returns: Return a dictionary type based on return from the given container
        public static func decode<D>(_ container: inout KeyedDecodingContainer<CodableKey>,
                                     excludingKeys: [D.Key] = [],
                                     customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> D where D: ReEncapsulatableDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
            
            
            
            let rtnD = try _decode(&container,
                                   excludingKeys: excludingKeys.map({ $0.dynamicCodingKey }),
                                   customDecoding: customDecoding)
            
            
            /*if let iRtnD = rtnD as? SCArrayOrderedDictionary<Int, Any> {
                guard D.Key == Int.self else {
                    
                }
                throw DecodingError.typeMismatch(Any.self, DecodingError.Context(codingPath: container.codingPath, debugDescription: "Unsupported type"))
            } else if let sRtnD = rtnD as? SCArrayOrderedDictionary<String, Any> {
                guard D.Key == String.self else {
                    
                }
                throw DecodingError.typeMismatch(Any.self, DecodingError.Context(codingPath: container.codingPath, debugDescription: "Unsupported type"))
            }*/
            
            if let cRtn = rtnD as? SCArrayOrderedDictionary<D.Key, Any> {
                guard D.self != SCArrayOrderedDictionary<D.Key, Any>.self else {
                    return cRtn as! D
                }
                return cRtn.reencapsulate(dictionariesTo: D.ReEncapsulateType, arraysTo: .array) as! D
               /* var rtn = D()
                for (k,v) in cRtn {
                    rtn[k] = v
                }
                return rtn //D.init() //D.init(uniqueKeysWithValues: cRtn)*/
            } else if let cRtn = rtnD as? SCArrayOrderedDictionary<String, Any>,
                let numericType: DictionaryKeyCodableStringInit.Type = D.Key.self as? DictionaryKeyCodableStringInit.Type {
                
                let converted = SCArrayOrderedDictionary<D.Key, Any>()
                
                for (k, v) in cRtn {
                    if let nV = numericType.init(k) as? D.Key {
                        converted[nV] = v
                    } else {
                        throw DecodingError.typeMismatch(Any.self, DecodingError.Context(codingPath: container.codingPath, debugDescription: "Unsupported key type \(D.Key.self)"))
                    }
                }
                
                guard D.self != SCArrayOrderedDictionary<D.Key, Any>.self else {
                    return converted as! D
                }
                return converted.reencapsulate(dictionariesTo: D.ReEncapsulateType, arraysTo: .array) as! D
                
            } else {
                throw DecodingError.typeMismatch(Any.self, DecodingError.Context(codingPath: container.codingPath, debugDescription: "Unsupported key type \(D.Key.self)"))
            }
        }
        
        /// Decode a Dictionary type based on return from the given container
        ///
        /// - Parameters:
        ///   - container: The container to decode the dictionary from
        ///   - key: The key from the container to decode
        ///   - customDecoding: Function to try and do custom decoding of complex objects or nil if no custom decoded required
        /// - Returns: Return a dictionary type based on return from the given container
        public static func decode<K, D>(from container: inout KeyedDecodingContainer<K>,
                                        forKey key: K,
                                        customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> D where D: ReEncapsulatableDictionary, D.Key == String, D.Value == Any {
            var subContainer = try container.nestedContainer(keyedBy: CodableKey.self, forKey: key)
            return try decode(&subContainer, customDecoding: customDecoding)
        }
        
        /// Decode a Dictionary type based on return from the given container or nil if key not found
        ///
        /// - Parameters:
        ///   - container: The container to decode the dictionary from
        ///   - key: The key from the container to decode
        ///   - customDecoding: Function to try and do custom decoding of complex objects or nil if no custom decoded required
        /// - Returns: Return a dictionary type based on return from the given container and key, or nil if key is not found
        public static func decodeIfPresent<K, D>(from container: inout KeyedDecodingContainer<K>,
                                                 forKey key: K,
                                                 customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> D? where D: ReEncapsulatableDictionary, D.Key == String, D.Value == Any {
            guard container.contains(key) else { return nil }
            var subContainer = try container.nestedContainer(keyedBy: CodableKey.self, forKey: key)
            return try decode(&subContainer, customDecoding: customDecoding)
        }
        
        /// Decode a Dictionary type based on return from the given container
        ///
        /// - Parameters:
        ///   - decoder: The decoder to decode dictionary from
        ///   - excludingKeys: Any keys to exclude from the top level
        ///   - customDecoding: Function to try and do custom decoding of complex objects or nil if no custom decoded required
        ///
        /// - Returns: Return a dictionary type based on return
        public static func decode<D>(from decoder: Decoder,
                                     excludingKeys: [D.Key] = [],
                                     customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> D where D: ReEncapsulatableDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
            var container = try decoder.container(keyedBy: CodableKey.self)
            return try decode(&container, excludingKeys: excludingKeys, customDecoding: customDecoding)
        }
        
        /// Decode a Dictionary type based on return from the given container
        ///
        /// - Parameters:
        ///   - data: The data to decode from
        ///   - decoder: The decoder to use with the data to decode the dictionary from
        ///   - excludingKeys: Any keys to exclude from the top level
        ///   - customDecoding: Function to try and do custom decoding of complex objects or nil if no custom decoded required
        ///
        /// - Returns: Return a dictionary type based on return
        public static func decode<D, DC>(_ data: DC.EncodedData,
                                         from decoder: DC,
                                         excludingKeys: [D.Key] = [],
                                         customDecoding: @escaping (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> D where D: ReEncapsulatableDictionary, D.Key: DictionaryKeyCodable, D.Value == Any, DC: DecoderType {
            
            let customDecodingKey = CodingUserInfoKey(rawValue: "CodableHelper.customDecoding")!
            decoder.userInfo[customDecodingKey] = customDecoding
            let excludingKeysKey = CodingUserInfoKey(rawValue: "CodableHelper.decoder.excludingKeys")!
            decoder.userInfo[excludingKeysKey] = excludingKeys
            defer {
                decoder.userInfo.removeValue(forKey: customDecodingKey)
                decoder.userInfo.removeValue(forKey: excludingKeysKey)
            }
            let dc: ContainedCodableDictionary<D> = try decoder.decode(ContainedCodableDictionary<D>.self, from: data)
            return dc.dictionary
        }
        
        
    }
}
