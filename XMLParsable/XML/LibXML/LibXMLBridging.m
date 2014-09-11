//
//  LibXMLBridging.m
//  XMLParsable
//
//  Created by Lawrence Lomax on 18/08/2014.
//  Copyright (c) 2014 Lawrence Lomax. All rights reserved.
//

#import "LibXMLBridging.h"

#import "LRLHelperMacros.h"

#import <libxml/parser.h>
#import <libxml/xmlIO.h>
#import <libxml/xinclude.h>
#import <libxml/tree.h>
#import <libxml/xmlreader.h>

#pragma mark DOM

void LibXMLDOMDebugPrintAll(const xmlNodePtr node)
{
  LibXMLDOMDebugPrintNode(node);
  
  xmlNodePtr currentChild = node->children;
  while (currentChild != NULL) {
    LibXMLDOMDebugPrintAll(currentChild);
    currentChild = LibXMLDOMGetSibling(currentChild);
  }
}

void LibXMLDOMDebugPrintNode(const xmlNodePtr node)
{
  NSString *string = LibXMLDOMGetElementTypeString(node);

  switch (node->type) {
    case XML_ELEMENT_NODE:
      string = [NSString stringWithFormat:@"%@ %@", string, LibXMLDOMGetName(node)];
      break;
    case XML_TEXT_NODE:
      string = [NSString stringWithFormat:@"%@ %@", string, LibXMLDOMGetText(node)];
      break;
    default:
      break;
  }
  
  NSLog(@"%@", string);
}

NSString * LibXMLDOMGetElementTypeString(xmlNodePtr node)
{
  NSCParameterAssert(node != NULL);
    
  switch (node->type) {
    case XML_ELEMENT_NODE:
      return NSStringify(XML_ELEMENT_NODE);
    case XML_ATTRIBUTE_NODE:
      return NSStringify(XML_ATTRIBUTE_NODE);
    case XML_TEXT_NODE:
      return NSStringify(XML_TEXT_NODE);
    case XML_CDATA_SECTION_NODE:
      return NSStringify(XML_CDATA_SECTION_NODE);
    case XML_ENTITY_REF_NODE:
      return NSStringify(XML_ENTITY_REF_NODE);
    case XML_ENTITY_NODE:
      return NSStringify(XML_ENTITY_NODE);
    case XML_PI_NODE:
      return NSStringify(XML_PI_NODE);
    case XML_COMMENT_NODE:
      return NSStringify(XML_COMMENT_NODE);
    case XML_DOCUMENT_NODE:
      return NSStringify(XML_DOCUMENT_NODE);
    case XML_DOCUMENT_TYPE_NODE:
      return NSStringify(XML_DOCUMENT_TYPE_NODE);
    case XML_DOCUMENT_FRAG_NODE:
      return NSStringify(XML_DOCUMENT_FRAG_NODE);
    case XML_NOTATION_NODE:
      return NSStringify(XML_NOTATION_NODE);
    case XML_HTML_DOCUMENT_NODE:
      return NSStringify(XML_HTML_DOCUMENT_NODE);
    case XML_DTD_NODE:
      return NSStringify(XML_DTD_NODE);
    case XML_ELEMENT_DECL:
      return NSStringify(XML_ELEMENT_DECL);
    case XML_ATTRIBUTE_DECL:
      return NSStringify(XML_ATTRIBUTE_DECL);
    case XML_ENTITY_DECL:
      return NSStringify(XML_ENTITY_DECL);
    case XML_NAMESPACE_DECL:
      return NSStringify(XML_NAMESPACE_DECL);
    case XML_XINCLUDE_START:
      return NSStringify(XML_XINCLUDE_START);
    case XML_XINCLUDE_END:
      return NSStringify(XML_XINCLUDE_END);
    default:
      return @"UNKNOWN";
  }
}

