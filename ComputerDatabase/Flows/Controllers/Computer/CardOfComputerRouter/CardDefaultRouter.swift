/**
 * Реализация роутера отображения интерфейса контроллера компьютера
 */

import Foundation
import UIKit

class CardDefaultRouter: CardRouter {
    
    // MARK: - Private properties
    private let containerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 10.0
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    // MARK: - Init
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    // MARK: - Public methods
    // Сборка карточки компьютера
    func makeCard(computer: Computer) {
        
        let baseView = viewController?.view
        
        if let companyName = computer.company?.name {
            addLabelsView(name: "Company", text: companyName)
        }
        
        if let introduced = computer.introduced {
            addLabelsView(name: "Introduced", text: introduced.toString())
        }
        
        if let discounted = computer.discounted {
            addLabelsView(name: "Discounted", text: discounted.toString())
        }
        
        if let description = computer.descriptionComputer {
            addTextView(name: "Description", text: description)
        }
        
        if let imageUrl = computer.imageUrl {
            let url = URL(fileURLWithPath: imageUrl)
            addImageView(name: "Picture", imageURL: url)
        }
        
        scrollView.addSubview(containerView)
        baseView?.addSubview(scrollView)
        setupConstraints()
    }
    
    // Сборка кнопок похожих компьютеров
    func makeSimilarButtons(computers: [ComputerResult]) {
        addSimilarButton(computers: computers)
    }
    
    
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview()
            maker.top.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(5)
            maker.top.equalToSuperview().offset(5)
            maker.trailing.equalToSuperview().offset(5)
            maker.bottom.equalToSuperview().offset(5)
            maker.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Private methods
    
    private func addLabelsView(name: String, text: String) {
        let view = LabelViewComposite()
        view.name = name
        view.text = text
        containerView.addArrangedSubview(view)
    }
    
    private func addTextView(name: String, text: String) {
        let view = TextViewComposite()
        view.name = name
        view.text = text
        containerView.addArrangedSubview(view)
    }
    
    private func addImageView(name: String, imageURL: URL) {
        let view = ImageViewComposite()
        view.name = name
        view.imageURL = imageURL
        containerView.addArrangedSubview(view)
    }
    
    private func addSimilarButton(computers: [ComputerResult]) {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 5.0
        let label = UILabel()
        label.text = "You must be looking for:"
        label.font = UIFont.systemFont(ofSize: 15.0, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(label)
        computers.forEach { (computer) in
            let button = UIButton()
            button.setTitle(computer.name, for: .normal)
            button.restorationIdentifier = String(computer.computerID)
            button.setTitleColor(UIColor.blue, for: .normal)
            button.setTitleColor(UIColor.gray, for: .highlighted)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 10.0)
            button.contentHorizontalAlignment = .left
            button.addTarget(self, action: #selector(similarDidTap(_:)), for: .touchUpInside)
            button.isUserInteractionEnabled = true
            stackView.addArrangedSubview(button)
        }
        
        containerView.addArrangedSubview(stackView)
        
        stackView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(16)
            maker.trailing.equalToSuperview().offset(-16)
            
        }
    }
    
    // MARK: - Actions
    
    @objc func similarDidTap(_ sender: UIButton) {
        if let identifier = sender.restorationIdentifier,
            let computerID = Int(identifier) {
            let computerBuilder = ComputerDefaultBuilder(computerID: computerID)
            let presentingVC = computerBuilder.build()
            viewController?
                .navigationController?
                .pushViewController(presentingVC, animated: true)
        }
        
    }
    
}


