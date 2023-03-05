//
//  ViewController.swift
//  testCustomView
//
//  Created by Natia's Mac on 02.03.23.
//

import UIKit

class ViewController: UIViewController {
    
    let originX = 16
    let monthArr = [ "4", "5", "6", "7", "8", "9","10", "11", "12"]

    let slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 4
        slider.maximumValue = 12
        slider.isContinuous = true
        slider.tintColor = .yellow
        return slider
    }()
    
    let subView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var texttitle: UILabel = {
        let t = UILabel()
        t.textAlignment = .center
        t.textColor = .white
        t.numberOfLines = 0
        t.text = "4 თვე"
        t.font = UIFont.systemFont(ofSize: 12)
        t.translatesAutoresizingMaskIntoConstraints = false
        
        return t
    }()
    
    private var viewIndicatorContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var viewIndicatorItem: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 5 / 2
        view.backgroundColor = .black // selectedItemColor
        return view
    }()
    
    private var stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        sv.axis = .horizontal
        return sv
    }()
    private var selectedItemColor: UIColor { UIColor.darkGray }
    private var unselectedItemColor: UIColor { UIColor.black }
    
    override func loadView() {
        super.loadView()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        setUpui()
        configureIndicatorView()

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

       // viewIndicatorItem.frame = stackView.arrangedSubviews[0].frame
    }
    @objc func sliderValueDidChange(_ sender:UISlider!) {
        let step: Float = 1
         let roundedStepValue = round(sender.value / step) * step
         sender.value = roundedStepValue
        let currentFrame = self.stackView.arrangedSubviews[Int(roundedStepValue) - 4].frame
     
        UIView.animate(withDuration: 0.25) {
            //self.viewIndicatorItem.frame = currentFrame
            //self.subView.frame = currentFrame
            //CGRect(x: currentFrame.origin.x, y: currentFrame.origin.y, width: 30, height: 30)
           // if roundedStepValue != 4 {
               // self.texttitle.isHidden = false
                self.texttitle.widthAnchor.constraint(equalTo: self.stackView.arrangedSubviews[Int(roundedStepValue) - 4].widthAnchor).isActive = true
                self.texttitle.text = self.monthArr[Int(roundedStepValue) - 4] + " თვე"
                self.texttitle.transform = CGAffineTransformMakeTranslation( currentFrame.minX, 0.0)
          //  }
//            else {
//                self.texttitle.isHidden = true
//            }
           // print(self.viewIndicatorItem.frame)
        }
        //print("Slider step value \(Int(roundedStepValue))")
     }
    func setUpui() {
        view.addSubview(slider)
        let sliderconst = [
            slider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            slider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            slider.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ]
    
        slider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)

        NSLayoutConstraint.activate(sliderconst)
        
        view.addSubview(viewIndicatorContainer)
        NSLayoutConstraint.activate([
            viewIndicatorContainer.leadingAnchor.constraint(equalTo: slider.leadingAnchor),
            viewIndicatorContainer.trailingAnchor.constraint(equalTo: slider.trailingAnchor),
            viewIndicatorContainer.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 20),
            viewIndicatorContainer.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        viewIndicatorContainer.addSubview(stackView)
        //viewIndicatorContainer.addSubview(viewIndicatorItem)
        viewIndicatorContainer.addSubview(subView)
        subView.addSubview(texttitle)
       // NSLayoutConstraint.activate([
//texttitle.widthAnchor.constraint(equalToConstant: 30),
           // texttitle.heightAnchor.constraint(equalToConstant: 30)
       // ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: viewIndicatorContainer.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: viewIndicatorContainer.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: viewIndicatorContainer.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: viewIndicatorContainer.bottomAnchor)
        ])

    }
    
    private func configureIndicatorView() {
        
        for i in 0..<monthArr.count {
            let indicatorView = UIView()
//            indicatorView.backgroundColor = i == 0 ? selectedItemColor : unselectedItemColor
           // indicatorView.heightAnchor.constraint(equalToConstant: 30).isActive = true
            stackView.addArrangedSubview(indicatorView)
        }
    }
    
}

