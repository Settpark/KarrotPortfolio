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
    private let title: UILabel = {
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
            .define { rootFlex in
                rootFlex.addItem(title)
        }
    }
    
    private func applyViewModel() {
        self.title.text = viewModel.productTitle
        title.flex.markDirty()
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
