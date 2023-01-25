//
//  CoinAssetsTVCell.swift
//  CoinCap
//
//  Created by Nazar Prysiazhnyi on 24.01.2023.
//

import UIKit

final class CoinAssetsTVCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var symbolLabel: UILabel!
    @IBOutlet private weak var changeLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    // TODO: - add to extension
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    struct State {
        let name: String
        let symbol: String
        let change: String
        let price: String
    }
    
    // MARK: - Properties
    var state: State? {
        didSet {
            configure()
        }
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
 
}

// MARK: - Private methods
private extension CoinAssetsTVCell {
    
    func setupUI() {
        
    }
    
    func configure() {
        guard let state else { return }
        
        self.nameLabel.text = state.name
        self.symbolLabel.text = state.symbol
        
        if let delta = Double(state.change) {
            self.changeLabel.text = String(format: "%.3f", delta) + "%"
            self.changeLabel.textColor = delta >= 0 ? .green : .red
        }
        
        if let price = Double(state.price) {
            self.priceLabel.text = String(format: "%0.7f", price) + " $"
        }
    }
}
