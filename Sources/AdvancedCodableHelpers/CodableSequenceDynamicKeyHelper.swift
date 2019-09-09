//
//  CodableSequenceDynamicKeyHelper.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2018-11-03.
//

import Foundation

/// Simple helper protocol that can be used on any sequence to encode/deocde based on a specific key
public protocol CodableSequenceDynamicKeyHelper: CodableSequenceDynamicElementHelper where Element: Codable { }

extension CodableSequenceDynamicKeyHelper {
    
    /// Default method for decoding objects into type Element
    ///
    /// - Parameter decoder: The decoder to decode the new instance of element from
    /// - Returns: Returns a new object of type Element from decoder
    public static func dynamicDecoding( _ decoder: Decoder) throws -> Element {
        return try Element(from: decoder)
    }
}





