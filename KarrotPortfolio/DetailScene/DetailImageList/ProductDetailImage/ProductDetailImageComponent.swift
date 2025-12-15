import Foundation
import KarrotListKit

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
        return .flexibleHeight(estimatedHeight: 200)
    }
}
