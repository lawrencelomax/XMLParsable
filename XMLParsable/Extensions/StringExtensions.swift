//
//  StringExtensions.swift
//  XMLParsable
//
//  Created by Lawrence Lomax on 12/08/2014.
//  Copyright (c) 2014 Lawrence Lomax. All rights reserved.
//

import Foundation
import swiftz_core

func InMyDomain(path: String) -> String {
  return "com.github.lawrencelomax.xmlparser." + path
}

extension String {
  public static func withContentsOf(url: NSURL) -> Result<String> {
    var error: NSError? = nil
    let string = self.stringWithContentsOfURL(url, usedEncoding: nil, error: &error)
    return Result.construct(string)(maybeError: error)
  }
  
  public func base64EncodedString() -> String {
    return self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.allZeros)
  }
}
