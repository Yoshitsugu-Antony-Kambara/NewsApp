//
//  HomeActionCreator.swift
//  NewsAppMVVM
//
//  Created by 神原良継 on 2022/03/21.
//

import Foundation
import RxSwift

final class HomeActionCreator: RxActionable {
    let dispatcher: DispatchableDispatcher
    let fetchAppSetting: AnyObserver<Void>()
    private let disposeBag = DisposeBag()
    
    init(dispatcher: DispatchableDispatcher = .init(),
         maintenanceRepository: )
    
    
}
