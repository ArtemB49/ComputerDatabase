/**
 * Универсальный класс для создание кастомных view
 */

import UIKit
import SnapKit

class BaseCustomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configure()
        setupConstraints()
    }
    
    func configure() {
        assertionFailure("should override in children")
    }
    
    func setupConstraints() {
        assertionFailure("should override in children")
    }
    
}
