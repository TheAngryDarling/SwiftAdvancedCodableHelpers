//
//  CodingUserInfoKey+AdvancedCodableHelpers.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2021-02-22.
//

import Foundation

internal extension CodingUserInfoKey {
    static var customDecoding: CodingUserInfoKey {
        return CodingUserInfoKey(rawValue: "CodableHelper.customDecoding")!
    }
    
    static var excludingKeys: CodingUserInfoKey {
        return CodingUserInfoKey(rawValue: "CodableHelper.decoder.excludingKeys")!
    }
}
