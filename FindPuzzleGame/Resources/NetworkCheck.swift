//
//  NetworkCheck.swift
//  FindPuzzleGame
//
//  Created by Nikita on 18.04.23.
//

import Foundation
import Network

final class InternetMonitor {
  static let shared = InternetMonitor()

  private let queue = DispatchQueue.global()
  private let monitor: NWPathMonitor

  public private(set) var isConnected: Bool = false

  public private(set) var connectionType: ConnectionType = .unknown

  enum ConnectionType {
    case wifi
    case cellular
    case ethernet
    case unknown
  }

  public init() {
    monitor = NWPathMonitor()
  }

  public func startMonitoring() {
    monitor.start(queue: queue)
    monitor.pathUpdateHandler = { [weak self] path in
      self?.isConnected = path.status == .satisfied
      self?.getConnectionType(path)
    }
  }

  public func stopMonitoring() {
    monitor.cancel()
  }

  private func getConnectionType(_ path: NWPath) {
    if path.usesInterfaceType(.wifi) {
      connectionType = .wifi
    } else if path.usesInterfaceType(.cellular) {
      connectionType = .cellular
    } else if path.usesInterfaceType(.wiredEthernet) {
      connectionType = .ethernet
    } else {
      connectionType = .unknown
    }
  }
}
