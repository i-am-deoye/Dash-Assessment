//
//  TouristsPage+TableView.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import UIKit



extension TouristsPage {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel.touristsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TouristCell.identifier, for: indexPath) as! TouristCell
        let user = viewmodel.getTourist(by: indexPath.row)
        cell.set(user)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = viewmodel.getTourist(by: indexPath.row)
        TouristDetailsPage.present(self, with: user)
    }
}
