//
//  AddWordVC.swift
//  StudWords
//
//  Created by Vitaliy Griza on 04.10.2022.
//

import UIKit

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
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShowDimmedView()
        animatePresentContainer()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Do any additional setup after loading the view.
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
            button.backgroundColor = .purple
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
            bg.backgroundColor = .white
            bg.snp.makeConstraints { make in
                make.top.equalTo(containerView.snp.top).offset(10)
                make.left.right.equalToSuperview()
                make.height.equalTo(0)
                //                make.bottom.equalToSuperview()
            }
            
        })
        
        presentTitleLabel = UILabel().then({ label in
            
        })
        
        addButton = UIButton().then({ button in
            bgView.addSubview(button)
            button.setTitle("Add", for: .normal)
            button.backgroundColor = .purple
            
            button.snp.makeConstraints { make in
                make.width.equalTo(50)
                make.height.equalTo(25)
                make.centerY.equalToSuperview()
            }
        })
        
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
    @objc func buttonTapped(sender: UIButton) {
        print("tapped")
        animateDismissView()
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
