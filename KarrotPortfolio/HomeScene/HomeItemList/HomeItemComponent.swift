//
//  ButtonComponent.swift
//  KarrotPortfolio
//
//  Created by temp_name on 12/8/25.
//

import Foundation
import SwiftUI
import KarrotListKit

struct HomeItemComponent: Component {    
    typealias ViewModel = Home.ItemList.ViewModel
    
    var viewModel: Home.ItemList.ViewModel
    
    func renderContent(coordinator: ()) -> HomeItemView {
        HomeItemView(
            viewModel: viewModel
        )
    }
    
    func render(in content: HomeItemView, coordinator: ()) {
        content.viewModel = viewModel
    }
    
    var layoutMode: KarrotListKit.ContentLayoutMode {
        .flexibleHeight(estimatedHeight: 135)
    }
}
