//
//  ImagesListViewController.swift
//  Messenger
//
//  Created by Krasa on 04.01.18.
//  Copyright © 2018 Krasa. All rights reserved.
//

import UIKit

class ImagesListViewController: UIViewController
{
    var presenterInput : PresenterInput?
    var presenterOutput : PresenterOutput?
    
    @IBOutlet weak var tableView: UITableView!
    
    let kTableViewCellNIB = UINib(nibName: "PostTableViewCell", bundle: nil)
    let kTableViewCellReuseIdentifier = "kTableViewCellReuseIdentifier"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        DependencyInjector.assignPresenter(view: self)

        tableView.register(kTableViewCellNIB, forCellReuseIdentifier: kTableViewCellReuseIdentifier)
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self

        
    }
}

//MARK:- протокол ViewInput
extension ImagesListViewController : ViewInput
{
    func assign(presenterInput: PresenterInput, presenterOutput: PresenterOutput)
    {
        self.presenterInput = presenterInput
        self.presenterOutput = presenterOutput
        
        presenterInput.viewLoaded(view: self)
    }
    
    func reloadData()
    {
    }
    
    func beginUpdates()
    {
        tableView.beginUpdates()
    }
    
    func insert(at: IndexPath)
    {
        tableView.insertRows(at: [at], with: .fade)
    }
    
    func delete(at: IndexPath)
    {
        tableView.deleteRows(at: [at], with: .fade)
    }
    
    func move(from: IndexPath, to: IndexPath)
    {
        tableView.moveRow(at: from, to: to)
    }
    
    func update(at: IndexPath)
    {
        tableView.reloadRows(at: [at], with: .fade)
    }
    
    func endUpdates()
    {
        tableView.endUpdates()
    }
}

//MARK:- датасурс да делегаД таблицы
extension ImagesListViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return presenterOutput != nil ? presenterOutput!.numberOfEntities() : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: kTableViewCellReuseIdentifier, for: indexPath) as! PostTableViewCell
        
        if let model = presenterOutput!.entityAt(indexPath: indexPath) as? News
        {
            cell.viewModel = model
        }
        
        return cell
    }
}
