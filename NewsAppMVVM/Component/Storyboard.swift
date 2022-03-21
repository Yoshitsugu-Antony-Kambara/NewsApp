//
//  Storyboard.swift
//  NewsAppMVVM
//
//  Created by 神原良継 on 2022/03/21.
//

import Foundation

import UIKit

public enum Storyboard {
    public static func instantiate<UIVC: UIViewController>(_ type: UIVC.Type) -> UIVC {
        let storyboardName = String(describing: type)
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle(for: type))
        let vc = storyboard.instantiateInitialViewController() as! UIVC
        return vc
        
    }
}


//繊維元
    //let viewController = 〇〇ViewController.create()
    //self.navigationController?.pushViewController(viewController, animated: true)

//遷移先
    //static func create() -> Self {
        //Storyboard.instantiate(self)
    //}
