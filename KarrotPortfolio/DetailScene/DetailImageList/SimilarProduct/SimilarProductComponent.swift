import Foundation
import KarrotListKit
import UIKit

struct SimilarProductComponent: Component {
    typealias ViewModel = ProductDetail.DetailProductItem.SimilarProductViewModel
    
    var viewModel: ProductDetail.DetailProductItem.SimilarProductViewModel
    
    func renderContent(coordinator: ()) -> SimilarProductView {
        return SimilarProductView(
            viewModel: viewModel
        )
    }
    
    func render(in content: SimilarProductView, coordinator: ()) {
        content.viewModel = viewModel
    }
    
    var layoutMode: KarrotListKit.ContentLayoutMode {
        return .flexibleHeight(estimatedHeight: UIApplication.screenWidth / 2 - 10)
    }
}
