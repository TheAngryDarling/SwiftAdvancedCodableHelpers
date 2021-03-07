import XCTest
import Nillable
@testable import AdvancedCodableHelpers
import BasicCodableHelpers

extension String: Error { }


class AdvancedCodableHelpersTests: XCTestCase {
    
    class DynObject: Codable, CustomStringConvertible {
        private enum CodingKeys: String, CodingKey {
            case type
            case int
        }
        public let intValue: Int
        
        public var description: String { return "DynObject(intValue: \(self.intValue))" }
        
        public init(intValue: Int) {
            self.intValue = intValue
        }
        public required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.intValue = try container.decode(Int.self, forKey: .int)
            
        }
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(String(describing: type(of: self)), forKey: .type)
            try container.encode(self.intValue, forKey: .int)
        }
        
        static func dynamicDecoding(from decoder: Decoder) throws -> DynObject {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let encodedType = try container.decode(String.self, forKey: .type)
            switch encodedType {
            case "DynObject": return try DynObject(from: decoder)
            case "SubDynObject": return try SubDynObject(from: decoder)
            default:
                fatalError("Unable to decode type '\(encodedType)'")
            }
        }
        
        static func dynamicArrayDecoding(from decoder: Decoder) throws -> [DynObject] {
            var container = try decoder.unkeyedContainer()
            var rtn: [DynObject] = []
            while !container.isAtEnd {
                
                //let obj = try decodingFunc(WrappedUnkeyedSingleValueDecoder(container))
                let obj = try dynamicDecoding(from: try container.superDecoder())
                rtn.append(obj)
            }
            return rtn
        }
        
    }
    class SubDynObject: DynObject {
        private enum CodingKeys: String, CodingKey {
            case string
        }
        public let stringValue: String
        public override var description: String {
            return "SubDynObject(intValue: \(self.intValue), stringValue: \"\(self.stringValue)\")"
        }
        public init(intValue: Int, stringValue: String) {
            self.stringValue = stringValue
            super.init(intValue: intValue)
        }
        public required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.stringValue = try container.decode(String.self, forKey: .string)
            try super.init(from: decoder)
        }
        override func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(self.stringValue, forKey: .string)
            try super.encode(to: encoder)
        }
    }
    
    struct Name {
        let firstName: String
        let lastName: String
    }
    enum Gender: Codable, Equatable {
        case agender
        case male
        case female
        case bi
        case trans
        case cis
        case fluid
        case intersex
        case other(String)
        
        static let knownGenders: [Gender] = [
            .agender,
            .male,
            .female,
            .bi,
            .trans,
            .cis,
            .fluid,
            .intersex,
        ]
        
        var code: String {
            switch self {
            case .agender: return "a"
            case .male: return "m"
            case .female: return "f"
            case .bi: return "b"
            case .trans: return "t"
            case .cis: return "c"
            case .fluid: return "fl"
            case .intersex: return "i"
            case .other(let rtn): return rtn
            }
        }
        
        
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let stringCode = try container.decode(String.self)
            if let c = Gender.knownGenders.first(where: { $0.code == stringCode }) {
                self = c
            } else {
                self = .other(stringCode)
            }
        }
        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(self.code)
        }
        
        public static func ==(lhs: Gender, rhs: Gender) -> Bool {
            return lhs.code == rhs.code
        }
    }
    struct SubPersonObject: Codable {
        private enum CodingKeys: CodingKey {
            case valA
            case valB
            case valC
        }
        let valA: Bool
        let valB: String?
        let valC: Int
        
        public init(valA: Bool, valB: String?, valC: Int) {
            self.valA = valA
            self.valB = valB
            self.valC = valC
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.valA = try container.decode(Bool.self, forKey: .valA)
            self.valB = try container.decodeIfPresent(String.self, forKey: .valB)
            //self.valB = try container.decode(String.self, forKey: .valB)
            self.valC = try container.decode(Int.self, forKey: .valC)
            //print("SubPersonObject.init(from:) - \(container.codingPath.stringPath)")
            let _ = true
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(self.valA, forKey: .valA)
            try container.encodeIfPresent(self.valB, forKey: .valB)
            try container.encode(self.valC, forKey: .valC)
            //print("SubPersonObject.encode(to:) - \(container.codingPath.stringPath)")
            let _ = true
        }
        
    }
    struct Person: Codable, AnyEquatableFromEquatable {
        let name: Name
        let age: Int
        let gender: Gender
        let subItems: SubPersonObject
    }
    
    struct CodableSequenceArray: CodableSequenceDynamicKeyHelper {
        static var ElementKey: String = "name"
        
        private var ary: [Person] = []
        
        public init() { }
        
        public mutating func append(_ element: Person) { self.ary.append(element) }
        
        init<S>(_ s: S) where S : Sequence, S.Element == Person {
            self.ary.append(contentsOf: s)
        }
        
        public func makeIterator() -> Array<Person>.Iterator {
            return ary.makeIterator()
        }
        
        public mutating func sort() {
            self.ary.sort()
        }
        
    }
    
    func testCodingCustomSequence() {
        let p1 = Person(name: "Person A", age: 36, gender: .agender, subItems: SubPersonObject(valA: true, valB: "Test 1", valC: 1))
        let p2 = Person(name: "Person B", age: 30, gender: .male, subItems: SubPersonObject(valA: false, valB: nil, valC: 2))
        
        var ary: CodableSequenceArray = CodableSequenceArray()
        //var ary: Array<Person> = Array<Person>()
        ary.append(p1)
        ary.append(p2)
        ary.sort()
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let d = try encoder.encode(ary)
            #if verbose
            let s = String(data: d, encoding: .utf8)!
            print(s)
            #endif
            
            let decoder = JSONDecoder()
            var r = try decoder.decode(CodableSequenceArray.self, from: d)
            r.sort()
            #if verbose
            print(r)
            #endif
            
            if !(ary == r) {
                #if verbose
                print("----------------------------")
                print("----------------------------")
                print(ary)
                print("----------------------------")
                print(r)
                #endif
                XCTFail("Arrays do no match")
            }
            
        } catch {
            XCTFail("\(error)")
        }
        
    }
    
    func testCodingArray() {
        let p1 = Person(name: "Person A", age: 36, gender: .female, subItems: SubPersonObject(valA: true, valB: "Test 1", valC: 1))
        let p2 = Person(name: "Person B", age: 30, gender: .bi, subItems: SubPersonObject(valA: false, valB: nil, valC: 2))
        
        var ary: [Person] = [p1, p2]
        ary.sort()
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let d = try CodableHelpers.sequences.dynamicElementEncoding(ary,
                                                                        to: encoder,
                                                                        usingKey: "name")
            //let d = try encoder.encode(ary)
            #if verbose
            let s = String(data: d, encoding: .utf8)!
            print(s)
            #endif
            
            let decoder = JSONDecoder()
            
            //var r = try decoder.decode(CodableSequenceArray.self, from: d)
            var r = try CodableHelpers.sequences.dynamicElementDecoding(from: decoder,
                                                                        withData: d,
                                                                        usingKey: "name",
                                                                        ofType: Person.self)
            r.sort()
            #if verbose
            print(r)
            #endif
            
            if !(ary == r) {
                #if verbose
                print("----------------------------")
                print("----------------------------")
                print(ary)
                print("----------------------------")
                print(r)
                #endif
                XCTFail("Arrays do no match")
            }
            
        } catch {
            XCTFail("\(error)")
        }
        
    }
    
    func testSwiftDictionaryCoding() {
        
        func testDictionaryCoding<K>(_ originalDictionary:  Dictionary<K, Any>) throws -> Bool where K: DictionaryKeyCodable {
            #if verbose
            print(originalDictionary)
            #endif
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            
            
            let d = try CodableHelpers.dictionaries.encode(originalDictionary, to: encoder)  //try encoder.encode(origionalStringDictionary)
            
            #if verbose
            let s = String(data: d, encoding: .utf8)!
            print(s)
            #endif
            
            let decoder = JSONDecoder()
            
            let decodedDict: Dictionary<K, Any> = try CodableHelpers.dictionaries.decode(d, from: decoder)
            
            #if verbose
            print(decodedDict)
            #endif
            
            let rtn = originalDictionary.equals(decodedDict)
            
            if !rtn {
                print("originalDictionary: \n\(originalDictionary)")
                print("decodedDict: \n\(decodedDict)")
            }
            
            return rtn
        }
        
        do {
            
            var originalDictionary = Dictionary<String, Any>()
            originalDictionary["Person A"] = "Name A"
            originalDictionary["Person B"] = "Name B"
            originalDictionary["Person C"] = ["First Name", "Last Name"]
            originalDictionary["Person D"] = Optional<Float>(3.2)
            originalDictionary["Person E"] = 1
            
            let eq = try testDictionaryCoding(originalDictionary)
            
            XCTAssert(eq, "\(type(of: originalDictionary)) Dictionaries don't match")
            
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            
            
            let d = try CodableHelpers.dictionaries.encode(originalDictionary, to: encoder)  //try encoder.encode(origionalStringDictionary)
            
            #if verbose
            let s = String(data: d, encoding: .utf8)!
            print(s)
            #endif
            
            let decoder = JSONDecoder()
            
            let decodedDict: Dictionary<String, Any> = try CodableHelpers.dictionaries.decode(d,
                                                                                              from: decoder,
                                                                                              excludingKeys: [originalDictionary.keys.first!])
            XCTAssert(!decodedDict.keys.contains(originalDictionary.keys.first!), "Excluding key '\(originalDictionary.keys.first!)' was found in decoded dictionary")
            
            #if verbose
            print(decodedDict)
            #endif
            
            
            
        } catch {
            XCTFail("\(error)")
        }
        
        
        do {
            
            var originalDictionary = Dictionary<Int, Any>()
            originalDictionary[1] = "Name A"
            originalDictionary[2] = AnyNil
            originalDictionary[3] = "Name B"
            
            let eq = try testDictionaryCoding(originalDictionary)
            
            XCTAssert(eq, "\(type(of: originalDictionary)) Dictionaries don't match")
            
            
        } catch {
            XCTFail("\(error)")
        }
        
        /*do {
         
         var originalDictionary = Dictionary<Bool, Any>()
         originalDictionary[true] = "Name A"
         originalDictionary[false] = AnyNil
         
         let eq = try testDictionaryCoding(originalDictionary)
         
         XCTAssert(eq, "\(type(of: originalDictionary)) Dictionaries don't match")
         
         
         } catch {
         XCTFail("\(error)")
         }*/
        
    }
    
    func testDynamicDecoding() {
        
        struct ObjectContainer<Object>: Codable where Object: Codable {
            private enum CodingKeys: String, CodingKey {
                case object
            }
            let object: Object
            public init(_ object: Object) { self.object = object}
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                if Object.self == Array<DynObject>.self {
                    let ary: [DynObject] = try container.decode(forKey: .object,
                                                                decodingFunc: DynObject.dynamicArrayDecoding)
                    self.object = ary as! Object
                } else if Object.self == DynObject.self {
                    let obj: DynObject = try container.decode(forKey: .object,
                                                              decodingFunc: DynObject.dynamicDecoding)
                    self.object = obj as! Object
                } else {
                    self.object = try container.decode(Object.self, forKey: .object)
                }
            }
        }
        
        do {
            let origionalObject = SubDynObject(intValue: 10, stringValue: "Two")
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            let encodedData = try encoder.encode(origionalObject)
            
            #if verbose
            let encodedStr = String(data: encodedData, encoding: .utf8)!
            print(encodedStr)
            #endif
            
            let decoder = JSONDecoder()
            let decodedObj = try decoder.decode(from: encodedData, decodingFunc: DynObject.dynamicDecoding)
            XCTAssert(type(of: decodedObj) == type(of: origionalObject))
            XCTAssert(decodedObj == origionalObject)
            
        } catch {
            XCTFail("\(error)")
        }
        
        do {
            let origionalObject = ObjectContainer<DynObject>(SubDynObject(intValue: 10, stringValue: "Two"))
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            let encodedData = try encoder.encode(origionalObject)
            
            #if verbose
            let encodedStr = String(data: encodedData, encoding: .utf8)!
            print(encodedStr)
            #endif
            
            let decoder = JSONDecoder()
            let decodedObj = try decoder.decode(ObjectContainer<DynObject>.self, from: encodedData)
            XCTAssert(type(of: decodedObj) == type(of: origionalObject))
            XCTAssert(decodedObj.object == origionalObject.object)
            
        } catch {
            XCTFail("\(error)")
        }
        
        do {
            let objects: [DynObject] = [SubDynObject(intValue: 10, stringValue: "Two"),
                                        DynObject(intValue: 1)]
            let origionalObject = ObjectContainer<[DynObject]>(objects)
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            let encodedData = try encoder.encode(origionalObject)
            
            #if verbose
            let encodedStr = String(data: encodedData, encoding: .utf8)!
            print(encodedStr)
            #endif
            
            let decoder = JSONDecoder()
            let decodedObj = try decoder.decode(ObjectContainer<[DynObject]>.self, from: encodedData)
            //print(decodedObj)
            XCTAssert(decodedObj.object == origionalObject.object)
            //XCTAssert(type(of: decodedObj) == type(of: origionalObject))
        } catch {
            XCTFail("\(error)")
        }
        
    }
    
    func testExtendedCodeSingleOrArray() {
        let p1 = Person(name: "Person A", age: 36, gender: .trans, subItems: SubPersonObject(valA: true, valB: "Test 1", valC: 1))
        let p2 = Person(name: "Person B", age: 30, gender: .cis, subItems: SubPersonObject(valA: false, valB: nil, valC: 2))
        let testArrays: [[Person]] = [[p1],  [p1, p2]]
        for (index, array) in testArrays.enumerated() {
            do {
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                let d = try encoder.encodeToSingleOrArray(array)
                
                let decoder = JSONDecoder()
                let decoded = try decoder.decodeFromSingleOrArray(Person.self, from: d)
                
                XCTAssertEqual(array, decoded, "[\(index)]: Decoded array does not equal encoded array")
                
                
            } catch {
                XCTFail("Failed [\(index)]:\n\(error)")
            }
        }
        
    }
    
    func testExtendedCodingCustomSequence() {
        let p1 = Person(name: "Person A", age: 36, gender: .fluid, subItems: SubPersonObject(valA: true, valB: "Test 1", valC: 1))
        let p2 = Person(name: "Person B", age: 30, gender: .intersex, subItems: SubPersonObject(valA: false, valB: nil, valC: 2))
        
        var ary: CodableSequenceArray = CodableSequenceArray()
        //var ary: Array<Person> = Array<Person>()
        ary.append(p1)
        ary.append(p2)
        ary.sort()
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let d = try encoder.encode(ary)
            #if verbose
            let s = String(data: d, encoding: .utf8)!
            print(s)
            #endif
            
            let decoder = JSONDecoder()
            var r = try decoder.decode(CodableSequenceArray.self, from: d)
            r.sort()
            #if verbose
            print(r)
            #endif
            
            if !(ary == r) {
                #if verbose
                print("----------------------------")
                print("----------------------------")
                print(ary)
                print("----------------------------")
                print(r)
                #endif
                XCTFail("Arrays do no match")
            }
            
        } catch {
            XCTFail("\(error)")
        }
        
    }
    
    func testExtendedCodingArray() {
        let p1 = Person(name: "Person A", age: 36, gender: .other("Ze"), subItems: SubPersonObject(valA: true, valB: "Test 1", valC: 1))
        let p2 = Person(name: "Person B", age: 30, gender: .other("Mx"), subItems: SubPersonObject(valA: false, valB: nil, valC: 2))
        
        var ary: [Person] = [p1, p2]
        ary.sort()
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let d = try encoder.dynamicElementEncoding(ary, usingKey: "name")
            
            //let d = try encoder.encode(ary)
            #if verbose
            let s = String(data: d, encoding: .utf8)!
            print(s)
            #endif
            
            let decoder = JSONDecoder()
            
            var r = try decoder.dynamicElementDecoding(from: d,
                                                       usingKey: "name",
                                                       ofType: Person.self)
            r.sort()
            #if verbose
            print(r)
            #endif
            
            if !(ary == r) {
                #if verbose
                print("----------------------------")
                print("----------------------------")
                print(ary)
                print("----------------------------")
                print(r)
                #endif
                XCTFail("Arrays do no match")
            }
            
        } catch {
            XCTFail("\(error)")
        }
        
    }
    
    
    func testExtendedSwiftDictionaryEncodingDecoding() {
        
        func testDictionaryCoding<K>(_ originalDictionary:  Dictionary<K, Any>,
                                     customDecoding: @escaping (Decoder) throws -> Any? = { _ in return nil }) throws -> (equals: Bool, encodedData: Data, decoded: Dictionary<K, Any>)  where K: DictionaryKeyCodable {
            #if verbose
            print(originalDictionary)
            #endif
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            
            
            let d = try encoder.encodeDictionary(originalDictionary)  //try encoder.encode(origionalStringDictionary)
            
            //#if verbose
            let s = String(data: d, encoding: .utf8)!
            print(s)
            //#endif
            
            let decoder = JSONDecoder()
            
            let decodedDict: Dictionary<K, Any> = try decoder.decodeDictionary(from: d,
                                                                               customDecoding: customDecoding)
            
            #if verbose
            print(decodedDict)
            #endif
            
            let rtn = originalDictionary.equals(decodedDict)
            
            if !rtn {
                print("originalDictionary: \n\(originalDictionary)")
                print("decodedDict: \n\(decodedDict)")
            }
            
            return (equals: rtn, encodedData: d, decoded: decodedDict)
        }
        
        do {
            
            var originalDictionary = Dictionary<String, Any>()
            originalDictionary["Person A"] = "Name A"
            originalDictionary["Person B"] = "Name B"
            originalDictionary["Person C"] = ["First Name", "Last Name"]
            originalDictionary["Person D"] =  Person(name: "Person D",
                                                     age: 30,
                                                     gender: .agender,
                                                     subItems: SubPersonObject(valA: false,
                                                                               valB: nil,
                                                                               valC: 2))
            originalDictionary["Person E"] = 1
            originalDictionary["Person F"] = AnyNil
            
            let eq = try testDictionaryCoding(originalDictionary) { decoder in
                guard decoder.codingPath.count == 1 &&
                      decoder.codingPath[0].stringValue == "Person D" else {
                    return nil
                }
                return try Person(from: decoder)
            }
            
            XCTAssert(eq.equals, "\(type(of: originalDictionary)) Dictionaries don't match")
            
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            let decoder = JSONDecoder()
            
            let decodedDict: Dictionary<String, Any> = try decoder.decodeDictionary(from: eq.encodedData,
                                                                                    excludingKeys: [originalDictionary.keys.first!])
            XCTAssert(!decodedDict.keys.contains(originalDictionary.keys.first!), "Excluding key '\(originalDictionary.keys.first!)' was found in decoded dictionary")
            
            #if verbose
            print(decodedDict)
            #endif
            
            
            
        } catch {
            XCTFail("\(error)")
        }
        
        
        do {
            
            var originalDictionary = Dictionary<Int, Any>()
            originalDictionary[1] = "Name A"
            originalDictionary[2] = AnyNil
            originalDictionary[3] = "Name B"
            
            let eq = try testDictionaryCoding(originalDictionary)
            
            XCTAssert(eq.equals, "\(type(of: originalDictionary)) Dictionaries don't match")
            
            
        } catch {
            XCTFail("\(error)")
        }
        
        do {
         
            var originalDictionary = Dictionary<Bool, Any>()
            originalDictionary[true] = "Name A"
            originalDictionary[false] = AnyNil
         
            let eq = try testDictionaryCoding(originalDictionary)
         
            XCTAssert(eq.equals, "\(type(of: originalDictionary)) Dictionaries don't match")
         
         
         } catch {
            XCTFail("\(error)")
         }
        
    }
    
    func testExtendedSwiftArrayEncodingDecoding() {
        func testArrayCoding(_ originalArray:  Array<Any>,
                             customDecoding: @escaping (Decoder) throws -> Any? = { _ in return nil }) throws -> Bool {
            #if verbose
            print(originalArray)
            #endif
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            
            
            let d = try encoder.encodeArray(originalArray)
            
            //#if verbose
            let s = String(data: d, encoding: .utf8)!
            print(s)
            //#endif
            
            let decoder = JSONDecoder()
            
            let decodedArray: Array<Any> = try decoder.decode([Any].self,
                                                              from: d,
                                                              customDecoding: customDecoding)
            
            #if verbose
            print(decodedArray)
            #endif
            
            let rtn = originalArray.equals(decodedArray)
            
            if !rtn {
                print("originalArray: \n\(originalArray)")
                print("decodedArray: \n\(decodedArray)")
            }
            
            return rtn
        }
        
        do {
         
            var originalArray = Array<Any>()
            originalArray.append(true)
            originalArray.append("Name A")
            originalArray.append(AnyNil)
            originalArray.append(1)
            originalArray.append(Person(name: "Person A",
                                        age: 36,
                                        gender: .male,
                                        subItems: SubPersonObject(valA: true,
                                                                  valB: "Test 1",
                                                                  valC: 1)))
         
            let eq = try testArrayCoding(originalArray) { decoder in
                
                if decoder.codingPath.count == 1 &&
                      decoder.codingPath[0].stringValue == "Index 0" {
                    return try Bool(from: decoder)
                }
                if decoder.codingPath.count == 1 &&
                      decoder.codingPath[0].stringValue == "Index 4" {
                    return try Person(from: decoder)
                }
                
                return nil
            }
         
            XCTAssert(eq, "\(type(of: originalArray)) arrays don't match")
         
         
         } catch {
            XCTFail("\(error)")
         }
    }

    static var allTests = [
        ("testCodingCustomSequence", testCodingCustomSequence),
        ("testCodingArray", testCodingArray),
        ("testSwiftDictionaryCoding", testSwiftDictionaryCoding),
        ("testDynamicDecoding", testDynamicDecoding),
        
        ("testExtendedCodeSingleOrArray", testExtendedCodeSingleOrArray),
        ("testExtendedCodingCustomSequence", testExtendedCodingCustomSequence),
        ("testExtendedCodingArray", testExtendedCodingArray),
        ("testExtendedSwiftDictionaryEncodingDecoding", testExtendedSwiftDictionaryEncodingDecoding),
        ("testExtendedSwiftArrayEncodingDecoding", testExtendedSwiftArrayEncodingDecoding)
    ]
}

