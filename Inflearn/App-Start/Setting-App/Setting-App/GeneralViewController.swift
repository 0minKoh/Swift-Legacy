//
//  GeneralViewController.swift
//  Setting-App
//
//  Created by supaja on 2022/12/26.
//

import UIKit

class GeneralCell: UITableViewCell {
    
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightImageView: UIImageView! {
        // 이미지가 놓아졌을 때
        didSet {
            rightImageView.image =
            UIImage.init(systemName: "chevron.right")
            
            rightImageView.backgroundColor = .clear
            rightImageView.tintColor = .orange
        }
    }
}

struct GeneralModel {
    var leftTitle = ""
}

class GeneralViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var model = [[GeneralModel]]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralCell", for: indexPath) as! GeneralCell
        
        cell.leftLabel.text =  model[indexPath.section][indexPath.row].leftTitle
        
        return cell
    }
    

    @IBOutlet weak var generalTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "General"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        generalTableView.delegate = self
        generalTableView.dataSource = self
        
        model.append(
        [GeneralModel(leftTitle: "About")]
        )
        
        model.append(
        [GeneralModel(leftTitle: "About"),
        GeneralModel(leftTitle: "About"),
        GeneralModel(leftTitle: "About"),
        GeneralModel(leftTitle: "About"),
        GeneralModel(leftTitle: "About")]
        )
        
        model.append(
        [GeneralModel(leftTitle: "About")]
        )
    }
}
