//
//  NetworkMonitor.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-03-05.
//

import Foundation
import Network

final class NetworkMonitor: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    @Published var isConnected = true
    init()
    {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied ? true : false
            }
        }
        monitor.start(queue: queue)
    }
    
}
