//
//  DecoderCatcher.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2018-11-06.
//

import Foundation


/// A class that catches the decoder for use outside the normal decoding process
public final class DecoderCatcher: Decodable {
    public var decoder: Decoder
    public init(from decoder: Decoder) throws {
        self.decoder = decoder
    }
}
