//
//  AddWordVC.swift
//  StudWords
//
//  Created by Vitaliy Griza on 04.10.2022.
//

import UIKit



protocol AddWordView: AnyObject {
    func updateValidationState(isValid: Bool)
    func showError(message: String)
    func didAddWord()
}



class AddWordVC: UIViewController {
  
    
    
    
    let maxDimmedAlpha: CGFloat = 0.65
    let defaultHeight: CGFloat = 690
    var bgView: UIView!
    var containerView: UIView!
    var dimmedView: UIView!
    var blurView: UIView!
    
    var presentTitleLabel: UILabel!
    
    var addButton: UIButton!
    var closeButton: UIButton!
    
    var wordField: TextFieldWithPadding!
    var descriptionField: TextFieldWithPadding!
    var synonymField:TextFieldWithPadding!
    
    //MARK: Model
    private let viewModel: AddWordViewModel

    init(viewModel: AddWordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShowDimmedView()
        animatePresentContainer()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel.view = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bgView.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        bgView.layer.shadowRadius = 5
        bgView.layer.shadowOffset = .init(width: 0, height: 5)
        bgView.layer.shadowOpacity = 1
        closeButton.layer.cornerRadius = 0.5 * closeButton.bounds.size.width
    }
    
}


extension AddWordVC {
    
    func configureUI() {
        view.backgroundColor = .clear
        
        blurView = UIView().then({ blur in
            view.addSubview(blur)
            blur.backgroundColor = .clear
            blur.addBlurredBackground(style: .systemUltraThinMaterialDark)
            blur.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
            }
        })
        