extension AdvancedCodableHelpersTests.Name: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        let n = value.split(separator: " ")
        let f = String(n[0])
        var l = ""
        if n.count > 1 { l = String(n[1]) }
        self.init(firstName: f, lastName: l)
    }
}

extension AdvancedCodableHelpersTests.Name: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let s = try container.decode(String.self)
        self.init(stringLiteral: s)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.firstName + " " + self.lastName)
    }
}

extension AdvancedCodableHelpersTests.Name: Comparable {
    public static func == (lhs: AdvancedCodableHelpersTests.Name,
                           rhs: AdvancedCodableHelpersTests.Name) -> Bool {
        return ((lhs.firstName == rhs.firstName) && (lhs.lastName == rhs.lastName))
    }
    public static func < (lhs: AdvancedCodableHelpersTests.Name,
                          rhs: AdvancedCodableHelpersTests.Name) -> Bool {
        return (lhs.firstName + " " + lhs.lastName) < (rhs.firstName + " " + rhs.lastName)
    }
}

extension AdvancedCodableHelpersTests.SubPersonObject: Equatable {
    public static func == (lhs: AdvancedCodableHelpersTests.SubPersonObject,
                           rhs: AdvancedCodableHelpersTests.SubPersonObject) -> Bool {
        return ((lhs.valA == rhs.valA) && (lhs.valB == rhs.valB) && (lhs.valC == rhs.valC))
    }
}

