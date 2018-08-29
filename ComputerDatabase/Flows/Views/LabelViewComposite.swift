/**
 * Кастомное View с двумя UILabel
 */

import UIKit

@IBDesignable
final class LabelViewComposite: BaseCustomView {
    
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
    
    private let textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.font = UIFont.systemFont(ofSize: 22.0, weight: .medium)
        textLabel.textAlignment = .left
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.0, weight: .medium)
        label.textColor = UIColor.gray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var springView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
   
    // MARK: - @IBInspectable
    @IBInspectable
    var text: String {
        get {
            return textLabel.text ?? ""
        }
        set {
            textLabel.text = newValue
        }
    }
    
    @IBInspectable
    var name: String {
        get {
            return nameLabel.text ?? ""
        }
        set {
            nameLabel.text = newValue
        }
    }
    
    // MARK: - Configuration
    override func configure() {
        dataContainerView.addArrangedSubview(textLabel)
        dataContainerView.addArrangedSubview(nameLabel)
        
        containerView.addArrangedSubview(dataContainerView)
        containerView.addArrangedSubview(springView)
        
        addSubview(containerView)
    }
    
    override func setupConstraints() {
        
        textLabel.snp.makeConstraints { maker in
            maker.height.equalTo(25)
        }

        nameLabel.snp.makeConstraints { maker in
            maker.height.equalTo(10)
        }
        
        containerView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(16)
            maker.top.equalToSuperview().offset(5)
            maker.trailing.equalToSuperview().offset(-16)
            maker.bottom.equalToSuperview()
        }
    }
}
