//
//  HomeViewController.swift
//  Sleep Tracking Demo
//
//  Created by Vishnu Agarwal on 18/06/19.
//  Copyright © 2019 Vishnu Agarwal. All rights reserved.
//

import UIKit
import CoreMotion
import CoreData

class HomeViewController: UIViewController {
    lazy var tableViewSleep: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Sleep> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Sleep> = Sleep.fetchRequest()
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "startDate", ascending: false)]
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.shared.mainManagedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()

    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        MotionHelper.shared.processSleep()
        setupViews()
        try? fetchedResultsController.performFetch()
    }
    func setupViews() {
        tableViewSleep.delegate = self
        tableViewSleep.dataSource = self
        tableViewSleep.reloadData()
        tableViewSleep.rowHeight = UITableView.automaticDimension
        tableViewSleep.estimatedRowHeight = 64
        tableViewSleep.pin(to: view, topEdge: 0, bottomEdge: 0, leadingEdge: 0, trailingEdge: 0)
        tableViewSleep.register(SleepCell.self, forCellReuseIdentifier: "SleepCell")
    }
    func setNavBar() {
        title = "Sleep History"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 18, weight: .medium)]
        navigationController?.navigationBar.barTintColor = Colors.colorTheme
        navigationController?.navigationBar.barStyle = .black
    }
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[0].numberOfObjects ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SleepCell") as! SleepCell
        cell.configure(sleep: fetchedResultsController.object(at: indexPath))
        return cell
    }
}
extension HomeViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableViewSleep.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableViewSleep.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableViewSleep.insertRows(at: [indexPath], with: .fade)
            }
        default:
            break
        }
    }
}
