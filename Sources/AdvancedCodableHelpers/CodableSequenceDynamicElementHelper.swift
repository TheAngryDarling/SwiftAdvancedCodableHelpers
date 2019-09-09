//
//  CodableSequenceDynamicElementHelper.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2018-11-03.
//

import Foundation

/// Protocol used to define and help implement dynamic codable objects in a sequence
/// This protocol helps to dynamically define object keys
public protocol CodableSequenceDynamicElementHelper: Sequence, Codable {
    
    /// Defined object element name that will use the elemnt value as the coding key path
    static var ElementKey: String { get }
    
    /// Protocol required initializer for creating new objects that implmenet CodableSequenceDynamicElementHelper
    ///
    /// - parameter s: Sequence of elements to initialize with
    init<S>(_ s: S) where Element == S.Element, S : Sequence
    
    //func getKeyValueFor(_ element: Element) -> String
    
    /// Function called when trying to decode object that uses a object key as the path key
    ///
    /// - parameter decoder:
    static func dynamicDecoding(_ decoder: Decoder) throws -> Element
}


/// Setup basic codable helpers
extension CodableSequenceDynamicElementHelper where Element: Codable {
    
    /// Helper constructor for decoding dynamic keyed elements
    public init(from decoder: Decoder) throws {
        let list: [Element] = try CodableHelpers.sequences.dynamicElementDecoding(from: decoder,
                                                                                  usingKey: Self.ElementKey,
                                                                                  ofType: Element.self)
        self.init(list)
    }
    
    /// Tests to see if two CodingKey arrays match
    private static func codingKeysMatch(_ lhs: [CodingKey], _ rhs: [CodingKey]) -> Bool {
        guard lhs.count == rhs.count else { return false }
        for i in 0..<lhs.count {
            if lhs[i].stringValue != rhs[i].stringValue { return false }
        }
        return true
    }
    
    /// Helper function used to encode dynamically keyed objects
    public func encode(to encoder: Encoder) throws {
        try CodableHelpers.sequences.dynamicElementEncoding(self, to: encoder, usingKey: Self.ElementKey)
    }
}
