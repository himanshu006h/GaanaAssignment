//
//  ViewController.swift
//  GaanaAssignment
//
//  Created by Himanshu Saraswat on 27/07/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    struct Constants {
        static let cellIdentifier = "GaanaTableViewCell"
        static let cancel = "Cancel"
        static let blank = ""
        static let kWelcome = "welcome_Key"
    }
    
    @IBOutlet weak var gaanaTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var gaanaResponse: GaanaBase?
    //refresh Table logic
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.black
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerGaanaCell()
        self.addrefreshControl()
        self.loadGaanaDetails()
    }
    
    private func loadGaanaDetails(pullToRefresh: Bool = false) {
        if !pullToRefresh {
            startLoadingIndicator()
        }
        // get Data from service
        let gaanaVModel = GaanaViewModel(gaanaInfo: nil, gaanaDelegate: self)
        gaanaVModel.fetchGaanaDetails()
    }
    
    // drag table to refresh contact
    func addrefreshControl() {
        self.gaanaTableView.addSubview(self.refreshControl)
    }
    
    //MARK: Register table cell
    func registerGaanaCell() {
        self.gaanaTableView.register(UINib(nibName: Constants.cellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
    }
    
    func startLoadingIndicator() {
        // start activity spinner
        view.bringSubviewToFront(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        loadGaanaDetails(pullToRefresh: true)
    }
    
    func updateTableView() {
        self.refreshControl.endRefreshing()
        self.activityIndicator.stopAnimating()
        self.gaanaTableView.isHidden = false
        self.gaanaTableView.reloadData()
    }
}


// MARK: Handel data from service
extension ViewController: GaanaInformation {
    func updateGaanaDetails(gaanaDetails: Any?, error: Error?) {

        if error == nil {
            guard let response = gaanaDetails as? GaanaBase else {
                    return
            }
            
            self.gaanaResponse = response
            DispatchQueue.main.async{
                self.updateTableView()
            }
        } else if let erorrDiscription = error {
            DispatchQueue.main.async {
                self.updateTableView()
                let alertViewController = UIAlertController(title: Constants.blank, message: erorrDiscription.localizedDescription, preferredStyle: .alert)
                alertViewController.addAction(UIAlertAction(title: Constants.cancel, style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alertViewController, animated: true, completion: nil)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.gaanaResponse?.sections?.count ?? 0
    }
    //MARK: Table Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? GaanaTableViewCell,
            let details = self.gaanaResponse?.sections else {
                return UITableViewCell()
        }
        
        cell.configureCell(sectionData: details[indexPath.section])
        return cell
    }
}

