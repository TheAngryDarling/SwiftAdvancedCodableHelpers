//
//  SingleValueDecodingContainer+AdvancedCodableHelpers.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2019-11-27.
//

import Foundation
import Nillable
import BasicCodableHelpers
import SwiftClassCollections

public extension SingleValueDecodingContainer {
    /// Dynamically decode a given type.
    /// - Parameters:
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    func decode<T>(decodingFunc: (_ decoder: Decoder) throws -> T) throws -> T {
        let wrappedDecoder = try self.decode(DecoderCatcher.self)
        return try decodingFunc(wrappedDecoder.decoder)
    }
    
    /// Dynamically decode a given type if present.
    /// - Parameters:
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    func decodeIfPresent<T>(decodingFunc: (_ decoder: Decoder) throws -> T) throws -> T? {
        guard !self.decodeNil() else { return nil }
        return try decode(decodingFunc: decodingFunc)
    }
    
    /// Dynamically decode a given type if present.
    /// - Parameters:
    ///   - defaultValue: The default value to return if object not present
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    func decodeIfPresent<T>(withDefaultValue defaultValue: @autoclosure () -> T,
                            decodingFunc: (_ decoder: Decoder) throws -> T) throws -> T {
        return (try self.decodeIfPresent(decodingFunc: decodingFunc)) ?? defaultValue()
    }
}

public extension SingleValueDecodingContainer {
    
    /// Decode a Dictionary type based on return from the given container
    ///
    /// - Parameters:
    ///   - excludingKeys: Any keys to exclude from the top level
    ///   - customDecoding: Function to try and do custom decoding of complex objects or nil if no custom decoded required
    /// - Returns: Return a dictionary type based on return from the given container
    func decodeAnyDictionary<D>(excludingKeys: [D.Key] = [],
                             customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> D where D: ReEncapsulatableDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
        
        let catcher = try self.decode(DecoderCatcher.self)
        let container = try catcher.decoder.container(keyedBy: CodableKey.self)
        return try container.decodeAndRemapDictionary(excludingKeys: excludingKeys.map({ return $0.dynamicCodingKey }),
                                               customDecoding: customDecoding)
        
    }
    
    /// Decode a Dictionary type based on return from the given container if present
    ///
    /// - Parameters:
    ///   - excludingKeys: Any keys to exclude from the top level
    ///   - customDecoding: Function to try and do custom decoding of complex objects or nil if no custom decoded required
    /// - Returns: Return a dictionary type based on return from the given container if present otherwise nil
    func decodeAnyDictionaryIfPresent<D>(excludingKeys: [D.Key] = [],
                                      customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> D? where D: ReEncapsulatableDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
        guard !self.decodeNil() else { return nil }
        return try self.decodeAnyDictionary(excludingKeys: excludingKeys,
                                         customDecoding: customDecoding)
        
    }
    
    /// Decode a Dictionary type based on return from the given container if present
    ///
    /// - Parameters:
    ///   - excludingKeys: Any keys to exclude from the top level
    ///   - defaultValue: The default value to use if the dictionary not present
    ///   - customDecoding: Function to try and do custom decoding of complex objects or nil if no custom decoded required
    /// - Returns: Return a dictionary type based on return from the given container if present otherwise nil
    func decodeAnyDictionaryIfPresent<D>(excludingKeys: [D.Key] = [],
                                      withDefaultValue defaultValue: @autoclosure () -> D,
                                      customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> D where D: ReEncapsulatableDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
        return (try self.decodeAnyDictionaryIfPresent(excludingKeys: excludingKeys, customDecoding: customDecoding)) ?? defaultValue()
        
    }
    
