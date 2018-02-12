//
//  PresenterOutput.swift
//  Messenger
//
//  Created by Krasa on 04.01.18.
//  Copyright © 2018 Krasa. All rights reserved.
//

import Foundation

protocol PresenterOutput : class
{
    func numberOfEntities() -> Int
    func entityAt ( indexPath : IndexPath ) -> Any?
}
