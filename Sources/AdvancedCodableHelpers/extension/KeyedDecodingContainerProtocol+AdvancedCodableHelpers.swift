//
//  KeyedDecodingContainerProtocol+AdvancedCodableHelpers.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2019-11-25.
//

import Foundation
import Nillable
import SwiftClassCollections

public extension KeyedDecodingContainerProtocol {
    /// Dynamically decode a given type.
    /// - Parameters:
    ///   - key: The coding key to decode
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    func decode<T>(forKey key: Self.Key, decodingFunc: (_ decoder: Decoder) throws -> T) throws -> T {
        return try decodingFunc(WrappedPreKeyedDecoder(self, preKey: key))
    }
    /// Dynamically decode a given type if present
    /// - Parameters:
    ///   - key: The coding key to decode
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    func decodeIfPresent<T>(forKey key: Self.Key, decodingFunc: (_ decoder: Decoder) throws -> T) throws -> T? {
        guard self.contains(key) && !((try? self.decodeNil(forKey: key)) ?? false) else { return nil }
        return try decode(forKey: key, decodingFunc: decodingFunc)
    }
    
    /// Dynamically decode a given type if present
    /// - Parameters:
    ///   - key: The coding key to decode
    ///   - defaultValue: The default value to use if key not found
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    func decodeIfPresent<T>(forKey key: Self.Key,
                            withDefaulValue defaultValue: @autoclosure () -> T,
                            decodingFunc: (_ decoder: Decoder) throws -> T) throws -> T {
        return (try self.decodeIfPresent(forKey: key, decodingFunc: decodingFunc)) ?? defaultValue()
    }
    
    /// Dynamically decode an array of a given type
    /// - Parameters:
    ///   - key: The coding key to decode
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    func decodeArray<T>(forKey key: Self.Key, decodingFunc: (_ decoder: Decoder) throws -> T) throws -> [T] {
        var container = try self.nestedUnkeyedContainer(forKey: key)
        var rtn: [T] = []
        while !container.isAtEnd {
            
            //let obj = try decodingFunc(WrappedUnkeyedSingleValueDecoder(container))
            let obj = try decodingFunc(try container.superDecoder())
            rtn.append(obj)
        }
        return rtn
        
    }
    
    /// Dynamically decode an array of a given type
    /// - Parameters:
    ///   - key: The coding key to decode
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    @available(*, deprecated, renamed: "decodeArray")
    func decode<T>(forKey key: Self.Key, decodingFunc: (_ decoder: Decoder) throws -> T) throws -> [T] {
        return try self.decodeArray(forKey: key, decodingFunc: decodingFunc)
    }
    
    /// Dynamically decode an array of a given type if present
    ///
    /// - Parameters:
    ///   - key: The coding key to decode
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    func decodeArrayIfPresent<T>(forKey key: Self.Key, decodingFunc: (_ decoder: Decoder) throws -> T) throws -> [T]? {
        guard self.contains(key) && !((try? self.decodeNil(forKey: key)) ?? false) else { return nil }
        return try decodeArray(forKey: key, decodingFunc: decodingFunc)
    }
    
    /// Dynamically decode an array of a given type if present
    ///
    /// - Parameters:
    ///   - key: The coding key to decode
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    @available(*, deprecated, renamed: "decodeArrayIfPresent")
    func decodeIfPresent<T>(forKey key: Self.Key,
                            decodingFunc: (_ decoder: Decoder) throws -> T) throws -> [T]? {
        return try self.decodeArrayIfPresent(forKey: key, decodingFunc: decodingFunc)
    }
    
    /// Dynamically decode an array of a given type if present
    ///
    /// - Parameters:
    ///   - key: The coding key to decode
    ///   - defaultValue: The default value to use if key not found
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    func decodeArrayIfPresent<T>(forKey key: Self.Key,
                                 withDefaulValue defaultValue: @autoclosure () -> [T],
                                 decodingFunc: (_ decoder: Decoder) throws -> T) throws -> [T] {
        return (try self.decodeArrayIfPresent(forKey: key, decodingFunc: decodingFunc)) ?? defaultValue()
    }
}

public extension KeyedDecodingContainerProtocol {
    
