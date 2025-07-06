//
//  NavigationRouter.swift
//  VINNY
//
//  Created by 홍지우 on 6/25/25.
//

import Foundation

protocol NavigationRoutable {
    var destinations: [NavigationDestination] { get set }
    
    func push(to: NavigationDestination)
    
    func pop()
    
    func popToRoot()
}

@Observable
class NavigationRouter: NavigationRoutable {
    var destinations: [NavigationDestination] = []
    
    func push(to destination : NavigationDestination) {
        destinations.append(destination)
    }
    
    func pop() {
        destinations.removeLast()
    }
    
    func popToRoot() {
        destinations.removeAll()
    }
}