extension AdvancedCodableHelpersTests.Person: Comparable {
    public static func == (lhs: AdvancedCodableHelpersTests.Person,
                           rhs: AdvancedCodableHelpersTests.Person) -> Bool {
        return ((lhs.age == rhs.age) && (lhs.gender == rhs.gender) && (lhs.name == rhs.name) && (lhs.subItems == rhs.subItems))
    }
    public static func < (lhs: AdvancedCodableHelpersTests.Person,
                          rhs: AdvancedCodableHelpersTests.Person) -> Bool {
        return (lhs.name < rhs.name)
    }
}

extension AdvancedCodableHelpersTests.CodableSequenceArray: Equatable {
    public static func == (lhs: AdvancedCodableHelpersTests.CodableSequenceArray,
                           rhs: AdvancedCodableHelpersTests.CodableSequenceArray) -> Bool {
        return lhs.ary == rhs.ary
    }
}

extension AdvancedCodableHelpersTests.DynObject: Equatable {
    static func == (lhs: AdvancedCodableHelpersTests.DynObject,
                    rhs: AdvancedCodableHelpersTests.DynObject) -> Bool {
        guard type(of: lhs) == type(of: rhs) else { return false}
        return lhs.intValue == rhs.intValue
        
    }
}

extension AdvancedCodableHelpersTests.SubDynObject {
    static func == (lhs: AdvancedCodableHelpersTests.SubDynObject,
                    rhs: AdvancedCodableHelpersTests.SubDynObject) -> Bool {
        guard type(of: lhs) == type(of: rhs) else { return false}
        return (lhs.intValue == rhs.intValue && lhs.stringValue == rhs.stringValue)
        
    }
}

