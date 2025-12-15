//
//  DetailImageComponent.swift
//  KarrotPortfolio
//
//  Created by temp_name on 12/12/25.
//

import Foundation
import KarrotListKit

struct ProductDetailImageComponent: Component {
    typealias ViewModel = ProductDetail.DetailProductItem.ViewModel
    
    var viewModel: ProductDetail.DetailProductItem.ViewModel
    
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
