//
//  TableViewDataSource.swift
//  CrewDemo
//
//  Created by Wasim on 14/11/19.
//  Copyright © 2019 Wasim. All rights reserved.
//

import UIKit
class TableViewDataSource<Model>: NSObject,UITableViewDataSource {
    
    typealias CellConfigurator = (Model,IndexPath, UITableViewCell) -> Void
    var models: [Model]
    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator
    
    init(models: [Model],
         reuseIdentifier: String,
         cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: reuseIdentifier,
            for: indexPath
        )
        
        cellConfigurator(model,indexPath,cell)
        
        return cell
    }
    
}

extension TableViewDataSource where Model == FlightDetail {
    static func make(for data: [FlightDetail],
                     reuseIdentifier: String = FlightCell.identifier) -> TableViewDataSource {
        return TableViewDataSource(
            models: data,
            reuseIdentifier: reuseIdentifier
        ) { (item,indexPath, cell) in
            let flightCell = cell as! FlightCell
            flightCell.setupCell(item)
        }
    }
    
}

extension TableViewDataSource where Model == String {
    static func make(for data: [String],
                     reuseIdentifier: String = SectionCell.identifier) -> TableViewDataSource {
        return TableViewDataSource(
            models: data,
            reuseIdentifier: reuseIdentifier
        ) { (item,indexPath, cell) in
            let sectionCell = cell as! SectionCell
            sectionCell.setupCell(item)
        }
    }
}