        dimmedView = UIView().then({ dimmed in
            view.addSubview(dimmed)
            dimmed.backgroundColor = .black
            dimmed.alpha = maxDimmedAlpha
            dimmed.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
            }
        })
        containerView = UIView().then({ container in
            view.addSubview(container)
            container.backgroundColor = .clear
            container.layer.cornerRadius = 16
            container.clipsToBounds = false
            container.snp.makeConstraints { make in
                make.height.equalTo(0)
                make.left.right.equalToSuperview()
                make.bottom.equalToSuperview()
            }
        })
        
        closeButton = UIButton().then({ button in
            containerView.addSubview(button)
            button.backgroundColor = .mainButtonColor
            button.setTitle("X", for: .normal)
            button.titleLabel?.font = UIFont.monospacedSystemFont(ofSize: 18, weight: .thin)
            button.addTarget(self, action:#selector(buttonTapped(sender:)) , for: .touchUpInside)
            button.clipsToBounds = false
            button.snp.makeConstraints { make in
                make.top.equalTo(containerView.snp.top).inset(-5)
                make.right.equalToSuperview().inset(20)
                make.height.equalTo(30)
                make.width.equalTo(30)
            }
        })
        
        bgView = UIView().then({ bg in
            containerView.addSubview(bg)
            bg.layer.cornerRadius = 10
            bg.backgroundColor = .mainBgColor
            bg.snp.makeConstraints { make in
                make.top.equalTo(containerView.snp.top).offset(10)
                make.left.right.equalToSuperview()
                make.height.equalTo(0)
                //                make.bottom.equalToSuperview()
            }
            
        })
        
        presentTitleLabel = UILabel().then({ label in
            bgView.addSubview(label)
            
            label.text = "NEW WORD"
            label.numberOfLines = 0
            label.textColor = .mainTextColor
            label.font = .monospacedDigitSystemFont(ofSize: 32, weight: .thin)
            
            label.snp.makeConstraints { make in
                make.top.equalTo(bgView.snp.top).offset(15)
                make.centerX.equalToSuperview()
            }
        })
        
        wordField = TextFieldWithPadding().then({ field in
            bgView.addSubview(field)
            field.delegate = self
            field.backgroundColor = .clear
            field.placeholder = "Input Word"
            field.layer.cornerRadius = 15
            field.layer.borderWidth = 1
            field.layer.borderColor = UIColor.mainDetailsColor.cgColor
            
            field.addTarget(self, action: #selector(validateFieldAct), for: .allEditingEvents)
            
            field.snp.makeConstraints { make in
                make.top.equalTo(presentTitleLabel.snp.bottom).offset(20)
                make.left.right.equalToSuperview().inset(15)
                make.height.equalTo(60)
            }
        })
        
        descriptionField = TextFieldWithPadding().then({ field in
            bgView.addSubview(field)
            field.delegate = self
            field.backgroundColor = .clear
            field.placeholder = "Input description of word"
            field.layer.cornerRadius = 15
            field.layer.borderWidth = 1
            field.layer.borderColor = UIColor.mainDetailsColor.cgColor
            
            field.addTarget(self, action: #selector(validateFieldAct), for: .allEditingEvents)
            
            field.snp.makeConstraints { make in
                make.top.equalTo(wordField.snp.bottom).offset(20)
                make.height.equalTo(60)
                make.left.right.equalToSuperview().inset(15)
            }
        })
        
        synonymField = TextFieldWithPadding().then({ field in
            bgView.addSubview(field)
            field.delegate = self
            field.backgroundColor = .clear
            field.placeholder = "Input synonim of word"
            field.layer.cornerRadius = 15
            field.layer.borderWidth = 1
            field.layer.borderColor = UIColor.mainDetailsColor.cgColor
            
            field.addTarget(self, action: #selector(validateFieldAct), for: .allEditingEvents)
            
            field.snp.makeConstraints { make in
                make.top.equalTo(descriptionField.snp.bottom).offset(20)
                make.height.equalTo(60)
                make.left.right.equalToSuperview().inset(15)
            }
        })
        
        addButton = UIButton().then({ button in
            bgView.addSubview(button)
            button.setTitle("Add", for: .normal)
            button.backgroundColor = .mainButtonColor
            button.titleLabel?.font = .monospacedDigitSystemFont(ofSize: 18, weight: .light)
            button.layer.cornerRadius = 15
            button.alpha = 0
            
            
            button.addTarget(self, action: #selector(addWordButton) , for: .touchUpInside)
            button.snp.makeConstraints { make in
                make.top.equalTo(synonymField.snp.bottom).offset(20)
                make.width.equalTo(70)
                make.height.equalTo(35)
                make.centerX.equalToSuperview()
//                make.bottom.equalToSuperview().inset(50)
            }
        })
        setAddButtonState(enabled: false)
        
    }
    
    
    func setAddButtonState(enabled: Bool) {
        if enabled {
            addButton.isEnabled = true
            addButton.backgroundColor = .mainButtonColor
        } else {
            addButton.isEnabled = false
            addButton.backgroundColor = .mainDescriptionColor
        }
    }
    
    
    func animateShowDimmedView () {
        blurView.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.blurView.alpha = 1
        }
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.35) {
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }
    func animatePresentContainer(){
        UIView.animate(withDuration: 0.5) {
            self.containerView.snp.remakeConstraints { make in
                make.height.equalTo(self.defaultHeight)
                make.bottom.equalToSuperview()
                make.left.right.equalToSuperview()
            }
            self.bgView.snp.remakeConstraints { make in
                make.height.equalTo(620)
                make.bottom.equalToSuperview()
                make.left.right.equalToSuperview()
            }
            self.addButton.alpha = 1
            self.view.layoutIfNeeded()
        }
        
    }
    
    func animateDismissView() {
        
        UIView.animate(withDuration: 0.5) {
            self.containerView.snp.remakeConstraints { make in
                make.bottom.equalTo(self.defaultHeight)
                make.right.left.equalToSuperview()
            }
            self.view.layoutIfNeeded()
        }
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.6) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: true)
        }
        blurView.alpha = 1
        UIView.animate(withDuration: 0.7) {
            self.blurView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: true)
        }
        
    }

}

//MARK: Actions
extension AddWordVC {
    @objc func buttonTapped(sender: UIButton) {
        print("tapped")
        animateDismissView()
    }
    @objc func addWordButton(){
        UIView.animate(withDuration: 0.15) {
            self.addButton.transform = .init(scaleX: 0.95, y: 0.95)
        } completion: { com in
            UIView.animate(withDuration: 0.1) {
                self.addButton.transform = .identity
            }
        }
        viewModel.addWord(
            text: wordField.text!,
            description: descriptionField.text!,
            synonim: synonymField.text!
        )
    }
    @objc func validateFieldAct() {
        viewModel.validateWord(
            text: wordField.text,
            description: descriptionField.text,
            synonim: synonymField.text
        )
    }
}


extension AddWordVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case wordField:
            descriptionField.becomeFirstResponder()
        case descriptionField:
            synonymField.becomeFirstResponder()
        case synonymField:
            synonymField.resignFirstResponder()
        default:
            break
        }
    }
}

extension UIView {
    
    func addBlurredBackground(style: UIBlurEffect.Style) {
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.frame
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurView)
        self.sendSubviewToBack(blurView)
    }
}

extension AddWordVC: AddWordView {
    func updateValidationState(isValid: Bool) {
        setAddButtonState(enabled: isValid)
    }

    func showError(message: String) {
        showAlert(message: message)
    }

    func didAddWord() {
        dismiss(animated: true)
    }
}
