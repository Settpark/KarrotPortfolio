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
        return button
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
            .define { rootFlex in
                rootFlex.addItem(profileFlexContainer)
                    .direction(.row)
                    .define { profileFlex in
                        profileFlex.addItem(profileImage)
                            .width(50)
                            .height(50)
                        profileFlex.addItem(UIView())
                            .direction(.column)
                            .define { profileInfoFlex in
                                profileInfoFlex.addItem(registerName)
                                profileInfoFlex.addItem(registerLocation)
                            }
                        profileFlex.addItem(UIView())
                            .grow(1)
                        profileFlex.addItem(UIView())
                            .direction(.column)
                            .define { mannerTempInfoFlex in
                                mannerTempInfoFlex.addItem(mannerTemperature)
                                mannerTempInfoFlex.addItem(mannerDescriptionButton)
                            }
                    }
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
            } onError: { _ in
                //TODO: 상위뷰에 에러 전달
            }.disposed(by: disposeBag)
        registerName.text = viewModel.registerName
        registerLocation.text = viewModel.registerLocation
        mannerTemperature.text = viewModel.mannerTemperature
        
        registerName.flex.markDirty()
        registerLocation.flex.markDirty()
        mannerTemperature.flex.markDirty()
        
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
