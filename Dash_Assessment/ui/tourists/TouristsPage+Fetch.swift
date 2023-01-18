//
//  TouristsPage+Fetch.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import UIKit


extension TouristsPage {
    
    
    @objc func fetch() {
        viewmodel.start = progressView.startAnimating
        viewmodel.finished = onFetchedData
        viewmodel.error = { [weak self] message in
            guard let self = self else { return }
            self.onError(message, refresh: self.refresh)
        }
        viewmodel.fetchTourists(by: 1)
    }
    
    private func refresh() {
        self.fetch()
    }
    
    private func onFetchedData() {
        self.progressView.stopAnimating()
        self.tableView.reloadData()
    }
}