    /// Decodes a KeyedDecodingContainer into a SCArrayOrderedDictionary
    ///
    /// - Parameters:
    ///   - excludingKeys: Any keys to exclude from the top level
    ///   - customDecoding: Custom decoder function for custom decoding of complex objects
    /// - Returns: Returns either SCArrayOrderedDictionary<String, Any> or SCArrayOrderedDictionary<Int, Any> depending on the CodableKey type
    internal func decodeToAnyDictionary(excludingKeys: [CodableKey] = [],
                                    customDecoding: (_ decoder: Decoder) throws -> Any?) throws -> Any {
        
        let keys = self.allKeys
        if keys.count > 0 && keys[0].intValue != nil {
            let rtn = SCArrayOrderedDictionary<Int, Any>()
            
            for key in keys {
                guard !excludingKeys.contains(where: { $0.stringValue == key.stringValue }) else {
                    continue
                }
                
                var customValue: Any? = nil
                do {
                    customValue = try customDecoding(WrappedPreKeyedDecoder(self, preKey: key))
                } catch { }
                
                if let v = customValue {
                    rtn[key.intValue!] = v
                } else if let v = try? self.decodeNil(forKey: key), v {
                    rtn[key.intValue!] = AnyNil //(nil as Any)
                } else if let v = try? self.decode(Int.self, forKey: key) {
                    rtn[key.intValue!] = v
                } else if let v = try? self.decode(UInt.self, forKey: key) {
                    rtn[key.intValue!] = v
                } else if let v = try? self.decode(Float.self, forKey: key) {
                    rtn[key.intValue!] = v
                } else if let v = try? self.decode(String.self, forKey: key) {
                    rtn[key.intValue!] = v
                } else if let v = try? self.decode(Double.self, forKey: key) {
                    rtn[key.intValue!] = v
                } else if let v = try? self.decode(Bool.self, forKey: key) {
                    rtn[key.intValue!] = v
                } else if let v = try? self.decode(Date.self, forKey: key) {
                    rtn[key.intValue!] = v
                } else if let v = try? self.decode(Data.self, forKey: key) {
                    rtn[key.intValue!] = v
                } else if let v = try? self.nestedContainer(keyedBy: CodableKey.self, forKey: key) {
                    //rtn[key.intValue!] = try _decode(&v, excludingKeys: [], customDecoding: customDecoding)
                    rtn[key.intValue!] = try v.decodeToAnyDictionary(customDecoding: customDecoding)
                } else if var v = try? self.nestedUnkeyedContainer(forKey: key) {
                    //rtn[key.intValue!] = try CodableHelpers.arrays.decode(&v, customDecoding: customDecoding)
                    rtn[key.intValue!] = try v.decodeAnyArray(customDecoding: customDecoding)
                } else {
                    throw DecodingError.typeMismatch(Any.self,
                                                     DecodingError.Context(codingPath: self.codingPath.appending(key),
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
                    customValue = try customDecoding(WrappedPreKeyedDecoder(self, preKey: key))
                } catch { }
                
                if let v = customValue {
                    rtn[key.stringValue] = v
                } else if let v = try? self.decodeNil(forKey: key), v {
                    rtn[key.stringValue] = AnyNil //(nil as Any)
                } else if let v = try? self.decode(Int.self, forKey: key) {
                    rtn[key.stringValue] = v
                } else if let v = try? self.decode(UInt.self, forKey: key) {
                    rtn[key.stringValue] = v
                } else if let v = try? self.decode(Float.self, forKey: key) {
                    rtn[key.stringValue] = v
                } else if let v = try? self.decode(String.self, forKey: key) {
                    rtn[key.stringValue] = v
                } else if let v = try? self.decode(Double.self, forKey: key) {
                    rtn[key.stringValue] = v
                } else if let v = try? self.decode(Bool.self, forKey: key) {
                    rtn[key.stringValue] = v
                } else if let v = try? self.decode(Date.self, forKey: key) {
                    rtn[key.stringValue] = v
                } else if let v = try? self.decode(Data.self, forKey: key) {
                    rtn[key.stringValue] = v
                } else if let v = try? self.nestedContainer(keyedBy: CodableKey.self, forKey: key) {
                    //rtn[key.stringValue] = try _decode(&v, excludingKeys: [], customDecoding: customDecoding)
                    rtn[key.stringValue] = try v.decodeToAnyDictionary(customDecoding: customDecoding)
                } else if var v = try? self.nestedUnkeyedContainer(forKey: key) {
                    //rtn[key.stringValue] = try CodableHelpers.arrays.decode(&v, customDecoding: customDecoding)
                    rtn[key.stringValue] = try v.decodeAnyArray(customDecoding: customDecoding)
                } else {
                    throw DecodingError.typeMismatch(Any.self,
                                                     DecodingError.Context(codingPath: self.codingPath.appending(key),
                                                                           debugDescription: "Unsupported type"))
                }
            }
            
            return rtn
        }
    }
    
    /// Decode a Dictionary type based on return from the given container
    ///
    /// - Parameters:
    ///   - container: The container to decode the dictionary from
    ///   - excludingKeys: Any keys to exclude from the top level
    ///   - customDecoding: Function to try and do custom decoding of complex objects or nil if no custom decoded required
    /// - Returns: Return a dictionary type based on return from the given container
    internal func decodeAndRemapDictionary<D>(excludingKeys: [CodableKey] = [],
                                       customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> D where D: ReEncapsulatableDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
        
        
        
        let rtnD = try self.decodeToAnyDictionary(excludingKeys: excludingKeys,
                                              customDecoding: customDecoding)
        
        
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
                    throw DecodingError.typeMismatch(Any.self, DecodingError.Context(codingPath: self.codingPath, debugDescription: "Unsupported key type \(D.Key.self)"))
                }
            }
            
            guard D.self != SCArrayOrderedDictionary<D.Key, Any>.self else {
                return converted as! D
            }
            return converted.reencapsulate(dictionariesTo: D.ReEncapsulateType, arraysTo: .array) as! D
            
        } else {
            throw DecodingError.typeMismatch(Any.self, DecodingError.Context(codingPath: self.codingPath, debugDescription: "Unsupported key type \(D.Key.self)"))
        }
    }
    
    
    /// Decode a Dictionary type based on return from the given container
    ///
    /// - Parameters:
    ///   - key: The coding key to decode
    ///   - excludingKeys: Any keys to exclude from the top level
    ///   - customDecoding: Function to try and do custom decoding of complex objects or nil if no custom decoded required
    /// - Returns: Return a dictionary type based on return from the given container
    func decodeAnyDictionary<D>(forKey key: Key,
                             excludingKeys: [D.Key] = [],
                             customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> D where D: ReEncapsulatableDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
        
        let container = try self.nestedContainer(keyedBy: CodableKey.self, forKey: key)
        
        return try container.decodeAndRemapDictionary(excludingKeys: excludingKeys.map({
                                                    return $0.dynamicCodingKey
                                               }),
                                               customDecoding: customDecoding)
        
        
    }
    
    /// Decode a Dictionary type based on return from the given container
    ///
    /// - Parameters:
    ///   - key: The coding key to decode
    ///   - excludingKeys: Any keys to exclude from the top level
    ///   - customDecoding: Function to try and do custom decoding of complex objects or nil if no custom decoded required
    /// - Returns: Return a dictionary type based on return from the given container
    func decodeAnyDictionaryIfPresent<D>(forKey key: Key,
                                      excludingKeys: [D.Key] = [],
                                      customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> D? where D: ReEncapsulatableDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
        guard self.containsAndNotNil(key) else { return nil }
        return try self.decodeAnyDictionary(forKey: key,
                                         excludingKeys: excludingKeys,
                                         customDecoding: customDecoding)
    }
    
    /// Decode a Dictionary type based on return from the given container
    ///
    /// - Parameters:
    ///   - key: The coding key to decode
    ///   - excludingKeys: Any keys to exclude from the top level
    ///   - defaultValue: The defalut value to use if dictionary is not presetn
    ///   - customDecoding: Function to try and do custom decoding of complex objects or nil if no custom decoded required
    /// - Returns: Return a dictionary type based on return from the given container
    func decodeAnyDictionaryIfPresent<D>(forKey key: Key,
                                      excludingKeys: [D.Key] = [],
                                      withDefaultValue defaultValue: @autoclosure () -> D,
                                      customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> D where D: ReEncapsulatableDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
        return (try self.decodeAnyDictionaryIfPresent(forKey: key,
                                                   excludingKeys: excludingKeys,
                                                   customDecoding: customDecoding)) ?? defaultValue()
    }
    
    /// Decodes an Array<Any> from the container
    ///
    /// Decoding sequence tries as follows:
    ///    Int, UInt, Float, String, Double, Bool, Date, Data, Complex Object, Array
    ///
    /// - Parameters:
    ///   - key: The coding key to decode
    ///   - customDecoding: a method for custom decoding of complex objects
    /// - Returns: Returns an array of decoded objects
    func decodeAnyArray(forKey key: Key,
                          customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> Array<Any>  {
        
        
        var container = try self.nestedUnkeyedContainer(forKey: key)
        return try container.decodeAnyArray(customDecoding: customDecoding)
        
    }
    
    /// Decodes an Array<Any> from the container
    ///
    /// Decoding sequence tries as follows:
    ///    Int, UInt, Float, String, Double, Bool, Date, Data, Complex Object, Array
    ///
    /// - Parameters:
    ///   - key: The coding key to decode
    ///   - customDecoding: a method for custom decoding of complex objects
    /// - Returns: Returns an array of decoded objects
    func decodeAnyArrayIfPresent(forKey key: Key,
                                   customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> Array<Any>?  {
        
        guard self.containsAndNotNil(key) else { return nil }
        return try self.decodeAnyArray(forKey: key, customDecoding: customDecoding)
    }
    
    /// Decodes an Array<Any> from the container
    ///
    /// Decoding sequence tries as follows:
    ///    Int, UInt, Float, String, Double, Bool, Date, Data, Complex Object, Array
    ///
    /// - Parameters:
    ///   - key: The coding key to decode
    ///   - defaultValue: The default value to use if array is not present
    ///   - customDecoding: a method for custom decoding of complex objects
    /// - Returns: Returns an array of decoded objects
    func decodeAnyArrayIfPresent(forKey key: Key,
                                   withDefaultValue defaultValue: @autoclosure () -> Array<Any>,
                                   customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> Array<Any>  {
        
        return (try self.decodeAnyArrayIfPresent(forKey: key, customDecoding: customDecoding)) ?? defaultValue()
    }
}

public extension KeyedDecodingContainerProtocol {
    
    /// Provides an easy method of decoding an optional/single value/array object into an array
    ///
    /// The following rules apply when decoding:
    /// 1. Tries to decode as a single value object and reutrns as a 1 element array
    /// 2. Tries to decode as an array of objects and returns it
    ///
    /// - Parameters:
    ///   - key: Key to decode for
    ///   - customDecoding: Custom decoding of object type
    /// - Returns: Returns an array of elements that decoded or nil if no key found
    func decodeFromSingleOrArray<Element>(forKey key: Key,
                                          customDecoding: (_ decoder: Decoder) throws -> Element) throws -> [Element] {
        
        if let decoder = try? self.superDecoder(forKey: key),
           let v = try? customDecoding(decoder) {
            return [v]
        } else {
            var container = try self.nestedUnkeyedContainer(forKey: key)
            var rtn: [Element] = []
            while !container.isAtEnd {
                let decoder = try container.superDecoder()
                //let v = try container.decode(Element.self)
                let v = try customDecoding(decoder)
                rtn.append(v)
            }
            return rtn
        }
    }
    
    
    /// Provides an easy method of decoding an optional/single value/array object into an array, or nil if no decoding options were available
    ///
    /// The following rules apply when decoding:
    /// 1. Tries to decode as a single value object and reutrns as a 1 element array
    /// 2. Tries to decode as an array of objects and returns it
    /// 3. returns empty array
    ///
    /// - Parameters:
    ///   - key: Key to decode for
    ///   - customDecoding: Custom decoding of object type
    /// - Returns: Returns an array of elements that decoded or nil if no key found
    func decodeFromSingleOrArrayIfPresent<Element>(forKey key: Key,
                                                   customDecoding: (_ decoder: Decoder) throws -> Element) throws -> [Element]? {
        guard self.containsAndNotNil(key) else { return nil }
        return try self.decodeFromSingleOrArray(forKey: key, customDecoding: customDecoding)
    }
    
    /// Provides an easy method of decoding an optional/single value/array object into an array, or nil if no decoding options were available
    ///
    /// The following rules apply when decoding:
    /// 1. Tries to decode as a single value object and reutrns as a 1 element array
    /// 2. Tries to decode as an array of objects and returns it
    /// 3. returns empty array
    ///
    /// - Parameters:
    ///   - key: Key to decode for
    ///   - customDecoding: Custom decoding of object type
    /// - Returns: Returns an array of elements that decoded or nil if no key found
    func decodeFromSingleOrArrayIfPresent<Element>(forKey key: Key,
                                                   withDefaultValue defaultValue: @autoclosure () -> [Element],
                                                   customDecoding: (_ decoder: Decoder) throws -> Element) throws -> [Element] {
        return (try self.decodeFromSingleOrArrayIfPresent(forKey: key, customDecoding: customDecoding)) ?? defaultValue()
    }
    
    /// Provides an easy method of decoding an optional/single value/array object into an array, or an empty array if no decoding options were available
    ///
    /// The following rules apply when decoding:
    /// 1. Tries to decode as a single value object and reutrns as a 1 element array
    /// 2. Tries to decode as an array of objects and returns it
    /// 3. returns empty array
    ///
    /// - Parameters:
    ///   - key: Key to decode for
    ///   - customDecoding: Custom decoding of object type
    /// - Returns: Returns an array of elements that decoded or an empty array if no key found
    func decodeFromSingleOrArrayIfPresentWithEmptyDefault<Element>(forKey key: Key,
                                                                   customDecoding: (_ decoder: Decoder) throws -> Element) throws -> [Element] {
        
        return try self.decodeFromSingleOrArrayIfPresent(forKey: key,
                                                         withDefaultValue: [],
                                                         customDecoding: customDecoding)
    }
}
