//
//  NetworkReachability.swift
//  StorySpark
//
//  Created by James Wolfe on 21/05/2023.
//

import Network

protocol NetworkReachabilityObserver: AnyObject {
    func statusDidChange(status: NWPath.Status)
}

class NetworkReachability {

    struct NetworkChangeObservation {
        weak var observer: NetworkReachabilityObserver?
    }

    private var monitor = NWPathMonitor()
    private var observations = [ObjectIdentifier: NetworkChangeObservation]()
    var testMode: TestMode = .reachable
    var currentStatus: NWPath.Status {
        guard testMode == .reachable else { return .unsatisfied }
        return monitor.currentPath.status
    }

    static let shared = NetworkReachability()

    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            for (id, observations) in self.observations {

                // If any observer is nil, remove it from the list of observers
                guard let observer = observations.observer else {
                    self.observations.removeValue(forKey: id)
                    continue
                }

                DispatchQueue.main.async(execute: {
                    observer.statusDidChange(status: path.status)
                })
            }
        }
        monitor.start(queue: DispatchQueue.global(qos: .background))
    }

    func addObserver(observer: NetworkReachabilityObserver) {
        let id = ObjectIdentifier(observer)
        observations[id] = NetworkChangeObservation(observer: observer)
    }

    func removeObserver(observer: NetworkReachabilityObserver) {
        let id = ObjectIdentifier(observer)
        observations.removeValue(forKey: id)
    }

}

extension NetworkReachability {

    enum TestMode {

        // MARK: - Cases

        case reachable
        case networkUnreachable

    }

}
