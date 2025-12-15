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
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private var viewModels: [ProductDetailImageComponent.ViewModel] = [] {
        didSet {
            guard viewModels != oldValue else { return }
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
    
    private func resetViewModels(_ viewModels: [ProductDetailImageComponent.ViewModel]) {
        self.viewModels = []
        updateViewModels(viewModels)
    }
    
    func updateViewModels(_ viewModels: [ProductDetailImageComponent.ViewModel]) {
        self.viewModels = viewModels
    }
    
    private func applyViewModels() {
        collectionViewAdapter.apply(
            List {
                Section(id: "DetailImageSection") {
                    for viewModel in viewModels {
                        Cell(
                            id: viewModel.id,
                            component: ProductDetailImageComponent(viewModel: viewModel)
                        )
                    }
                }
                .withSectionLayout(HorizontalLayout(spacing: 0, scrollingBehavior: .paging))
            }
        )
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.pin.all()
    }
}