    /// Decodes an Array<Any> from a SingleValueDecodingContainer
    ///
    /// Decoding sequence tries as follows:
    ///    Int, UInt, Float, String, Double, Bool, Date, Data, Complex Object, Array
    ///
    /// - Parameters:
    ///   - customDecoding: a method for custom decoding of complex objects
    /// - Returns: Returns an array of decoded objects
    func decodeAnyArray(customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> Array<Any>  {
        let catcher = try self.decode(DecoderCatcher.self)
        
        var container = try catcher.decoder.unkeyedContainer()
        return try container.decodeAnyArray(customDecoding: customDecoding)
        
    }
    
    /// Decodes an Array<Any> from a SingleValueDecodingContainer if present
    ///
    /// Decoding sequence tries as follows:
    ///    Int, UInt, Float, String, Double, Bool, Date, Data, Complex Object, Array
    ///
    /// - Parameters:
    ///   - customDecoding: a method for custom decoding of complex objects
    /// - Returns: Returns an array of decoded objects otherwise if not present
    func decodeAnyArrayIfPresent(customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> Array<Any>?  {
        guard !self.decodeNil() else { return nil }
        return try self.decodeAnyArray(customDecoding: customDecoding)
    }
    
    /// Decodes an Array<Any> from the container if present
    ///
    /// Decoding sequence tries as follows:
    ///    Int, UInt, Float, String, Double, Bool, Date, Data, Complex Object, Array
    ///
    /// - Parameters:
    ///   - defalutValue: The value to return if object not found
    ///   - customDecoding: a method for custom decoding of complex objects
    /// - Returns: Returns an array of decoded objects otherwise if not present
    func decodeAnyArrayIfPresent(withDefalutValue defaultValue: @autoclosure () -> Array<Any>,
                              customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> Array<Any>  {
        return (try self.decodeAnyArrayIfPresent(customDecoding: customDecoding)) ?? defaultValue()
    }
}

public extension SingleValueDecodingContainer {
    
    /// Provides an easy method of decoding an optional/single value/array object into an array
    ///
    /// The following rules apply when decoding:
    /// 1. Tries to decode as a single value object and reutrns as a 1 element array
    /// 2. Tries to decode as an array of objects and returns it
    ///
    /// - Parameters:
    ///   - customDecoding: Custom decoding of object type
    /// - Returns: Returns an array of elements that decoded or nil if no key found
    func decodeFromSingleOrArray<Element>(customDecoding: (_ decoder: Decoder) throws -> Element) throws -> [Element] {
        let catcher = try self.decode(DecoderCatcher.self)
        
        
        //if let v = try? customDecoding(WrappedPreKeyedDecoder(self, preKey: key)) { return [v] }
        if let v = try? customDecoding(catcher.decoder) {
            return [v]
       } else {
            var container = try catcher.decoder.unkeyedContainer()
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
    ///   - customDecoding: Custom decoding of object type
    /// - Returns: Returns an array of elements that decoded or nil if no key found
    func decodeFromSingleOrArrayIfPresent<Element>(customDecoding: (_ decoder: Decoder) throws -> Element) throws -> [Element]? {
        guard !self.decodeNil() else { return nil }
        return try self.decodeFromSingleOrArray(customDecoding: customDecoding)
    }
    
    /// Provides an easy method of decoding an optional/single value/array object into an array, or nil if no decoding options were available
    ///
    /// The following rules apply when decoding:
    /// 1. Tries to decode as a single value object and reutrns as a 1 element array
    /// 2. Tries to decode as an array of objects and returns it
    /// 3. returns empty array
    ///
    /// - Parameters:
    ///   - defaultValue: The value to return If object not present
    ///   - customDecoding: Custom decoding of object type
    /// - Returns: Returns an array of elements that decoded or nil if no key found
    func decodeFromSingleOrArrayIfPresent<Element>(withDefaultValue defaultValue: @autoclosure () -> [Element],
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
    func decodeFromSingleOrArrayIfPresentWithEmptyDefault<Element>(customDecoding: (_ decoder: Decoder) throws -> Element) throws -> [Element] {
        
        return try self.decodeFromSingleOrArrayIfPresent(withDefaultValue: [], customDecoding: customDecoding)
       
    }
}
