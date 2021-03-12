# Advanced Codable Helpers
![macOS](https://img.shields.io/badge/os-macOS-green.svg?style=flat)
![Linux](https://img.shields.io/badge/os-linux-green.svg?style=flat)
![Apache 2](https://img.shields.io/badge/license-Apache2-blue.svg?style=flat)
![Swift](https://img.shields.io/badge/Swift->=4.0-green.svg?style=flat)

Helper classes, protocols and functions designed to make more complex encoding/decoding easier.

### Extensions

* **DecoderType**
    * **decode**<T>(from: data, decodingFunc: (Decoder) throws -> T) -> T
       * Provides custom decoding of objects from the root decoding object of any object that implements DecoderType
    * **dtDecode**<T>(from: data, decodingFunc: (Decoder) throws -> T) -> T
        * Provides custom decoding of objects from the root decoding object of any object that implements DecoderType
    * **decodeAnyDictionary**<D>(from data: EncodedData, excludingKeys: [D.Key] = [], customDecoding: @escaping (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> D where D: ReEncapsulatableDictionary, D.Key: DictionaryKeyCodable, D.Value == Any
        * Decode a dictionary with Any as the Value element
    * **decodeAnyArray**(from data: EncodedData, customDecoding: @escaping (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> [Any]
        * Decode an array of Any objects
    * **dynamicElementDecoding**<Element>(_ type: Element.Type, from data: EncodedData, usingKey elementKey: String) throws -> Array<Element> where Element: Decodable
        * Provides an easy way of decoding dictionaries of objects like an array using the key as one of the object property values.
        * **Note**: Array order is not guarenteed.  This is dependant on how the the DecodingType handles Dictionaries
    
* **StandardDecoderType**
    * **decode**<T>(from: Data, decodingFunc: (Decoder) throws -> T) -> T
       * Provides custom decoding of objects from the root decoding object of any object that implements DecoderType (JSONDecoder, PropertyListDecoder, ...)
    * **stdDecode**<T>(from: Data, decodingFunc: (Decoder) throws -> T) -> T
        * Provides custom decoding of objects from the root decoding object of any object that implements DecoderType (JSONDecoder, PropertyListDecoder, ...)
    * **stdDecodeAnyDictionary**<D>(from data: Data, excludingKeys: [D.Key] = [], customDecoding: @escaping (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> D where D: ReEncapsulatableDictionary, D.Key: DictionaryKeyCodable, D.Value == Any
        * Decode a dictionary with Any as the Value element
    * **stdDecodeAnyArray**(from data: EncodedData, customDecoding: @escaping (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> [Any]
        * Decode an array of Any objects
    * **stdDynamicElementDecoding**<Element>(_ type: Element.Type, from data: EncodedData, usingKey elementKey: String) throws -> Array<Element> where Element: Decodable
        * Provides an easy way of decoding dictionaries of objects like an array using the key as one of the object property values.
        * **Note**: Array order is not guarenteed.  This is dependant on how the the DecodingType handles Dictionaries
  
  * **EncoderType**
    * **encodeAnyDictionary**<D>(_ dictionary: D) throws -> EncodedData where D: SDictionary, D.Key: DictionaryKeyCodable, D.Value == Any
        * Encode a dictionary to a container
    * **encodeAnyArray**<S>(_ array: S) throws -> EncodedData where S: Sequence, S.Element == Any
        * Encodes a Sequence of Any objects if supported from the root
    * **dynamicElementEncoding**<S>(_ s: S, usingKey elementKey: String) throws -> EncodedData where S: Sequence, S.Element: Encodable
        * Provides an easy way of encoding an array of objects like a dictionary using one of the object properties as the key.
        * **Note**: Array order is not guarenteed.  This is dependant on how the the EncodingType handles Dictionaries
    * **encodeArray**<S>(_ array: S) throws -> EncodedData where S: Sequence, S.Element == Any
    
  * **StandardEncoderType**
    * **stdEncodeAnyDictionary**<D>(_ dictionary: D) throws -> EncodedData where D: SDictionary, D.Key: DictionaryKeyCodable, D.Value == Any
        * Encode a dictionary to a container
    * **stdEncodeAnyArray**<S>(_ array: S) throws -> EncodedData where S: Sequence, S.Element == Any
        * Encodes a Sequence of Any objects if supported from the root
    * **dynamicElementEncoding**<S>(_ s: S, usingKey elementKey: String) throws -> EncodedData where S: Sequence, S.Element: Encodable
        * Provides an easy way of encoding an array of objects like a dictionary using one of the object properties as the key.
        * **Note**: Array order is not guarenteed.  This is dependant on how the the EncodingType handles Dictionaries
    * **encodeArray**<S>(_ array: S) throws -> EncodedData where S: Sequence, S.Element == Any
    
* **Decoder**
    * **decodeFromSingleOrArray**<Element>(customDecoding: (_ decoder: Decoder) throws -> Element) throws -> [Element]
        * Provides an easy method of decoding an optional/single value/array object into an array
    * **dynamicElementDecoding**<Element>(usingKey elementKey: String, decodingFunc: (_ decoder: Decoder) throws -> Element) throws -> Array<Element>
        * Provides an easy way of decoding dictionaries of objects like an array using the key as one of the object property values.
        * **Note**: Array order is not guarenteed.  This is dependant on how the the DecodingType handles Dictionaries

* **Encoder**
    * **encodeToSingleOrArray**<C>(_ collection: C) throws -> SingleOrArrayEncodedAs  where C: Collection, C.Element: Encodable
        * Provides an easy method to encode an array of encodable objects in a dynamic way
    * **dynamicElementEncoding**<S>(_ s: S, usingKey elementKey: String) throws where S: Sequence, S.Element: Encodable
        * Provides an easy way of encoding an array of objects like a dictionary using one of the object properties as the key.
        * **Note**: Array order is not guarenteed.  This is dependant on how the the EncodingType handles Dictionaries
  
* **KeyedDecodingContainerProtocol**
    * **decode**<T>(forKey key: Self.Key, decodingFunc: (Decoder) throws -> T) throws -> T
       * Provides custom decoding of an object
    * **decodeArray**<T>(forKey key: Self.Key, decodingFunc: (Decoder) throws -> T) throws -> [T]
       * Provides custom decoding of an array of objects
        * Provides custom decoding of an array of objects if present otherwise returns defaultValue
    * **decodeAnyDictionary**<D>(forKey key: Key, excludingKeys: [D.Key] = [], customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> D where D: ReEncapsulatableDictionary, D.Key: DictionaryKeyCodable, D.Value == Any
        * Decode a Dictionary type based on return from the given container
    * **decodeAnyArray**(forKey key: Key, customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> Array<Any>
        * Decodes an Array<Any> from the container
    * **decodeFromSingleOrArray**<Element>(forKey key: Key, customDecoding: (_ decoder: Decoder) throws -> Element) throws -> [Element]
        * Provides an easy method of decoding an optional/single value/array object into an array
     
* **KeyedEncodingContainerProtocol**
    * **encodeAnyDictionary**<D>(_ dictionary: D, forKey key: Key) throws where D: SDictionary, D.Key: DictionaryKeyCodable, D.Value == Any
        * Encode a dictionary to a container where the Value type is Any
    * **encodeAnyDictionaryIfPresent**<D>(_ dictionary: D?, forKey key: Key) throws -> Bool where D: SDictionary, D.Key: DictionaryKeyCodable, D.Value == Any
        * Encode a dictionary to a container where the Value type is Any
        * Returns true if encoding occured, otherwise false
    * **encodeAnyArray**<S>(_ array: S, forKey key: Key) throws where S: Sequence, S.Element == Any
        * Encodes an array of Any to an UnkeyedEncodingContainer if possible
    * **encodeAnyArrayIfPresent**<S>(_ array: S?, forKey key: Key) throws -> Bool where S: Sequence, S.Element == Any
        * Encodes an array of Any to an UnkeyedEncodingContainer if possible
        * Returns true if encoding occured, otherwise false
       
* **SingleValueDecodingContainer**
    * **decode**<T>(decodingFunc: (Decoder) throws -> T) throws -> T
       * Provides custom decoding of an object
    * **decodeArray**<T>(decodingFunc: (Decoder) throws -> T) throws -> [T]
       * Provides custom decoding of an array of objects
    * **decodeAnyDictionary**<D>(excludingKeys: [D.Key] = [], customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> D where D: ReEncapsulatableDictionary, D.Key: DictionaryKeyCodable, D.Value == Any
        * Decode a Dictionary type based on return from the given container
    * **decodeAnyArray**(customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> Array<Any>
        * Decodes an Array<Any> from a Container
    * **decodeFromSingleOrArray**<Element>(customDecoding: (_ decoder: Decoder) throws -> Element) throws -> [Element]
        * Provides an easy method of decoding an optional/single value/array object into an array
       
* **SingleValueEncodingContainer**
    * **encodeAnyDictionary**<D>(_ dictionary: D) throws where D: SDictionary, D.Key: DictionaryKeyCodable, D.Value == Any
        * Encode a dictionary to a container
    * **encodeAnyArray**<S>(_ array: S) throws where S: Sequence, S.Element == Any
        * Encodes an array of Any to the container
        * **Note**: All objects within the array must implement the Encodable protocol

* **UnkeyedDecodingContainer**
    * **decode**<T>(decodingFunc: (Decoder) throws -> T) throws -> T
       * Provides custom decoding of an object
    * **decodeArray**<T>(decodingFunc: (Decoder) throws -> T) throws -> [T]
       * Provides custom decoding of an array of objects
    * **decodeDictionary**<D>(excludingKeys: [D.Key] = [], customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> D where D: ReEncapsulatableDictionary, D.Key: DictionaryKeyCodable, D.Value == Any
        * Decode a Dictionary type based on return from the given container
    * **decodeArray**(_ type: [Any].Type, customDecoding: (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> Array<Any>
        * Decodes an Array<Any> from a Container
    * **decodeFromSingleOrArray**<Element>(customDecoding: (_ decoder: Decoder) throws -> Element) throws -> [Element]
        * Provides an easy method of decoding an optional/single value/array object into an array
       
* **UnkeyedEncodingContainer**
    * **encodeAnyDictionary**<D>(_ dictionary: D) throws where D: SDictionary, D.Key: DictionaryKeyCodable, D.Value == Any
        * Encode a dictionary to a container
    * **encodeAnyArray**<S>(_ array: S) throws where S: Sequence, S.Element == Any
        * Encodes an array of Any to the container

### Helper Containers

#### Bridged

Allows for bridging between different CodingKeys

* **BridgedKeyedDecodingContainer**
* **BridgedKeyedEncodingContainer**

#### Delayed

Allows the developer to delay the real encoding process until they decide to

* **DelayedEncoder**
* **DelayedKeyedEncodingContainer**
* **DelayedUnkeyedEncodingContainer**
* **DelayedSingleValueEncodingContainer**

#### Filtered

Allows the developer to filter objects out from being writting to the encoder

* **FilteredKeyedEncodingContainer**
* **FilteredUnkeyedEncodingContainer**

#### FilteredDelayed

Is a combination of filtered and delayed.  These are good for moving properties around

* **FilteredDelayedEncoder**
* **FilteredDelayedKeyedEncodingContainer**
* **FilteredDelayedUnkeyedEncodingContainer**
* **FilteredDelayedSingleValueEncodingContainer**

#### Injected

Allows the developer to add in objects to the decoding process

* **InjectedKeyedDecodingContainer**
* **InjectedSingleValueDecodingContainer**
* **InjectedUnkeyedDecodingContainer**
* **WrappedInjectedKeyedDecodingContainer**

### Helper Coders

Used to calling new coder processing withing an already coding process.  They wrap the current container into a coder object for use on the encode(to:) and the init(from:)

* **WrappedKeyedDecoder**
* **WrappedKeyedEncoder**
* **WrappedSingleValueDecoder**
* **WrappedSingleValueEncoder**
* **WrappedUnkeyedDecoder**
* **WrappedUnkeyedEncoder**

#### Custom CodingPath Wrappers

Used to change the outward looking codingPath on objects.  This is helpful when manipulating the coding path on the fly

* **WrappedKeyedDecodingContainer**
* **WrappedUnkeyedDecodingContainer**
* **WrappedKeyedEncodingContainer**
* **WrappedUnkeyedEncodingContainer**
* **WrappedSingleValueDecodingContainer**
* **WrappedSingleValueEncodingContainer**
* **WrappedDecoder**
* **WrappedEncoder**

### Helper Catchers

Catches either the Encoder or Decoder for use outside the normal coding process

* **EncoderCatcher**
* **DecoderCatcher**

### Helpers

* **CodableHelper** - All static functions within this class are now deprecated.  Please refer to the proper container/encoder/decoder for an equivinalt replacement method
    * **sequences** - Where sequence related helper methods are located
        * **dynamicElementEncoding** - Encodes an array like a dictionary based on a property in the object type
            * **Notes**
                * Array order is not guaranteed
                * CodingPath when encoding will be malformed.  The Dynamic Key will be missing
        * **dynamicElementDecoding** - Decodes a dictionary into an array moving the key to a specific property named value 
            * **Notes**
                * Array order is not guaranteed
                * CodingPath when decoding will be malformed.  The Dynamic Key will be missing
    * **arrays** - Where array related encode/decode helper methods are located
        * **Notes**
            * When working with numeric values with, if the decimal portion is Zero, the encoder will cut it down to an Int, and the decoder will then read it as an Int
            *  When working with Bools stored in Any, on Linux Swift versions 4.0-4.0.3 when decoding they convert to Int.  This is an issue with the JSONDecoder.  It works correctly in 4.2.
    * **dictionaries** - Where dictionary related encode/decode helper methods are located
       * **Notes** 
            * When working with numeric values with, if the decimal portion is Zero, the encoder will cut it down to an Int, and the decoder will then read it as an Int
            * When working with Bools stored in Any, on Linux Swift versions 4.0-4.0.3 when decoding they convert to Int.  This is an issue with the JSONDecoder.  It works correctly in 4.2.


### Protocols

* **CodableSequenceDynamicKeyHelper** - A protocol used on types that implement Sequence that provide the necessary logic to encode into dictionaries based on a specific property name and decode back into an sequence.  This protocol relies on the dynamicElementEncoding and dynamicElementDecoding methods
* **BaseEncoderTypeBoxing** - A protocol for defining the type boxing methods used by the encoders.  Allows for overriding the value being encoding
* **BaseDecoderTypeUnboxing** - A protocol for defining the type unboxing methods used by decoders.  Allows for overriding the value being decoded


## Usage

Object:
```swift
public struct Person {
    let name: String
    let age: Int
}
// Implement Codable on Person
extension Person: Codable {
    ...
}

// Custom Sequence that contains Person objects
public struct PersonSequence: MutableCollection, Codable {
    public typealias Element = Person
    static var ElementKey: String = "name"

    // rest of code to setup this as a MutableCollection
    ...
}
```

Simple Array Coding:
```swift
import CodableHelpers
// Setup array
let array: [Person] = [Person(name: "Person A", age: 36),
                       Person(name: "Person B", age: 30)]

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
// Encode the array
let d = try encoder.dynamicElementEncoding(ary, usingKey: "name")
let s = String(data: d, encoding: .utf8)!
print(s)

let decoder = JSONDecoder()
// Decode the array
let r = try decoder.dynamicElementDecoding(from: d,
                                           usingKey: "name",
                                           ofType: Person.self)
print(r)
```

Custom Sequence Coding:
```swift
import CodableHelpers
// Setup sequence
let p1 = Person(name: "Person A", age: 36)
let p2 = Person(name: "Person B", age: 30)

var array: PersonSequence = PersonSequence()
array.append(p1)
array.append(p2)

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
// Encode the sequence
let d = try encoder.encode(ary)
let s = String(data: d, encoding: .utf8)!
print(s)
            
let decoder = JSONDecoder()
// Decode the sequence
let r = try decoder.decode(PersonSequence.self, from: d)
print(r)
```

## Dependencies

* **[Basic Codable Helpers](https://github.com/TheAngryDarling/SwiftBasicCodableHelpers.git)** - Package that provides basic helper methods on Encoder and Decoder containers
* **[Nillable](https://github.com/TheAngryDarling/SwiftNillable.git)** - Package used to identify nil/NSNull objects when stored in Any format
* **[SwiftClassCollection](https://github.com/TheAngryDarling/SwiftClassCollections.git)** - Package used to work with swift class based collections that are equivalent to Array and Dictionary

## Author

* **Tyler Anger** - *Initial work* - [TheAngryDarling](https://github.com/TheAngryDarling)

## License

This project is licensed under Apache License v2.0 - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

Based on and in some cases copied/modified from [Swift Source Code](https://github.com/apple/swift/blob/master/stdlib/public/core/Codable.swift.gyb) to ensure similar standards when dealing with encoding/decoding.
