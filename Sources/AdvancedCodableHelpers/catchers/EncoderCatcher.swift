//
//  EncoderCatcher.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2018-11-06.
//

import Foundation

/// A class that catches the encoder for use outside the encoding process
public final class EncoderCatcher: Encodable {
    public var encoder: Encoder?
    public init() { self.encoder = nil }
    
    public func encode(to encoder: Encoder) throws {
        self.encoder = encoder
    }
}
