//
//  DetailImageView.swift
//  KarrotPortfolio
//
//  Created by temp_name on 12/12/25.
//

import UIKit
import RxSwift

final class ProductDetailImageView: UIView {
    
    var viewModel: ProductDetail.DetailProductItem.ViewModel {
        didSet {
            guard viewModel != oldValue else { return }
            applyViewModel()
        }
    }
    
    private let rootFlexContainer: UIView = UIView()
    private let detailImageView: UIImageView = UIImageView()
    private var disposeBag: DisposeBag = .init()
    
    init(viewModel: ProductDetail.DetailProductItem.ViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        defineLayout()
        applyViewModel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func defineLayout() {
        addSubview(rootFlexContainer)
        rootFlexContainer.flex.define { rootFlex in
            rootFlex.addItem(detailImageView)
                .all(0)
        }
    }
    
    private func applyViewModel() {
        viewModel.image
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] image in
                self?.detailImageView.image = image
            }.disposed(by: disposeBag)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        rootFlexContainer.flex.sizeThatFits(
            size: CGSize(width: size.width, height: .nan)
        )
    }
}
