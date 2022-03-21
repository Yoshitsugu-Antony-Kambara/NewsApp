//
//  Actionable.swift
//  NewsAppMVVM
//
//  Created by 神原良継 on 2022/03/21.
//

public protocol Actionable: AnyObject {
    var dispatcher: Dispatcher { get }
}
