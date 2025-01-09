//
//  ViewController.swift
//  Setting-App
//
//  Created by supaja on 2022/12/25.
//

import UIKit

class ViewController: UIViewController {

    //settingModel array를 요소로 하는 array 인스턴스화
    var settingModel = [[SettingModel]]()
    
    func makeData() {
        settingModel.append(
            [SettingModel(leftImageName: "person.circle", menuTitle: "Sign in to your iPhone", subTitle: "Set up iCloud, the App Store, and more", rightImageName: nil)]
        )
        
        settingModel.append([
            SettingModel(leftImageName: "gear", menuTitle: "General", subTitle: nil, rightImageName: "chevron.right"),
            SettingModel(leftImageName: "person.fill", menuTitle: "General", subTitle: nil, rightImageName: "chevron.right"),
            SettingModel(leftImageName: "person.fill", menuTitle: "General", subTitle: nil, rightImageName: "chevron.right")
        ])
    }
    
    //tableView
    @IBOutlet weak var settingTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //필수 코드
        settingTableView.delegate = self
        settingTableView.dataSource = self
        
            //배경 스타일
        settingTableView.backgroundColor = UIColor(white: 245/255, alpha: 1)
        
        //Profile Cell 등록 코드
        settingTableView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: "ProfileCell")
        
        //Menu Cell 등록 코드
        settingTableView.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "MenuCell")
        
        //Nav Controller
        self.title = "Setting" //self 생략가능
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = UIColor(white: 245/255, alpha: 1)
        
        makeData()
    }


}

//추가적인 프로토콜 준수
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingModel[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingModel.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 && indexPath.row == 0 {
            let myidVC = MyIDViewController(nibName: "MyIDViewController", bundle: nil)
            
            self.present(myidVC, animated: true, completion: nil)
        }
        
        else if indexPath.section == 1 && indexPath.row == 0 {
            if let generalVC = UIStoryboard(name: "GeneralViewController", bundle: nil).instantiateViewController(identifier: "GeneralViewController") as? GeneralViewController { self.navigationController?  .pushViewController(generalVC, animated: true)   //네비게이션 컨트롤러를 활용한 이동
                
                
            }
        }
    }
    
    //fix를 누르면 자동으로 생성되는 함수들
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //어떤 셀을 보여지게 할건가? + 순서
        
        //Profile Cell
        //셀 행의 개수가 0개일 때, profile Cell이 보여지게 하고
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
            cell.topTitle.text = settingModel[indexPath.section][indexPath.row].menuTitle
            cell.profileImageView.image = UIImage(systemName: settingModel[indexPath.section][indexPath.row].leftImageName)
            cell.bottomDescription.text = settingModel[indexPath.section][indexPath.row].subTitle
            
            return cell
        }
        
        //Menu Cell
        //셀 행의 개수가 0개가 아닐 때, MenuCell이 보여지게 한다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        
        cell.leftImageView.image = UIImage(systemName: settingModel[indexPath.section][indexPath.row].leftImageName)
            // 색깔 바꾸기
            // cell.leftImageView.tintColor = .red
        
        cell.middleTitle.text = settingModel[indexPath.section][indexPath.row].menuTitle
        cell.rightImageView.image = UIImage(systemName: settingModel[indexPath.section][indexPath.row].rightImageName ?? "")
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            //profile cell의 높이는 자동으로
            return UITableView.automaticDimension
        }
        //그 외(Menu Cell)는 높이를 60으로
        return 60
    }
    
    
}

