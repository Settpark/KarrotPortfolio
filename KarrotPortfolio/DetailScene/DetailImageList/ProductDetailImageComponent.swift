//
//  DetailImageComponent.swift
//  KarrotPortfolio
//
//  Created by temp_name on 12/12/25.
//

import Foundation
import KarrotListKit

//TODO: 컴포넌트를 여러개 생성해서, Section별로 상세정보 UI를 그려보자.
struct ProductDetailImageComponent: Component {
    typealias ViewModel = ProductDetail.DetailProductItem.ProductDetailImageViewModel
    
    var viewModel: ProductDetail.DetailProductItem.ProductDetailImageViewModel
    
    func renderContent(coordinator: ()) -> ProductDetailImageView {
        return ProductDetailImageView(
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
