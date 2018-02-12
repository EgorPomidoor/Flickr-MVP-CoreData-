//
//  ViewInput.swift
//  Messenger
//
//  Created by Krasa on 04.01.18.
//  Copyright © 2018 Krasa. All rights reserved.
//

import Foundation

//MARK:- общий интерфейс
protocol ViewInput : class
{
    func reloadData ()
    func assign ( presenterInput : PresenterInput , presenterOutput : PresenterOutput )
    
    func beginUpdates () -> Void
    func endUpdates () -> Void
    func insert ( at : IndexPath ) -> Void
    func delete ( at : IndexPath ) -> Void
    func move ( from : IndexPath , to : IndexPath ) -> Void
    func update ( at : IndexPath ) -> Void

}
