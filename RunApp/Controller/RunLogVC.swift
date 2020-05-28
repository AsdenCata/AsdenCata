//
//  RunLogVC.swift
//  RunApp
//
//  Created by Dumitru Catalin Vunvulea on 20/05/2020.
//  Copyright © 2020 Dumitru Catalin Vunvulea. All rights reserved.
//

import UIKit

class RunLogVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }


}

extension RunLogVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Run.getAllRuns()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RunLogCell") as? RunLogCell else { return UITableViewCell() }
        guard let run = Run.getAllRuns()?[indexPath.row] else { return RunLogCell()}
        cell.configure(run: run)
        
        return cell
    }
    
    
}

extension RunLogVC: UITableViewDelegate {
    
}