NSString * LibXMLDOMGetName(xmlNodePtr node)
{
  NSCParameterAssert(node != NULL);
  NSCParameterAssert(node->type == XML_ELEMENT_NODE);
  
  const char *name = (const char *) node->name;
  NSCParameterAssert(name != NULL);
  
  return [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
}

NSString * LibXMLDOMGetText(xmlNodePtr node)
{
  NSCParameterAssert(node != NULL);
  NSCParameterAssert(node->type == XML_TEXT_NODE);
  
  const char *name = (const char *) node->content;
  NSCParameterAssert(name != NULL);
  
  return [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
}

const LibXMLElementType LibXMLDOMGetElementType(const xmlNodePtr node)
{
  NSCParameterAssert(node != NULL);

  const LibXMLElementType type = (LibXMLElementType) node->type;
  return type;
}

const xmlNodePtr LibXMLDOMGetChildren(xmlNodePtr node)
{
  NSCParameterAssert(node != NULL);
  return node->children;
}

const xmlNodePtr LibXMLDOMGetSibling(const xmlNodePtr node)
{
  NSCParameterAssert(node != NULL);
  return xmlNextElementSibling(node);
}

BOOL LibXMLDOMElementNameEquals(const xmlNodePtr node, NSString *name)
{
  NSCParameterAssert(node != NULL);
  NSCParameterAssert(name != nil);
  NSCParameterAssert(LibXMLDOMGetElementType(node) == LibXMLElementTypeELEMENT_NODE);
  
  const char *nodeName = (const char *) node->name;
  const char *nameCString = name.UTF8String;
  
  return (strcmp(nodeName, nameCString) == 0);
}

#pragma mark TextReader

NSString * LibXMLReaderGetElementTypeString(const LibXMLReaderType type)
{
  switch (type) {
    case LibXMLReaderTypeNONE:
      return NSStringify(LibXMLReaderTypeNONE);
    case LibXMLReaderTypeELEMENT:
      return NSStringify(LibXMLReaderTypeELEMENT);
    case LibXMLReaderTypeATTRIBUTE:
      return NSStringify(LibXMLReaderTypeATTRIBUTE);
    case LibXMLReaderTypeTEXT:
      return NSStringify(LibXMLReaderTypeTEXT);
    case LibXMLReaderTypeCDATA:
      return NSStringify(LibXMLReaderTypeCDATA);
    case LibXMLReaderTypeENTITY_REFERENCE:
      return NSStringify(LibXMLReaderTypeENTITY_REFERENCE);
    case LibXMLReaderTypeENTITY:
      return NSStringify(LibXMLReaderTypeENTITY);
    case LibXMLReaderTypePROCESSING_INSTRUCTION:
      return NSStringify(LibXMLReaderTypePROCESSING_INSTRUCTION);
    case LibXMLReaderTypeCOMMENT:
      return NSStringify(LibXMLReaderTypeCOMMENT);
    case LibXMLReaderTypeDOCUMENT:
      return NSStringify(LibXMLReaderTypeDOCUMENT);
    case LibXMLReaderTypeDOCUMENT_TYPE:
      return NSStringify(LibXMLReaderTypeDOCUMENT_TYPE);
    case LibXMLReaderTypeDOCUMENT_FRAGMENT:
      return NSStringify(LibXMLReaderTypeDOCUMENT_FRAGMENT);
    case LibXMLReaderTypeNOTATION:
      return NSStringify(LibXMLReaderTypeNOTATION);
    case LibXMLReaderTypeWHITESPACE:
      return NSStringify(LibXMLReaderTypeWHITESPACE);
    case LibXMLReaderTypeSIGNIFICANT_WHITESPACE:
      return NSStringify(LibXMLReaderTypeSIGNIFICANT_WHITESPACE);
    case LibXMLReaderTypeEND_ELEMENT:
      return NSStringify(LibXMLReaderTypeEND_ELEMENT);
    case LibXMLReaderTypeEND_ENTITY:
      return NSStringify(LibXMLReaderTypeEND_ENTITY);
    case LibXMLReaderTypeXML_DECLARATION:
      return NSStringify(LibXMLReaderTypeXML_DECLARATION);
    default:
      return @"INVALID";
  }
}

NSString * LibXMLReaderGetReaderMode(const LibXMLReaderMode mode)
{
  switch (mode) {
    case LibXMLReaderModeINITIAL:
      return NSStringify(LibXMLReaderModeINITIAL);
    case LibXMLReaderModeINTERACTIVE:
      return NSStringify(LibXMLReaderModeINTERACTIVE);
    case LibXMLReaderModeERROR:
      return NSStringify(LibXMLReaderModeERROR);
    case LibXMLReaderModeEOF:
      return NSStringify(LibXMLReaderModeEOF);
    case LibXMLReaderModeCLOSED:
      return NSStringify(LibXMLReaderModeCLOSED);
    case LibXMLReaderModeREADING:
      return NSStringify(LibXMLReaderModeREADING);
    default:
      return @"INVALID";
  }
}

NSString * LibXMLReaderGetText(const xmlTextReaderPtr reader)
{
  NSCParameterAssert(reader != NULL);
  
  const char *text = (const char *) xmlTextReaderValue(reader);
  NSCParameterAssert(text != NULL);
  
  return [NSString stringWithCString:text encoding:NSUTF8StringEncoding];
}

NSString * LibXMLReaderGetName(const xmlTextReaderPtr reader)
{
  NSCParameterAssert(reader != NULL);
  
  const char *name = (const char *) xmlTextReaderName(reader);
  NSCParameterAssert(name != NULL);
  
  return [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
}

BOOL LibXMLReaderIsEmpty(const xmlTextReaderPtr reader)
{
  NSCParameterAssert(reader != NULL);
  
  return xmlTextReaderIsEmptyElement(reader);
}
