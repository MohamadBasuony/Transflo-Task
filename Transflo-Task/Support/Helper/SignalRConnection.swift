//
//  SignalRConnection.swift
//  MarketPlace
//
//  Created by Mohamad Basuony on 12/01/2023.
//

import Foundation
import SwiftSignalRClient

class SignalRConnection {
    private var connection: HubConnection?

    static let shared = SignalRConnection()
    
    private init(){}
    
    func startHubConnection(completion: @escaping (HubMessage?) -> Void){
        
        connection = HubConnectionBuilder(url: URL(string: "https://api.stg.omniorder.com.au/chat")!).withLogging(minLogLevel: .error).build()
        connection?.on(method: "friendsListChanged", callback: { argumentExtractor in
            
        })
        connection?.on(method: "BuyerMessageReceived", callback: { (messageStr : String) in
            do {
                let data = messageStr.data(using: .utf8, allowLossyConversion: false)
                let messageObj = try? JSONDecoder().decode(HubMessage.self, from: data ?? Data())
                dump(messageObj)
                completion(messageObj)
            } catch {
                print(error)
            }
        })
        
        connection?.start()
    }
    
}
