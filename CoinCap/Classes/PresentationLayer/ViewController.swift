//
//  ViewController.swift
//  CoinCap
//
//  Created by Nazar Prysiazhnyi on 18.01.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    var subscriptions: Set<AnyCancellable> = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        
        isConnected.receive(on: DispatchQueue.main)
            .sink { isCancelled in
                print(isCancelled)
            }
            .store(in: &subscriptions)
    }
}
