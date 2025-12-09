//
//  HomeItemView.swift
//  KarrotPortfolio
//
//  Created by temp_name on 12/8/25.
//

import RxSwift
import UIKit
import FlexLayout
import PinLayout

import SwiftUI

final class HomeItemView: UIView {
    
    var viewModel: Home.ItemList.ViewModel {
        didSet {
            guard viewModel != oldValue else { return }
            applyViewModel()
        }
    }
    
    private let rootFlexContainer = UIView()
    private let subFlexContainer = UIView()
    private let subTitleFlexContainer = UIView()
    private let disposeBag: DisposeBag = .init()
    
    private let thumbnailImage: UIImageView = {
        let imageView: UIImageView = .init()
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label: UILabel = .init()
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .black
        return label
    }()
    
    private let distanceLabel: UILabel = {
        let label: UILabel = .init()
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .black
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label: UILabel = .init()
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .black
        return label
    }()
    
    private let registTimeLabel: UILabel = {
        let label: UILabel = .init()
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .black
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label: UILabel = .init()
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .black
        return label
    }()
    
    init(viewModel: Home.ItemList.ViewModel) {
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
        rootFlexContainer.flex
            .direction(.row)
            .paddingHorizontal(16.0)
            .paddingVertical(8.0)
            .define { flex in
                flex.addItem(thumbnailImage)
                    .width(150)
                    .height(150)
                
                flex.addItem(subFlexContainer)
                    .grow(1)
                    .direction(.column)
                    .define { subFlex in
                        subFlex.addItem(titleLabel)
                            .marginBottom(10)
                        subFlex.addItem(subTitleFlexContainer)
                            .direction(.row)
                            .define { subTitleFlex in
                                subTitleFlex.addItem(distanceLabel)
                                subTitleFlex.addItem(locationLabel)
                                subTitleFlex.addItem(registTimeLabel)
                                subTitleFlex.addItem(typeLabel)
                            }
                    }
            }
    }
    
    private func applyViewModel() {
        viewModel.image.subscribe { [weak self] in
            self?.thumbnailImage.image = $0
        }.disposed(by: disposeBag)

        titleLabel.text = viewModel.title
        distanceLabel.text = viewModel.distance == nil ?
        "" : viewModel.distance! > 1000 ?
        String(format: "%.1fkm", viewModel.distance! / 1000) : "\(String(describing: viewModel.distance!))m"
        locationLabel.text = viewModel.location
        registTimeLabel.text = "\(viewModel.registDate)"
        typeLabel.text = viewModel.type
        
        thumbnailImage.flex.markDirty()
        titleLabel.flex.markDirty()
        distanceLabel.flex.markDirty()
        locationLabel.flex.markDirty()
        registTimeLabel.flex.markDirty()
        typeLabel.flex.markDirty()
        
        distanceLabel.flex.display(viewModel.distance != nil ? .flex : .none)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootFlexContainer.pin.all()
        rootFlexContainer.flex.layout()
    }
}

@available(iOS 17.0, *)
#Preview {
    
}
