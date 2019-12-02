//
//  ViewController.swift
//  CrewDemo
//
//  Created by Wasim on 13/11/19.
//  Copyright © 2019 Wasim. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var flightDetail = [[FlightDetail]]()
    var arrDates = [String]()
    var dataSource: SectionedTableViewDataSource!
    var refreshControl   = UIRefreshControl()
    var presenter: HomePresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = APP_NAME
        setupView()
        
    }

    fileprivate func setupView() {
        setupRefreshView()
        presenter = HomePresenter(delegate: self)
        presenter?.chekForData()
    }
    
    fileprivate func setupRefreshView() {
        refreshControl.attributedTitle = NSAttributedString(string: STR_PULL_TO_REFRESH)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
        
    }
    @objc func refresh(_ sender: Any) {
        // Call webservice here after reload tableview.
        presenter?.getData()
    }
    //MARK: Display data and reload tableview
    func displayFlightData(_ data: [FlightDetail]) {
        
        let groupedDate = Dictionary.init(grouping: data) { (element) -> String in
            return element.date ?? ""
        }
        let sortedKeys = groupedDate.keys.sorted()
        sortedKeys.forEach { (key) in
            arrDates.append(key)
            let value = groupedDate[key]
            flightDetail.append(value ?? [])
        }
        var myDataSource = [UITableViewDataSource]()
        for item in flightDetail {
            let a = TableViewDataSource.make(for: item)
            myDataSource.append(a)
        }
        
        dataSource = SectionedTableViewDataSource(dataSources: myDataSource)
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.reloadData()
    }
        

}

extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SectionCell.identifier) as? SectionCell else {
            fatalError()
        }
        cell.setupCell(arrDates[section])
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFlight = flightDetail[indexPath.section][indexPath.row]
        guard let homeDetailVC = self.storyboard?.instantiateViewController(withIdentifier: HomeDetailViewController.identifier) as? HomeDetailViewController else {
            return
        }
        homeDetailVC.detailData = selectedFlight
        self.navigationController?.pushViewController(homeDetailVC, animated: true)
        
    }
}

extension HomeViewController : HomeDelegate {
    func didFinishLoadingData(_ data: [FlightDetail]) {
        displayFlightData(data)
    }
    func dataDidFailLoading(_ error: NSError?) {
        if let message = error?.localizedDescription {
            self.showAlert(message)
        }
    }
    func displayProgress() {
        showProgress()
    }
    
    func removeProgress() {
        hideProgress()
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
        
    }
}
