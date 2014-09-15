//
//  XMLParser.swift
//  XMLParsable
//
//  Created by Lawrence Lomax on 23/08/2014.
//  Copyright (c) 2014 Lawrence Lomax. All rights reserved.
//

import Foundation
import swiftz_core

public let XMLParserErrorDomain = InMyDomain("parsers.json")

private func xmlError(message: String) -> NSError {
  return NSError(domain:XMLParserErrorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: message])
}

private func promoteXmlError<V>(message: String)(value: V?) -> Result<V> {
  return Result.promote(decodeError(message))(value: value)
}

/**
*  A Protocol that defines a Parsable Element in XML
*/
public protocol XMLParsableType {
  func parseChildren(elementName: String) -> [Self]
  func parseText() -> String?
}

/**
* A Protocol that defines ways of creating an XMLParsableTypes.
*/
public protocol XMLParsableFactoryType {
  typealias xml: XMLParsableType
  class func createWithData(data: NSData) -> Result<xml>
  class func createWithURL(url: NSURL) -> Result<xml>
}

/**
*  A Helper with Curried Parsing functions and functions composed from the Parsable primitives.
*  This keeps the XMLParsableType as minimal as possible, and this class as convenient as possible.
*/
public final class XMLParser {
  public class func parseChild<X: XMLParsableType>(elementName: String)(xml: X) -> Result<X> {
    return xml.parseChildren(elementName).first |> promoteXmlError("Could not parse child \(elementName)")
  }
  
  public class func parseText<X: XMLParsableType>(xml: X) -> Result<String> {
    return xml.parseText() |> promoteXmlError("Could not parse text")
  }
  
  public class func parseChildren<X: XMLParsableType>(elementName: String)(xml: X) -> Result<[X]> {
    let array = xml.parseChildren(elementName)
    if array.count == 0 {
      return Result.error(xmlError("Any child of tag \(elementName) could not be found"))
    }
    return Result.value(array)
  }
  
  public class func parseChildRecursive<X: XMLParsableType>(elementNames: [String])(xml: X) -> Result<X> {
    return elementNames.reduce(Result.value(xml)) { (parsable: Result<X>, currentElementName) in
      return parsable >>- self.parseChild(currentElementName)
    }
  }
  
  public class func parseChildText<X: XMLParsableType>(elementName: String)(xml: X) -> Result<String> {
    let textParser: X -> Result<String> = promoteXmlError("Could not parse text for child \(elementName)") • { $0.parseText()}
    return self.parseChild(elementName)(xml: xml) >>- textParser
  }
  
  public class func parseChildRecusiveText<X: XMLParsableType>(elementNames: [String])(xml: X) -> Result<String> {
    let textParser: X -> Result<String> = promoteXmlError("Could not parse text for child \(elementNames.last)") • { $0.parseText()}
    return self.parseChildRecursive(elementNames)(xml: xml) >>- textParser
  }
}
