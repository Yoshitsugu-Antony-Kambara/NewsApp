//
//  RxDispatcher.swift
//  NewsAppMVVM
//
//  Created by 神原良継 on 2022/03/21.
//

import UIKit
import RxCocoa
import RxSwift

public final class DispatchableDispatcher {
    public let dispatch: AnyObserver<ActionType>
    private let disposeBag = DisposeBag()
    private let dispatcher: RxDispatcher
    
    public init(dispatcher: RxDispatcher = .default) {
        self.dispatcher = dispatcher
        let dispatchSubject = PublishSubject<ActionType>()
        dispatch = dispatchSubject.asObserver()
        dispatchSubject
            .concat(Observable.never())
            .bind(to: dispatcher.dispatch)
            .disposed(by: disposeBag)
    }
}

public final class RegisterableDispatcher {
    public let register: Observable<ActionType>
    private let dispatcher: RxDispatcher
    
    public init(dispatcher: RxDispatcher = .default) {
        self.dispatcher = dispatcher
        register = dispatcher.register
    }
}


public final class RxDispatcher {
    public static let `default` = RxDispatcher()
    
    fileprivate let dispatch: AnyObserver<ActionType>
    fileprivate let register: Observable<ActionType>
    
    public init() {
        let dispatchSubject = PublishSubject<ActionType>()
        
        dispatch = dispatchSubject.asObserver()
        register = dispatchSubject
            .concat(Observable.never())
            .asObservable()
    }
}

public protocol RxActionable: AnyObject {
    var dispatcher: DispatchableDispatcher { get }
}

public protocol RxStorable: AnyObject {
    associatedtype Action: ActionType
    
    var dispatcher: RegisterableDispatcher { get }
    var dispatchedAction: Observable<Action> { get }
}

public extension RxStorable {
    var dispatchedAction: Observable<Action> {
        dispatcher.register.compactMap { $0 as? Action }
    }
}

