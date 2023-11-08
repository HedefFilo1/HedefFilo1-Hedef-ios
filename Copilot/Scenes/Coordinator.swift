//
//  Coordinator.swift
//  Copilot
//
//  Created by Jamal on 9/27/23.
//

import Foundation

class Coordinator: NSObject {

    var childCoordinators: [Coordinator] = []

    func start() {
        preconditionFailure("This method needs to be overriden by its subclass.")
    }

    func finish() {
        preconditionFailure("This method needs to be overriden by its subclass.")
    }

    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func removeChildCoordinator(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(of: coordinator) {
            childCoordinators.remove(at: index)
        } else {
            print("Couldn't remove coordinator: \(coordinator). It's not a child coordinator.")
        }
    }

    func childCoordinator<T>(type: T.Type) -> T? {
        return childCoordinators.first(where: { $0 is T }) as? T
    }

    func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T == false }
    }

    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
}
