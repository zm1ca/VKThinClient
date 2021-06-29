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
    var avatarLink: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        dataFetcher.getUserAvatar { self.avatarLink = $0?.photo100!}
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.visibleViewController?.title = "Profile"
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
