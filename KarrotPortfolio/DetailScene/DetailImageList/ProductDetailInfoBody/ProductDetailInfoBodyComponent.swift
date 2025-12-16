import Foundation
import KarrotListKit

struct ProductDetailInfoBodyComponent: Component {
    typealias ViewModel = ProductDetail.DetailProductItem.ProductDetailInfoViewModel
    
    var viewModel: ProductDetail.DetailProductItem.ProductDetailInfoViewModel
    
    func renderContent(coordinator: ()) -> ProductDetailInfoBodyView {
        return ProductDetailInfoBodyView(
            viewModel: viewModel
        )
    }
    
    func render(in content: ProductDetailInfoBodyView, coordinator: ()) {
        content.viewModel = viewModel
    }
    
    var layoutMode: KarrotListKit.ContentLayoutMode {
        return .flexibleHeight(estimatedHeight: 500)
    }
}
