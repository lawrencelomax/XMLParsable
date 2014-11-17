//
//  Zoo.swift
//  XMLParsable
//
//  Created by Lawrence Lomax on 04/09/2014.
//  Copyright (c) 2014 Lawrence Lomax. All rights reserved.
//

import Foundation
import swiftz_core
import XMLParsable

public struct Animal: XMLDecoderType {
  public let kind: String
  public let name: String
  public let url: NSURL
  
  public static func build(kind: String)(name: String)(url: NSURL) -> Animal {
    return self(kind: kind, name: name, url: url)
  }
  
  public static func decodeImperative<X: XMLParsableType>(xml: X) -> Result<Animal> {
    if let kind = xml.parseChildren("kind").first?.parseText() {
      if let name = xml.parseChildren("nested_nonsense").first?.parseChildren("name").first?.parseText() {
        if let urlString = xml.parseChildren("url").first?.parseText() {
          if let url = NSURL(string: urlString) {
            return Result.value(self(kind: kind, name: name, url: url))
          }
        }
        return Result.Error(XMLParser.error("Could not parse 'urlString' as a String"))
      }
      return Result.Error(XMLParser.error("Could not parse 'name' as a String"))
    }
    return Result.Error(XMLParser.error("Could not parse 'kind' as a String"))
  }
  
  public static func decodeImperativeReturnEarly<X: XMLParsableType>(xml: X) -> Result<Animal> {
    let maybeType = xml.parseChildren("kind").first?.parseText()
    if maybeType == .None {
      return Result.Error(XMLParser.error("Could not parse 'type' as a String"))
    }
    
    let maybeName = xml.parseChildren("name").first?.parseText()
    if maybeName == .None {
      return Result.Error(XMLParser.error("Could not parse 'name' as a String"))
    }

    let maybeUrlString = xml.parseChildren("url").first?.parseText()
    if maybeUrlString == .None {
      return Result.Error(XMLParser.error("Could not parse 'urlString' as a String"))
    }

    let maybeUrl = NSURL(string: maybeUrlString!)
    if maybeUrl == .None {
      return Result.Error(XMLParser.error("Could not parse 'urlString' from a String to a URL"))
    }
    
    return Result.value(self(kind: maybeType!, name: maybeName!, url: maybeUrl!))
  }
  
  public static func decode<X : XMLParsableType>(xml: X) -> Result<Animal> {
    let kind = XMLParser.parseChildText("kind")(xml: xml)
    let name = XMLParser.parseChildRecusiveText(["nested_nonsense", "name"])(xml: xml)
    let url = XMLParser.parseChildText("url")(xml: xml) >>- ({NSURL(string: $0)} <!> XMLParser.promoteError("Could not parse 'url' as an URL"))
    
    return self.build <^> kind <*> name <*> url
  }
}

public struct Zoo: XMLDecoderType {
  public let toiletCount: Int
  public let disabledParking: Bool
  public let drainage: String
  public let animals: [Animal]
  
  public static func build(toiletCount: Int)(disabledParking: Bool)(drainage: String)(animals: [Animal]) -> Zoo {
    return self(toiletCount: toiletCount, disabledParking: disabledParking, drainage: drainage, animals: animals)
  }
  
  public static func decode<X : XMLParsableType>(xml: X) -> Result<Zoo> {
    let toiletCount =  XMLParser.parseChildRecusiveText(["facilities", "toilet"])(xml: xml) >>- (XMLParser.promoteError("Could not intepret 'toilet' as int'") • Int.parseString)
    let disabledParking = XMLParser.parseChildRecusiveText(["facilities", "disabled_parking"])(xml: xml) >>- (XMLParser.promoteError("Could interpret 'disabled_parking' as a Bool") • Bool.parseString)
    let drainage = XMLParser.parseChildRecusiveText(["facilities", "seriously", "crazy_nested", "drainage"])(xml: xml)
    let animals = XMLParser.parseChild("animals")(xml: xml) >>- XMLParser.parseChildren("animal") >>- resultMapC(Animal.decode)
    
    return self.build <^> toiletCount <*> disabledParking <*> drainage <*> animals
  }
}
