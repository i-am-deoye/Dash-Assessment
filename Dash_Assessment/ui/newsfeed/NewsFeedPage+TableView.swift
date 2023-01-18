//
//  NewsFeedPage+TableView.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//


import UIKit

extension NewsFeedPage {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel.newsfeedCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as! NewsCell
        let news = viewmodel.getNews(by: indexPath.row)
        cell.set(news)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
