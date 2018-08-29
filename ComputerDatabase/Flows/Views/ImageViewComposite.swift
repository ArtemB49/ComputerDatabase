/**
 * Кастомное View в основе UIImageView
 */

import UIKit
import Alamofire

@IBDesignable
final class ImageViewComposite: BaseCustomView {
    
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
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
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
    var imageURL: URL? {
        get {
            return nil
        }
        set {
            Alamofire.request(newValue!).responseData { response in
                if let data = response.data{
                    self.imageView.image = UIImage(data: data, scale: 1)
                }
            }
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
        dataContainerView.addArrangedSubview(imageView)
        dataContainerView.addArrangedSubview(nameLabel)
        
        containerView.addArrangedSubview(dataContainerView)
        containerView.addArrangedSubview(springView)
        
        addSubview(containerView)
    }
    
    override func setupConstraints() {
        
        imageView.snp.makeConstraints { maker in
            maker.height.equalTo(100)
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
