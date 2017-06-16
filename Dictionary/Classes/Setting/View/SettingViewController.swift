//
//  SettingViewController.swift
//  Dictionary
//
//  Created by Rocky on 2017/5/23.
//  Copyright © 2017年 Rocky. All rights reserved.
//

import UIKit

class SettingViewController: BaseTableViewController {

    @IBOutlet weak var versionLabel: UILabel!
    
    fileprivate let viewModel = SettingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.hideBottomLine()
        
        bindViewModel()
    }
    
    fileprivate func bindViewModel(){
    
        viewModel.versionDriver
            .drive(versionLabel.rx.text)
            .addDisposableTo(disposeBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
        
            viewModel.clearLocalDataAction()
        }
    }
}
