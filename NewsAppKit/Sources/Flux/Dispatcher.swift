//
//  Dispatcher.swift
//  NewsAppMVVM
//
//  Created by 神原良継 on 2022/03/21.
//

import UIKit
import RxSwift

public protocol ActionType { }

public protocol Middlewarable {
    func willDispatch(store: Storable, actionType: ActionType)
    func didDispatch(store: Storable, actionType: ActionType)
}

public final class Dispatcher {
    public static let `default` = Dispatcher()
    
    private static let queue = DispatchQueue(label: "com.tonyLab.NewsAppMVVM", attributes: .concurrent)
    
    private var middlewares = [Middlewarable]()
    private var observers = [Observer]()
    
    private struct Observer {
        weak var store: Storable?
        let handler: Any
    }
    
    public init() {}
    
    public func append(middleware: Middlewarable) {
        self.middlewares.append(middleware)
    }
    
    public func register<T: ActionType, S: Storable>(store: S, handler: @escaping (T) -> Void) {
        Self.queue.sync {
            let info = Observer(store: store, handler: handler)
            self.observers.append(info)
        }
    }
    
    public func unregister<S: Storable>(store: S) {
        Self.queue.sync {
            self.observers.removeAll { $0.store === store }
        }
    }
    
    public func unregisterAll() {
        Self.queue.sync {
            self.observers = []
        }
    }
    
    public func dispatch<T: ActionType>(type: T) {
        self.observers.forEach { [weak self] observer in
            guard let h = observer.handler as? ((T) -> Void), let store = observer.store else { return }
            
            
            self?.middlewares.forEach {
                $0.willDispatch(store: store, actionType: type)
            }
            
            h(type)
            
            self?.middlewares.forEach {
                $0.didDispatch(store: store, actionType: type)
            }
        }
    }
}
