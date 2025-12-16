import UIKit
import FlexLayout
import RxSwift

final class SimilarProductView: UIView {
    
    var viewModel: SimilarProductComponent.ViewModel {
        didSet {
            guard viewModel != oldValue else { return }
            applyViewModel()
        }
    }
    
    private let rootFlexContainer: UIView = UIView()
    private let productImage: UIImageView = {
        let imageView: UIImageView = UIImageView()
        return imageView
    }()
    private let productTitle: UILabel = {
        let label = UILabel()
        return label
    }()
    private let productPrice: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private var disposeBag: DisposeBag = .init()
    
    init(viewModel: SimilarProductComponent.ViewModel) {
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
            .define { rootFlex in
                rootFlex.addItem(self.productImage)
                    .width(100%)
                    .height(UIApplication.screenWidth / 2 - 10)
                rootFlex.addItem(self.productTitle)
                rootFlex.addItem(self.productPrice)
            }
    }
    
    private func applyViewModel() {
        self.disposeBag = DisposeBag()
        
        viewModel.productImageURL
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] image in
                self?.productImage.image = image
                self?.productImage.flex.markDirty()
            } onError: { error in
                
            }.disposed(by: disposeBag)
        productTitle.text = viewModel.productTitle
        productPrice.text = viewModel.productPrice

        productTitle.flex.markDirty()
        productPrice.flex.markDirty()
        
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
