//
//  HomeItemListView.swift
//  KarrotPortfolio
//
//  Created by temp_name on 12/8/25.
//

import UIKit
import KarrotListKit

protocol HomeItemListViewDelegate: AnyObject {
    func resetViewModels()
    func appendViewModels()
    func routeToDetailView()
}

final class HomeItemListView: UIView {
    
    private let configuration = CollectionViewAdapterConfiguration()
    private let layoutAdapter = CollectionViewLayoutAdapter()
    
    private lazy var collectionViewAdapter = CollectionViewAdapter(
        configuration: configuration,
        collectionView: collectionView,
        layoutAdapter: layoutAdapter
    )
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(
            sectionProvider: layoutAdapter.sectionLayout
        )
    )
    
    private var viewModels: [HomeItemComponent.ViewModel] = [] {
        didSet {
            guard viewModels != oldValue else { return }
            applyViewModels()
        }
    }
    
    private weak var itemListDelegate: HomeItemListViewDelegate?
    
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
    
    private func resetViewModels() {
        viewModels = []
        itemListDelegate?.resetViewModels()
    }
    
    private func appendViewModels() {
        itemListDelegate?.appendViewModels()
    }
    
    func setDelegate(_ delegate: HomeItemListViewDelegate) {
        itemListDelegate = delegate
        resetViewModels()
    }
    
    func updateViewModels(_ viewModels: [HomeItemComponent.ViewModel]) {
        self.viewModels.append(contentsOf: viewModels)
    }
    
    private func applyViewModels() {
        collectionViewAdapter.apply(
            List{
                Section(id: "Section") {
                    for viewModel in viewModels {
                        Cell(
                            id: viewModel.id,
                            component: HomeItemComponent(viewModel: viewModel)
                        ).didSelect { [weak self] context in
                            self?.itemListDelegate?.routeToDetailView()
                        }
                    }
                }
                .withSectionLayout(.vertical)
            }.onRefresh{ [weak self] _ in
//                self?.resetViewModels()
            }.onReachEnd(offsetFromEnd: .relativeToContainerSize(multiplier: 1.0)) { [weak self] _ in
//                self?.appendViewModels()
            }
        )
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.pin.all()
    }
}
