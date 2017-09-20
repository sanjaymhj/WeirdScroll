//
//  TestTVC.swift
//  WeirdScroll
//
//  Created by Sanjay on 9/20/17.
//  Copyright © 2017 Sanjay. All rights reserved.
//

import UIKit
enum Sections: Int {
    case first, second, third
    
    func getRows(forExpanded state: Bool) -> [Rows] {
        if state {
            return Rows.expanded
        } else {
            return Rows.closed
        }
    }
    
    func getHeaderTitle() -> String {
        return String(describing: self)
    }
}

enum Rows: Int {
    case name, address, address2, city, street, postal, county, email, phone
    
    static let expanded = [name, address, address2, city, street, postal, county, email, phone]
    static let closed = [name, address, email, phone]
    
    
}

class TestTVC: UITableViewController {
    
    var expandedSectionData: [Bool] = [false, false, false]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(UINib(nibName: "TestCell", bundle: nil), forCellReuseIdentifier: "TestCell")
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)?[0] as? HeaderView else {
            return nil
        }
        let sectionEnum = Sections(rawValue: section)
        headerView.mainLabel.text = sectionEnum?.getHeaderTitle() ?? ""
        headerView.backgroundColor = UIColor.lightGray
        return headerView

    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let sectionEnum = Sections(rawValue: section) else { return 0 }
        
        return sectionEnum.getRows(forExpanded: expandedSectionData[section]).count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TestCell.self), for: indexPath) as? TestCell else { return UITableViewCell() }

        // Configure the cell...
        cell.delegate = self
        
        cell.mainLabel.text = String(describing: indexPath.row)

        return cell
    }
}

extension TestTVC: TestCellDelegate {
    func didEndEditing(textField: UITextField, cell: UITableViewCell) {
        //
    }
    
    func didBeginEditing(textField: UITextField, cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell), let section = Sections(rawValue: indexPath.section) else { return }
        if indexPath.row == 2 && !expandedSectionData[indexPath.row] {
            tableView.beginUpdates()
            expandedSectionData[indexPath.section] = true
            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
            tableView.endUpdates()
        }
        
    }
    
    func shouldBeginEditing(textField: UITextField, cell: UITableViewCell) -> Bool {
        return true
    }
}
