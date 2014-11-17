//
//  ModelDecode.swift
//  XMLParsable
//
//  Created by Lawrence Lomax on 12/08/2014.
//  Copyright (c) 2014 Lawrence Lomax. All rights reserved.
//

import Foundation
import swiftz_core

public let ModelDecodeErrorDomain = InMyDomain("xmldecode")

public protocol XMLDecoderType {
  class func decode<X: XMLParsableType>(xml: X) -> Result<Self>
}

public class ModelDecode {
  public class func error(message: String) -> NSError {
    return NSError(domain:ModelDecodeErrorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: message])
  }

  public class func promoteError<V>(message: String)(value: V?) -> Result<V> {
    return ResultExt.promote(ModelDecode.error(message))(value: value)
  }
}
