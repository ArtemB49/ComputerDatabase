/**
 * Кастомное View в основе UITextView
 */

import UIKit
import SnapKit

@IBDesignable
final class TextViewComposite: BaseCustomView {
    
    // MARK: - Private properties
    private let containerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10.0
        return view
    }()
    
    private let dataContainerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10.0
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.0, weight: .medium)
        label.textColor = UIColor.gray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionTextView: UITextView = {
        let view = UITextView()
        view.textColor = UIColor.black.withAlphaComponent(0.87)
        view.autocapitalizationType = .none
        view.autocorrectionType = .yes
        view.spellCheckingType = .no
        view.isScrollEnabled = false
        return view
    }()
    
    private let buttonMore: UIButton = {
        let view = UIButton()
        view.setTitle("more", for: .normal)
        view.setTitleColor(UIColor.blue, for: .normal)
        view.setTitleColor(UIColor.gray, for: .highlighted)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 10.0)
        view.contentHorizontalAlignment = .left
        view.addTarget(nil, action: #selector(moreDidTap(_:)), for: .touchUpInside)
        return view
    }()
    
    private lazy var springView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    // MARK: - @IBInspectable
    @IBInspectable
    var name: String {
        get {
            return nameLabel.text ?? ""
        }
        set {
            nameLabel.text = newValue
        }
    }
    
    @IBInspectable
    var text: String {
        get {
            return descriptionTextView.text ?? ""
        }
        set {
            descriptionTextView.text = newValue
        }
    }
    
    // MARK: - Action
    @objc func moreDidTap(_ sender: UIButton) {
        
        let dataContainerHeightWithoutDesc = dataContainerView.bounds.size.height - descriptionTextView.bounds.size.height
        
        
        descriptionTextView.snp.makeConstraints { maker in
            maker.width.equalToSuperview()
            maker.height.equalTo(descFullHeigth).priority(1000)
        }
        
        dataContainerView.snp.makeConstraints { maker in
            maker.height.equalTo(descFullHeigth + dataContainerHeightWithoutDesc)
        }
    }
    
    // MARK: - Size setting
    private lazy var descFullHeigth: CGFloat = {
        
        return descriptionTextView
            .sizeThatFits(
                CGSize(
                    width: descriptionTextView.bounds.size.width,
                    height: CGFloat.greatestFiniteMagnitude
                )
            )
            .height
    }()
    
    // MARK: - Configuration
    override func configure() {
        dataContainerView.addArrangedSubview(descriptionTextView)
        dataContainerView.addArrangedSubview(buttonMore)
        dataContainerView.addArrangedSubview(nameLabel)
        
        containerView.addArrangedSubview(dataContainerView)
        containerView.addArrangedSubview(springView)
        
        addSubview(containerView)
    }
    
    override func setupConstraints() {
        
        descriptionTextView.snp.makeConstraints { maker in
            maker.width.equalToSuperview()
            maker.height.equalTo(50).priority(1000)
        }
        nameLabel.snp.makeConstraints { maker in
            maker.height.equalTo(20)
        }
        
        buttonMore.snp.makeConstraints { maker in
            maker.height.equalTo(20)
        }
        
        containerView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(16)
            maker.top.equalToSuperview().offset(10)
            maker.trailing.equalToSuperview().offset(-16)
            maker.bottom.equalToSuperview()
        }
    }
}
