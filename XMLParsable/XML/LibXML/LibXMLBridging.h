//
//  LibXMLBridging.h
//  XMLParsable
//
//  Created by Lawrence Lomax on 18/08/2014.
//  Copyright (c) 2014 Lawrence Lomax. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <libxml/parser.h>
#import <libxml/xmlIO.h>
#import <libxml/xinclude.h>
#import <libxml/tree.h>
#import <libxml/xmlreader.h>

#pragma mark DOM

typedef NS_ENUM(NSInteger, LibXMLElementType) {
  LibXMLElementTypeELEMENT_NODE =	1,
  LibXMLElementTypeATTRIBUTE_NODE = 2,
  LibXMLElementTypeTEXT_NODE = 3,
  LibXMLElementTypeCDATA_SECTION_NODE =	4,
  LibXMLElementTypeENTITY_REF_NODE = 5,
  LibXMLElementTypeENTITY_NODE = 6,
  LibXMLElementTypePI_NODE = 7,
  LibXMLElementTypeCOMMENT_NODE = 8,
  LibXMLElementTypeDOCUMENT_NODE = 9,
  LibXMLElementTypeDOCUMENT_TYPE_NODE =	10,
  LibXMLElementTypeDOCUMENT_FRAG_NODE =	11,
  LibXMLElementTypeNOTATION_NODE = 12,
  LibXMLElementTypeHTML_DOCUMENT_NODE =	13,
  LibXMLElementTypeDTD_NODE =	14,
  LibXMLElementTypeELEMENT_DECL =	15,
  LibXMLElementTypeATTRIBUTE_DECL =	16,
  LibXMLElementTypeENTITY_DECL = 17,
  LibXMLElementTypeNAMESPACE_DECL = 18,
  LibXMLElementTypeXINCLUDE_START =	19
};

void LibXMLDOMDebugPrintAll(const xmlNodePtr node);
void LibXMLDOMDebugPrintNode(const xmlNodePtr node);

const LibXMLElementType LibXMLDOMGetElementType(const xmlNodePtr node);
const xmlNodePtr LibXMLDOMGetChildren(const xmlNodePtr node);
const xmlNodePtr LibXMLDOMGetSibling(const xmlNodePtr node);

NSString * LibXMLDOMGetElementTypeString(const xmlNodePtr node);
NSString * LibXMLDOMGetName(const xmlNodePtr node);
NSString * LibXMLDOMGetText(const xmlNodePtr node);

BOOL LibXMLDOMElementNameEquals(const xmlNodePtr node, NSString *name);

#pragma mark TextReader

typedef NS_ENUM(NSInteger, LibXMLReaderType) {
  LibXMLReaderTypeNONE = 0,
  LibXMLReaderTypeELEMENT = 1,
  LibXMLReaderTypeATTRIBUTE = 2,
  LibXMLReaderTypeTEXT = 3,
  LibXMLReaderTypeCDATA = 4,
  LibXMLReaderTypeENTITY_REFERENCE = 5,
  LibXMLReaderTypeENTITY = 6,
  LibXMLReaderTypePROCESSING_INSTRUCTION = 7,
  LibXMLReaderTypeCOMMENT = 8,
  LibXMLReaderTypeDOCUMENT = 9,
  LibXMLReaderTypeDOCUMENT_TYPE = 10,
  LibXMLReaderTypeDOCUMENT_FRAGMENT = 11,
  LibXMLReaderTypeNOTATION = 12,
  LibXMLReaderTypeWHITESPACE = 13,
  LibXMLReaderTypeSIGNIFICANT_WHITESPACE = 14,
  LibXMLReaderTypeEND_ELEMENT = 15,
  LibXMLReaderTypeEND_ENTITY = 16,
  LibXMLReaderTypeXML_DECLARATION = 17
};

typedef NS_ENUM(NSInteger, LibXMLReaderMode){
  LibXMLReaderModeINITIAL = 0,
  LibXMLReaderModeINTERACTIVE = 1,
  LibXMLReaderModeERROR = 2,
  LibXMLReaderModeEOF =3,
  LibXMLReaderModeCLOSED = 4,
  LibXMLReaderModeREADING = 5
};

NSString * LibXMLReaderGetElementTypeString(const LibXMLReaderType type);
NSString * LibXMLReaderGetReaderMode(const LibXMLReaderMode mode);
NSString * LibXMLReaderGetText(const xmlTextReaderPtr reader);
NSString * LibXMLReaderGetName(const xmlTextReaderPtr reader);
BOOL LibXMLReaderIsEmpty(const xmlTextReaderPtr reader);
