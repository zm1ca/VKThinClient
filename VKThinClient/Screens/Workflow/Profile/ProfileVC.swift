//
//  ProfileVC.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 28.06.21.
//

import UIKit

class ProfileVC: UIViewController {
    
    let dataFetcher = DataFetchingService()
    let cells = ["Друзья", "Группы", "Музыка", "Сообщения"]

    override func viewDidLoad() {
        super.viewDidLoad()
        dataFetcher.getProfileInfo{ profileInfo in
            guard let profileInfo = profileInfo else { print("Failed to get profile info"); return }
            print(profileInfo)
        }
    }
}

extension ProfileVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.reuseID, for: indexPath) as! ProfileCell
        cell.cathegory.text = cells[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HeaderView.instantiate()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        150
    }
}
