import UIKit
import FlexLayout
import RxSwift

final class ProductDetailImageView: UIView {
    
    var viewModel: ProductDetailImageComponent.ViewModel {
        didSet {
            guard viewModel != oldValue else { return }
            applyViewModel()
        }
    }
    
    private let rootFlexContainer: UIView = UIView()
    private let detailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.clipsToBounds = true
        return imageView
    }()
    private var disposeBag: DisposeBag = .init()
    
    init(viewModel: ProductDetailImageComponent.ViewModel) {
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
            .alignContent(.start)
            .justifyContent(.center)
            .define { rootFlex in
                rootFlex.addItem(detailImageView)
                    .width(100%)
                    .height(150)
        }
    }
    
    private func applyViewModel() {
        viewModel.productDetailImage
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] image in
                self?.detailImageView.image = image
                self?.detailImageView.flex.markDirty()
                self?.setNeedsLayout()
            }.disposed(by: disposeBag)
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
