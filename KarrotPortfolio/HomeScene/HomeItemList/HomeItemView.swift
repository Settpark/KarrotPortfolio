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
    private let subInfoFlexContainer = UIView()
    private var disposeBag: DisposeBag = .init()
    
    private let thumbnailImage: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label: UILabel = .init()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let distanceLabel: UILabel = {
        let label: UILabel = .init()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray3
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label: UILabel = .init()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray3
        return label
    }()
    
    private let registTimeLabel: UILabel = {
        let label: UILabel = .init()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray3
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label: UILabel = .init()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray3
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label: UILabel = .init()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let likesLabel: UILabel = {
        let label: UILabel = .init()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray3
        return label
    }()
    
    private let chatLabel: UILabel = {
        let label: UILabel = .init()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray3
        return label
    }()
    
    private let applicantNumLabel: UILabel = {
        let label: UILabel = .init()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray3
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
            .alignContent(.center)
            .paddingHorizontal(16.0)
            .paddingVertical(8.0)
            .define { flex in
                flex.addItem(thumbnailImage)
                    .width(120)
                    .height(120)
                    .marginRight(8)
                
                flex.addItem(subFlexContainer)
                    .grow(1)
                    .direction(.column)
                    .define { subFlex in
                        subFlex.addItem(titleLabel)
                            .marginBottom(10)
                        subFlex.addItem(subTitleFlexContainer)
                            .direction(.row)
                            .justifyContent(.start)
                            .marginBottom(10)
                            .define { subTitleFlex in
                                subTitleFlex.addItem(distanceLabel)
                                    .marginHorizontal(2.5)
                                subTitleFlex.addItem(locationLabel)
                                    .marginHorizontal(2.5)
                                subTitleFlex.addItem(registTimeLabel)
                                    .marginHorizontal(2.5)
                                subTitleFlex.addItem(typeLabel)
                                    .marginHorizontal(2.5)
                            }
                        subFlex.addItem(priceLabel)
                        subFlex.addItem().grow(1)
                        
                        subFlex.addItem(subInfoFlexContainer)
                            .direction(.row)
                            .alignContent(.center)
                            .justifyContent(.end)
                            .define { subInfoFlex in
                                subInfoFlex.addItem(likesLabel)
                                    .marginHorizontal(2.5)
                                subInfoFlex.addItem(chatLabel)
                                    .marginHorizontal(2.5)
                                subInfoFlex.addItem(applicantNumLabel)
                                    .marginHorizontal(2.5)
                            }
                    }
            }
    }
    
    private func applyViewModel() {
        disposeBag = DisposeBag()
        thumbnailImage.image = nil
        
        //MARK: 사람이 찍는 사진이니까, 고해상도 이미지를 잘라서 사용했다고 생각했는데, 다운샘플링한 저해상도 thumbnail용 이미지 필요함. 고해상도 이미지는 상세보기에서 사용하는게 적절할듯
        viewModel.image
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] in
                self?.thumbnailImage.image = $0
                self?.thumbnailImage.flex.markDirty()
            }.disposed(by: disposeBag)

        titleLabel.text = viewModel.title
        distanceLabel.text = viewModel.distance
        locationLabel.text = viewModel.location
        registTimeLabel.text = viewModel.registDate
        typeLabel.text = viewModel.type
        priceLabel.text = viewModel.price
        likesLabel.text = String(describing: viewModel.likes)
        chatLabel.text = String(describing: viewModel.chatNum ?? 0)
        applicantNumLabel.text = String(describing: viewModel.applicantNum ?? 0)
        
        titleLabel.flex.markDirty()
        distanceLabel.flex.markDirty()
        locationLabel.flex.markDirty()
        registTimeLabel.flex.markDirty()
        typeLabel.flex.markDirty()
        priceLabel.flex.markDirty()
        likesLabel.flex.markDirty()
        chatLabel.flex.markDirty()
        applicantNumLabel.flex.markDirty()
        
        distanceLabel.flex.display(viewModel.distance != nil ? .flex : .none)
        likesLabel.flex.display(viewModel.likes != 0 ? .flex : .none)
        chatLabel.flex.display(viewModel.chatNum != nil ? .flex : .none)
        applicantNumLabel.flex.display(viewModel.applicantNum != nil ? .flex : .none)
        //MARK: 명시적으로 호출하지 않으면 이전에 사용한 뷰와 엉키는 현상이 발생함.
        self.setNeedsLayout()
    }
    
    //MARK: rootConatiner의 가로 길이를 지정하지 않으면 예상지 못하게 뷰가 이상하게 그려질 수 있음
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        rootFlexContainer.flex.sizeThatFits(
            size: CGSize(width: size.width, height: .nan)
        )
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootFlexContainer.flex.layout()
        rootFlexContainer.pin.all()
    }
}

@available(iOS 17.0, *)
#Preview {
    
}
