//
//  GameControlViewClass.swift
//  yandexGame
//
//  Created by Кирилл Бережной on 24.01.2023.
//

import UIKit

@IBDesignable
class GameControlViewClass: UIView {
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    @IBInspectable var gameTimeLeft: Double = 7 {
        didSet {
            updateUI()
        }
    }
    @IBInspectable var isGameActive: Bool = false {
        didSet {
            updateUI()
        }
    }
    @IBInspectable var gameDuration: Double {
        get {
            return stepper.value
        }
        set {
            stepper.value = newValue
            updateUI()
        }
    }
    
    var startStopHandler: (() -> Void)?
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        updateUI()
    }
    
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        startStopHandler?()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func loadFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "GameControlView", bundle: bundle)
        //bundle.loadNibNamed(String(describing: self), owner: self, options: nil)
        
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    private func setupViews() {
        let xibView = loadFromXib()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
    }
    
    
    private func updateUI() {
        stepper.isEnabled = !isGameActive
        
        if isGameActive {
            timeLabel.text = "Осталось: \(Int(gameTimeLeft))"
            actionButton.setTitle("Остановить", for: .normal)
        } else {
            stepper.isEnabled = true
            timeLabel.text = "Время: \(Int(stepper.value)) секунд"
            actionButton.setTitle("Начать", for: .normal)
        }
    }
    
}
