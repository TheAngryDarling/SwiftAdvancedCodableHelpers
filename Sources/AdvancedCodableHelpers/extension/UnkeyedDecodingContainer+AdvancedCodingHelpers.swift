//
//  UnkeyedDecodingContainer+AdvancedCodingHelpers.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2019-11-25.
//

import Foundation
import Nillable
import SwiftClassCollections

public extension UnkeyedDecodingContainer {
    /// Dynamically decode a given type.
    /// - Parameters:
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    mutating func decode<T>(decodingFunc: (_ decoder: Decoder) throws -> T) throws -> T {
        
        return try decodingFunc(try self.superDecoder())
    }
    /// Dynamically decode a given type if present.
    /// - Parameters:
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    mutating func decodeIfPresent<T>(decodingFunc: (_ decoder: Decoder) throws -> T) throws -> T? {
        guard !self.isAtEnd && !((try? self.decodeNil()) ?? false) else { return nil }
        return try decode(decodingFunc: decodingFunc)
    }
    /// Dynamically decode a given type if present.
    /// - Parameters:
    ///   - defaultValue: The default value to use if object not present
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    mutating func decodeIfPresent<T>(withDefaultValue defaultValue: @autoclosure () -> T,
                                     decodingFunc: (_ decoder: Decoder) throws -> T) throws -> T {
        return (try self.decodeIfPresent(decodingFunc: decodingFunc)) ?? defaultValue()
    }
    
    /// Dynamically decode an array of a given type.
    /// - Parameters:
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    mutating func decodeArray<T>(decodingFunc: (_ decoder: Decoder) throws -> T) throws -> [T] {
        var container = try self.nestedUnkeyedContainer()
        var rtn: [T] = []
        while !container.isAtEnd {
            
            //let obj = try decodingFunc(WrappedUnkeyedSingleValueDecoder(container))
            let obj = try decodingFunc(try container.superDecoder())
            rtn.append(obj)
        }
        return rtn
    }
    /// Dynamically decode an array of a given type if present
    /// - Parameters:
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    mutating func decodeArrayIfPresent<T>(decodingFunc: (_ decoder: Decoder) throws -> T) throws -> [T]? {
        guard !self.isAtEnd && !((try? self.decodeNil()) ?? false) else { return nil }
        return try self.decodeArray(decodingFunc: decodingFunc)
    }
    /// Dynamically decode an array of a given type if present
    /// - Parameters:
    ///   - defaultValue: The default value to use if object not present
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    mutating func decodeArrayIfPresent<T>(withDefaultValue defaultValue: @autoclosure () -> [T],
                                     decodingFunc: (_ decoder: Decoder) throws -> T) throws -> [T] {
        return (try self.decodeArrayIfPresent(decodingFunc: decodingFunc)) ?? defaultValue()
    }
    
    
    /// Dynamically decode an array of a given type.
    /// - Parameters:
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    @available(*, deprecated, renamed: "decodeArray")
    mutating func decode<T>(decodingFunc: (_ decoder: Decoder) throws -> T) throws -> [T] {
        return try self.decodeArray(decodingFunc: decodingFunc)
    }
    /// Dynamically decode an array of a given type if present
    /// - Parameters:
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    @available(*, deprecated, renamed: "decodeIfPresent")
    mutating func decodeIfPresent<T>(decodingFunc: (_ decoder: Decoder) throws -> T) throws -> [T]? {
        return try self.decodeArrayIfPresent(decodingFunc: decodingFunc)
    }
    /// Dynamically decode an array of a given type if present
    /// - Parameters:
    ///   - defaultValue: The default value to use if object not present
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    @available(*, deprecated, renamed: "decodeIfPresent")
    mutating func decodeIfPresent<T>(withDefaultValue defaultValue: @autoclosure () -> [T],
                                     decodingFunc: (_ decoder: Decoder) throws -> T) throws -> [T] {
        return try self.decodeArrayIfPresent(withDefaultValue: defaultValue,
                                             decodingFunc: decodingFunc)
    }
}

public extension UnkeyedDecodingContainer {
    
