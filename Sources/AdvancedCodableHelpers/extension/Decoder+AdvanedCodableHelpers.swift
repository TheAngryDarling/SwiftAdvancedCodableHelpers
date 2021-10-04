//
//  Decoder+AdvanedCodableHelpers.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2021-02-25.
//

import Foundation
import SwiftClassCollections

public extension Decoder {
    
    /// Provides an easy method of decoding an optional/single value/array object into an array
    ///
    /// the following rules apply when decoding:
    /// 1. Tries to decode as a single value object and reutrns as a 1 element array
    /// 2. Tries to decode as an array of objects and returns it
    ///
    /// - Parameters:
    ///   - customDecoding: Custom decoding of object type
    /// - Returns: Returns an array of elements that decoded
    func decodeFromSingleOrArray<Element>(customDecoding: (_ decoder: Decoder) throws -> Element) throws -> [Element] {
        
        
        if let singleEncoder = try? self.singleValueContainer(),
           let v = try? customDecoding(WrappedSingleValueDecoder(singleEncoder)) {
            return [v]
        } else {
            let container = try self.unkeyedContainer()
            let decoder = WrappedUnkeyedDecoder(container)
            var rtn: [Element] = []
            while !container.isAtEnd {
                //let v = try container.decode(Element.self)
                let v = try customDecoding(decoder)
                rtn.append(v)
            }
            return rtn
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
    ///     let objects = try dynamicElementDecoding(from: decoder, usingKey: "id") {
    ///         return try EncodingElement(from: $0)
    ///     }
    ///
    /// - Parameters:
    ///   - elementKey: The coding key
    ///   - decodingFunc: Function used for decoding data into specific object type.  This helps when the array is a base type/protocol while the instances could be different inherited types
    /// - Returns: Returns an array of decoded objects
    func dynamicElementDecoding<Element>(usingKey elementKey: String,
                                         decodingFunc: (_ decoder: Decoder) throws -> Element) throws -> Array<Element> {
        var list: [Element] = []
        let container = try self.container(keyedBy: CodableKey.self)
        
        for key in container.allKeys {
            let elementContainer = try container.nestedContainer(keyedBy: CodableKey.self,
                                                                 forKey: key)
            // Must decode element here
            let injectableContainer = WrappedInjectedKeyedDecodingContainer<CodableKey>(elementContainer,
                                                                                        injection: (key: elementKey, key.stringValue))
            let subDecoder = WrappedKeyedDecoder<CodableKey>(injectableContainer)
            
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
    ///   - type: The decodable type to decode to
    ///   - elementKey: The coding key
    /// - Returns: Returns an array of decoded objects
    func dynamicElementDecoding<Element>(_ type: Element.Type,
                                         usingKey elementKey: String) throws -> Array<Element> where Element: Decodable {
        return try self.dynamicElementDecoding(usingKey: elementKey,
                                               decodingFunc: Element.init)
    }
    
    /// Decode a Dictionary type based on return from the given decoder
    ///
    /// Note: Same as dtDecodeDictionary
    ///
    /// - Parameters:
    ///   - excludingKeys: Any keys to exclude from the top level
    ///   - customDecoding: Function to try and do custom decoding of complex objects or nil if no custom decoded required
    ///
    /// - Returns: Return a dictionary type based on return
    func decodeAnyDictionary<D>(excludingKeys: [D.Key] = [],
                             customDecoding: @escaping (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> D where D: ReEncapsulatableDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
        let container = try self.container(keyedBy: CodableKey.self)
        return try container.decodeAndRemapDictionary(excludingKeys: excludingKeys.map({ return $0.dynamicCodingKey }),
                                               customDecoding: customDecoding)
    }
    
    /// Decode a Dictionary type based on return from the given decoder
    ///
    /// Note: Same as dtDecodeDictionary
    ///
    /// - Parameters:
    ///   - type: The dictionary type to decode
    ///   - excludingKeys: Any keys to exclude from the top level
    ///   - customDecoding: Function to try and do custom decoding of complex objects or nil if no custom decoded required
    ///
    /// - Returns: Return a dictionary type based on return
    func decodeAnyDictionary<D>(_ type: D.Type,
                                excludingKeys: [D.Key] = [],
                             customDecoding: @escaping (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> D where D: ReEncapsulatableDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
        let rtn: D = try self.decodeAnyDictionary(excludingKeys: excludingKeys,
                                                  customDecoding: customDecoding)
        return rtn
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
        
        var container = try self.unkeyedContainer()
        return try container.decodeAnyArray(customDecoding: customDecoding)
        
    }
}
