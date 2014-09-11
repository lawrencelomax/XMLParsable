//
//  XMLNavigatingParser.swift
//  XMLParsable
//
//  Created by Lawrence Lomax on 26/08/2014.
//  Copyright (c) 2014 Lawrence Lomax. All rights reserved.
//

import Foundation
import swiftz_core

public protocol XMLNavigatingParserType {
  typealias xml: XMLParsableType
  class func createWithData(data: NSData) -> Result<xml>
  class func createWithURL(url: NSURL) -> Result<xml>
}