    /// Decode a Dictionary type based on return from the given container
    ///
    /// - Parameters:
    ///   - excludingKeys: Any keys to exclude from the top level
    ///   - customDecoding: Function to try and do custom decoding of complex objects or nil if no custom decoded required
    /// - Returns: Return a dictionary type based on return from the given container
    mutating func decodeAnyDictionary<D>(excludingKeys: [D.Key] = [],
                                      customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> D where D: ReEncapsulatableDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
        
        let container = try self.nestedContainer(keyedBy: CodableKey.self)
        return try container.decodeAndRemapDictionary(excludingKeys: excludingKeys.map {
                                                    return $0.dynamicCodingKey
                                               },
                                                customDecoding: customDecoding)
    }
    
    
    /// Decodes the whole Unkeyed container as the array
    ///
    /// Decoding sequence tries as follows:
    ///    Int, UInt, Float, String, Double, Bool, Date, Data, Complex Object, Array
    ///
    /// - Parameters:
    ///   - customDecoding: a method for custom decoding of complex objects
    /// - Returns: Returns an array of decoded objects
    mutating func decodeAnyArray(customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> Array<Any>  {
        var rtn: Array<Any> = Array<Any>()
        while !self.isAtEnd {
            var customValue: Any? = nil
            do {
                customValue = try customDecoding(WrappedUnkeyedDecoder(self,
                                                                       codingPathModifier: .appending(CodableKey(index: self.currentIndex))))
                if customValue != nil {
                    // This causes use to goto the next element in the array
                    // since using WrappedUnkeyedDecoder our array and does not update
                    // the current index when it executes
                    _ = try? self.superDecoder()
                }
                //let sup = try self.superDecoder()
                //customValue = try customDecoding(sup)
                //customValue = try customDecoding(WrappedUnkeyedSingleValueDecoder(self))
            } catch { }
            
            if let v = customValue {
                rtn.append(v)
            } else if let v = try? self.decodeNil(), v {
                rtn.append(AnyNil) //If array was an optional array.  We should add the nil in.
            } else if let v = try? self.decode(Int.self) {
                rtn.append(v)
            } else if let v = try? self.decode(UInt.self) {
                rtn.append(v)
            } else if let v = try? self.decode(Float.self) {
                rtn.append(v)
            } else if let v = try? self.decode(String.self) {
                rtn.append(v)
            } else if let v = try? self.decode(Double.self) {
                rtn.append(v)
            } else if let v = try? self.decode(Bool.self) {
                rtn.append(v)
            } else if let v = try? self.decode(Date.self) {
                rtn.append(v)
            } else if let v = try? self.decode(Data.self) {
                rtn.append(v)
            } else if let v = try? self.nestedContainer(keyedBy: CodableKey.self) {
                rtn.append(try v.decodeToAnyDictionary(customDecoding: customDecoding))
            } else if var v = try? self.nestedUnkeyedContainer() {
                rtn.append(try v.decodeAnyArray(customDecoding: customDecoding))
            } else {
                throw DecodingError.typeMismatch(Any.self,
                                                 DecodingError.Context(codingPath: self.codingPath.appending(index: self.currentIndex),
                                                                       debugDescription: "Unsupported type"))
            }
        }
        return rtn
    }
}

public extension UnkeyedDecodingContainer {
    
    /// Provides an easy method of decoding an optional/single value/array object into an array
    ///
    /// The following rules apply when decoding:
    /// 1. Tries to decode as a single value object and reutrns as a 1 element array
    /// 2. Tries to decode as an array of objects and returns it
    ///
    /// - Parameters:
    ///   - customDecoding: Custom decoding of object type
    /// - Returns: Returns an array of elements that decoded or nil if no key found
    mutating func decodeFromSingleOrArray<Element>(customDecoding: (_ decoder: Decoder) throws -> Element) throws -> [Element] {
        let decoder = try self.superDecoder()
        //if let v = try? customDecoding(WrappedPreKeyedDecoder(self, preKey: key)) { return [v] }
        if let v = try? customDecoding(decoder) {
            return [v]
        } else {
            var container = try decoder.unkeyedContainer()
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
    /// 3. returns nil
    ///
    /// - Parameters:
    ///   - customDecoding: Custom decoding of object type
    /// - Returns: Returns an array of elements that decoded or nil if no key found
    mutating func decodeFromSingleOrArrayIfPresent<Element>(customDecoding: (_ decoder: Decoder) throws -> Element) throws -> [Element]? {
        guard self.notAtEndAndNotNil() else { return nil }
        
        return try self.decodeFromSingleOrArray(customDecoding: customDecoding)
        
    }
    
    /// Provides an easy method of decoding an optional/single value/array object into an array, or defaultValue if no decoding options were available
    ///
    /// The following rules apply when decoding:
    /// 1. Tries to decode as a single value object and reutrns as a 1 element array
    /// 2. Tries to decode as an array of objects and returns it
    /// 3. returns default value
    ///
    /// - Parameters:
    ///   - defaultValue: The value to return if object not present
    ///   - customDecoding: Custom decoding of object type
    /// - Returns: Returns an array of elements that decoded or nil if no key found
    mutating func decodeFromSingleOrArrayIfPresent<Element>(withDefaultValue defaultValue: @autoclosure () -> [Element],
                                                            customDecoding: (_ decoder: Decoder) throws -> Element) throws -> [Element] {
        return (try self.decodeFromSingleOrArrayIfPresent(customDecoding: customDecoding)) ?? defaultValue()
        
    }
    
    /// Provides an easy method of decoding an optional/single value/array object into an array, or an empty array if no decoding options were available
    ///
    /// The following rules apply when decoding:
    /// 1. Tries to decode as a single value object and reutrns as a 1 element array
    /// 2. Tries to decode as an array of objects and returns it
    /// 3. returns empty array
    ///
    /// - Parameters:
    ///   - customDecoding: Custom decoding of object type
    /// - Returns: Returns an array of elements that decoded or an empty array if no key found
    mutating func decodeFromSingleOrArrayIfPresentWithEmptyDefault<Element>(customDecoding: (_ decoder: Decoder) throws -> Element) throws -> [Element] {
        
        return try self.decodeFromSingleOrArrayIfPresent(withDefaultValue: [],
                                                         customDecoding: customDecoding)
    }
}
