//
//  DetailImageListView.swift
//  KarrotPortfolio
//
//  Created by temp_name on 12/12/25.
//

import UIKit
import KarrotListKit

final class ProductDetailImageListView: UIView {
    
    private let configuration = CollectionViewAdapterConfiguration()
    private let layoutAdapter = CollectionViewLayoutAdapter()
    
    private lazy var collectionViewAdapter = CollectionViewAdapter(
        configuration: configuration,
        collectionView: collectionView,
        layoutAdapter: layoutAdapter
    )
    
    private lazy var collectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewCompositionalLayout(
                sectionProvider: layoutAdapter.sectionLayout
            )
        )
        collectionView.isPagingEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()
    
    private var viewModel: ProductDetail.DetailProductItem.ProductDetailInfoViewModel = .empty {
        didSet {
            guard viewModel != oldValue else { return }
            applyViewModels()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defineLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func defineLayout() {
        addSubview(collectionView)
    }
    
    private func resetViewModels(
        _ viewModel: ProductDetail.DetailProductItem.ProductDetailInfoViewModel) {
        updateViewModel(viewModel)
    }
    
    func updateViewModel(
        _ viewModel: ProductDetail.DetailProductItem.ProductDetailInfoViewModel
    ) {
        self.viewModel = viewModel
    }
    
    //TODO: 섹션간의 크기조정 -> marginLayout 등
    private func applyViewModels() {
        collectionViewAdapter.apply(
            List {
                Section(id: "DetailImageSection") {
                    for imageModel in viewModel.productDetailImageViewModels {
                        Cell(
                            id: imageModel.id,
                            component: ProductDetailImageComponent(viewModel: imageModel)
                        )
                    }
                }
                .withSectionLayout(HorizontalLayout(spacing: 0, scrollingBehavior: .paging))
                Section(id: "DetailInfoBody") {
                    Cell(
                        id: viewModel.id,
                        component: ProductDetailInfoBodyComponent(viewModel: viewModel)
                    )
                }
                .withSectionLayout(VerticalLayout())
                Section(id: "SimilarProducts") {
                    for similarProduct in viewModel.similarProducts {
                        Cell(
                            id: similarProduct.id,
                            component: SimilarProductComponent(viewModel: similarProduct)
                        )
                    }
                }.withSectionLayout(
                    VerticalGridLayout(
                        numberOfItemsInRow: 2,
                        itemSpacing: 10,
                        lineSpacing: 10
                    )
                )
            }
        )
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.pin.all()
    }
}
