//
//  DependencyInjector.swift
//  Messenger
//
//  Created by Krasa on 04.01.18.
//  Copyright © 2018 Krasa. All rights reserved.
//

import Foundation

class DependencyInjector
{
    class func assignPresenter ( view : ViewInput )
    {
        if view is ImagesListViewController
        {
            let presenter = ImagesListPresenter()
            view.assign(presenterInput: presenter, presenterOutput: presenter)
        }
    }
}
