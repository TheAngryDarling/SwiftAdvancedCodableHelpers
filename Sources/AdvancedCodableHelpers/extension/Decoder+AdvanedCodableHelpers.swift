//
//  Decoder+AdvanedCodableHelpers.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2021-02-25.
//

import Foundation

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
}
