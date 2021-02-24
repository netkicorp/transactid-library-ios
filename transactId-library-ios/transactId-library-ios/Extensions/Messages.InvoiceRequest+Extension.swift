//
//  Messages.InvoiceRequest+Extension.swift
//  transactId-library-ios
//
//  Created by Developer on 24.02.2021.
//

import Foundation
import SwiftProtobuf

extension Messages.InvoiceRequest : SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
    
    public static var protoMessageName: String {
        return ".InvoiceRequest"
    }
    
    public mutating func decodeMessage<D>(decoder: inout D) throws where D : Decoder {
        while let fieldNumber = try decoder.nextFieldNumber() {
          switch fieldNumber {
          case 1: try decoder.decodeSingularUInt64Field(value: &self._amount)
          case 2: try decoder.decodeSingularStringField(value: &self._pkiType)
          case 3: try decoder.decodeSingularBytesField(value: &self._pkiData)
          case 4: try decoder.decodeSingularStringField(value: &self._memo)
          case 5: try decoder.decodeSingularStringField(value: &self._notificationURL)
          case 6: try decoder.decodeSingularBytesField(value: &self._signature)
          case 7: try decoder.decodeSingularBytesField(value: &self._evCert)
          default: break
          }
        }
    }
    
    public func traverse<V>(visitor: inout V) throws where V : Visitor {
       
        if let v = self._amount {
          try visitor.visitSingularUInt64Field(value: v, fieldNumber: 1)
        }
        if let v = self._pkiType {
          try visitor.visitSingularStringField(value: v, fieldNumber: 2)
        }
        if let v = self._pkiData {
          try visitor.visitSingularBytesField(value: v, fieldNumber: 3)
        }
        if let v = self._memo {
          try visitor.visitSingularStringField(value: v, fieldNumber: 4)
        }
        if let v = self._notificationURL {
          try visitor.visitSingularStringField(value: v, fieldNumber: 5)
        }
        if let v = self._signature {
          try visitor.visitSingularBytesField(value: v, fieldNumber: 6)
        }
        if let v = self._evCert {
          try visitor.visitSingularBytesField(value: v, fieldNumber: 7)
        }
        try unknownFields.traverse(visitor: &visitor)
    }
    
    public static var _protobuf_nameMap: _NameMap = [
        1: .same(proto: "amount"),
        2: .standard(proto: "pki_type"),
        3: .standard(proto: "pki_data"),
        4: .same(proto: "memo"),
        5: .standard(proto: "notification_url"),
        6: .same(proto: "signature"),
        7: .standard(proto: "ev_cert")
    ]
}
