//
//  Storable.swift
//  NewsAppMVVM
//
//  Created by 神原良継 on 2022/03/21.
//

import UIKit

public protocol Storable: AnyObject, CustomStringConvertible {
    var dispatcher: Dispatcher { get }
}

extension Storable {
    public var description: String {
        String(describing: type(of: self))
    }
    
    public func unregister() {
        self.dispatcher.unregister(store: self)
    }
}
