//
//  XMLPerformanceTests.swift
//  XMLParsable
//
//  Created by Lawrence Lomax on 11/09/2014.
//  Copyright (c) 2014 Lawrence Lomax. All rights reserved.
//

import Foundation
import XMLParsable
import XCTest
import swiftz_core
import Nimble

class ZooDecodePerformanceTestsFile: XCTestCase {
  func testNodeDOM() {
    let url = Fixtures.Zoo.url()
    
    self.measureBlock {
      for _ in 0...10 {
        let result = LibXMLNodeParserDOM.createTreeWithURL(url) >>- Zoo.decode
        expect(result).to(beAValue())
      }
    }
  }
  
  func testNodeReader() {
    let url = Fixtures.Zoo.url()
    
    self.measureBlock {
      for _ in 0...10 {
        let result = LibXMLNodeParserReader.createTreeWithURL(url) >>- Zoo.decode
        expect(result).to(beAValue())
      }
    }
  }
  
  func testNavigatingDOM() {
    let url = Fixtures.Zoo.url()
    
    self.measureBlock {
      for _ in 0...10 {
        let result = LibXMLNavigatingParserDOM.createWithURL(url) >>- Zoo.decode
        expect(result).to(beAValue())
      }
    }
  }
}

class ZooDecodePerformanceTestsFileHighRedundancy: XCTestCase {
  func testNodeDOM() {
    let url = Fixtures.Zoo.HighRedundancy.url()
    
    self.measureBlock {
      for _ in 0...10 {
        let result = LibXMLNodeParserDOM.createTreeWithURL(url) >>- Zoo.decode
        expect(result).to(beAValue())
      }
    }
  }
  
  func testNodeReader() {
    let url = Fixtures.Zoo.HighRedundancy.url()
    
    self.measureBlock {
      for _ in 0...10 {
        let result = LibXMLNodeParserReader.createTreeWithURL(url) >>- Zoo.decode
        expect(result).to(beAValue())
      }
    }
  }

  func testNavigatingDOM() {
    let url = Fixtures.Zoo.HighRedundancy.url()
    
    self.measureBlock {
      for _ in 0...10 {
        let result = LibXMLNavigatingParserDOM.createWithURL(url) >>- Zoo.decode
        expect(result).to(beAValue())
      }
    }
  }
}

class ZooDecodePerformanceTestsDataHighRedundancy: XCTestCase {
  func testNodeDOM() {
    let data = Fixtures.Zoo.HighRedundancy.data()
    
    self.measureBlock {
      for _ in 0...10 {
        let result = LibXMLNodeParserDOM.createTreeWithData(data) >>- Zoo.decode
        expect(result).to(beAValue())
      }
    }
  }
  
  func testNodeReader() {
    let data = Fixtures.Zoo.HighRedundancy.data()
    
    self.measureBlock {
      for _ in 0...10 {
        let result = LibXMLNodeParserReader.createTreeWithData(data) >>- Zoo.decode
        expect(result).to(beAValue())
      }
    }
  }
  
  func testNavigatingDOM() {
    let data = Fixtures.Zoo.HighRedundancy.data()
    
    self.measureBlock {
      for _ in 0...10 {
        let result = LibXMLNavigatingParserDOM.createWithData(data) >>- Zoo.decode
        expect(result).to(beAValue())
      }
    }
  }
}

class ZooDecodePerformanceTestsData: XCTestCase {
  func testNodeDOM() {
    let data = Fixtures.Zoo.data()
    
    self.measureBlock {
      for _ in 0...10 {
        let result = LibXMLNodeParserDOM.createTreeWithData(data) >>- Zoo.decode
        expect(result).to(beAValue())
      }
    }
  }
  
  func testNodeReader() {
    let data = Fixtures.Zoo.data()
    
    self.measureBlock {
      for _ in 0...10 {
        let result = LibXMLNodeParserReader.createTreeWithData(data) >>- Zoo.decode
        expect(result).to(beAValue())
      }
    }
  }
  
  func testNavigatingDOM() {
    let data = Fixtures.Zoo.data()
    
    self.measureBlock {
      for _ in 0...10 {
        let result = LibXMLNavigatingParserDOM.createWithData(data) >>- Zoo.decode
        expect(result).to(beAValue())
      }
    }
  }
}
