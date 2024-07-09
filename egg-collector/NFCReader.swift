//
//  NFCReader.swift
//  egg-collector
//
//  Created by Ariel Klevecz on 7/7/24.
//

import Foundation
import CoreNFC


class NFCReader: NSObject, NFCNDEFReaderSessionDelegate {
    var session: NFCNDEFReaderSession?
    
    func beginScanning() {
        guard NFCNDEFReaderSession.readingAvailable else {
            print("NFC is not available on this device")
            return
        }
        
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        session?.alertMessage = "Hold to boop."
        session?.begin()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("The session was invalidated: \(error.localizedDescription)")
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        for message in messages {
            for record in message.records {
                if let string = String(data: record.payload, encoding: .utf8) {
                    print("NFC tag contains: \(string)")
                }
            }
        }
    }
}
