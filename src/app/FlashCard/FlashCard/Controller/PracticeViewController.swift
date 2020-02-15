//
//  PracticeViewController.swift
//  FlashCard
//
//  Created by Hồng Mai on 2/10/20.
//  Copyright © 2020 eurecom. All rights reserved.
//

import UIKit

class PracticeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let identifier_table = "PracticeTableViewCell"
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier_table, for: indexPath ) as! PracticeTableViewCell
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
