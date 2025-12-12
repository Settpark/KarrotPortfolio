//
//  DetailImageComponent.swift
//  KarrotPortfolio
//
//  Created by temp_name on 12/12/25.
//

import Foundation
import KarrotListKit

struct ProductDetailImageComponent: Component {
    typealias ViewModel = ProductDetail.DetailImageItem.ViewModel
    
    var viewModel: ProductDetail.DetailImageItem.ViewModel
    
    func renderContent(coordinator: ()) -> ProductDetailImageView {
        ProductDetailImageView(
            viewModel: viewModel
        )
    }
    
    func render(in content: ProductDetailImageView, coordinator: ()) {
        content.viewModel = viewModel
    }
    
    var layoutMode: KarrotListKit.ContentLayoutMode {
        return .fitContainer
    }
}
