import UIKit
import FlexLayout
import RxSwift

final class ProductDetailInfoBodyView: UIView {
    
    var viewModel: ProductDetailInfoBodyComponent.ViewModel {
        didSet {
            guard viewModel != oldValue else { return }
            applyViewModel()
        }
    }
    
    private let rootFlexContainer: UIView = UIView()
    private let profileFlexContainer: UIView = UIView()
    private let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    private let registerName: UILabel = {
        let label: UILabel = UILabel()
        return label
    }()
    private let registerLocation: UILabel = {
        let label: UILabel = UILabel()
        return label
    }()
    private let mannerTemperature: UILabel = {
        let label: UILabel = UILabel()
        return label
    }()
    private let mannerDescriptionButton: UIButton = {
        let button: UIButton = .init(type: .system)
        let title: String = "매너온도"
        button.setUnderlinedTitle(
            title: title,
            color: UIColor.systemOrange,
            font: UIFont.systemFont(ofSize: 15, weight: .semibold)
        )
        return button
    }()
    private let productTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    private let productPrice: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    private let categoryButton: UIButton = {
        let button: UIButton = .init(type: .system)
        return button
    }()
    private let registTime: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .systemGray3
        return label
    }()
    private let contentLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .systemGray3
        label.numberOfLines = 0
        return label
    }()
    private let preferredLocation: UILabel = {
        let label: UILabel = UILabel()
        return label
    }()
    
    private var disposeBag: DisposeBag = .init()
    
    init(viewModel: ProductDetailInfoBodyComponent.ViewModel) {
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
            .direction(.column)
            .alignContent(.start)
            .justifyContent(.start)
            .padding(16)
            .define { rootFlex in
                rootFlex.addItem(profileFlexContainer)
                    .direction(.row)
                    .define { profileFlex in
                        profileFlex.addItem(profileImage)
                            .width(50)
                            .height(50)
                        profileFlex.addItem(UIView())
                            .direction(.column)
                            .justifyContent(.center)
                            .define { profileInfoFlex in
                                profileInfoFlex.addItem(registerName)
                                profileInfoFlex.addItem(registerLocation)
                            }
                        profileFlex.addItem(UIView())
                            .grow(1)
                        profileFlex.addItem(UIView())
                            .direction(.column)
                            .justifyContent(.center)
                            .define { mannerTempInfoFlex in
                                mannerTempInfoFlex.addItem(mannerTemperature)
                                mannerTempInfoFlex.addItem(mannerDescriptionButton)
                                    .padding(5)
                            }
                    }
                rootFlex.addItem(productTitle)
                    .paddingVertical(5)
                rootFlex.addItem(productPrice)
                    .paddingVertical(5)
                rootFlex.addItem(UIView())
                    .direction(.row)
                    .define { categoryFlex in
                        categoryFlex.addItem(categoryButton)
                            .padding(5)
                        categoryFlex.addItem(registTime)
                    }
                rootFlex.addItem(contentLabel)
                    .paddingVertical(16)
                rootFlex.addItem(preferredLocation)
        }
    }
    
    private func applyViewModel() {
        self.disposeBag = DisposeBag()
        
        viewModel.profileImage
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] image in
                self?.profileImage.image = image
                self?.profileImage.flex.markDirty()
                self?.setNeedsLayout()
            } onError: { _ in
                //TODO: 상위뷰에 에러 전달
            }.disposed(by: disposeBag)
        registerName.text = viewModel.registerName
        registerLocation.text = viewModel.registerLocation
        mannerTemperature.text = viewModel.mannerTemperature
        productTitle.text = viewModel.productTitle
        productPrice.text = viewModel.price
        categoryButton.setUnderlinedTitle(
            title: viewModel.productCategory,
            color: .systemGray3,
            font: .systemFont(ofSize: 14, weight: .semibold)
        )
        registTime.text = viewModel.registedDate
        contentLabel.text = viewModel.contentText
        preferredLocation.text = viewModel.preferredLocation
        
        registerName.flex.markDirty()
        registerLocation.flex.markDirty()
        mannerTemperature.flex.markDirty()
        productTitle.flex.markDirty()
        productPrice.flex.markDirty()
        categoryButton.flex.markDirty()
        registTime.flex.markDirty()
        contentLabel.flex.markDirty()
        preferredLocation.flex.markDirty()
        
        setNeedsLayout()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        rootFlexContainer.flex.sizeThatFits(
            size: CGSize(width: size.width, height: .nan)
        )
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rootFlexContainer.pin.all()
        rootFlexContainer.flex.layout()
    }
}
