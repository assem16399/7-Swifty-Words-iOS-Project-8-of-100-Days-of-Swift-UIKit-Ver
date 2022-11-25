//
//  ViewController.swift
//  7 Swifty Words
//
//  Created by Aasem Hany on 24/11/2022.
//

import UIKit

class ViewController: UIViewController {

    var cluesLabel:UILabel!
    var answersLabel:UILabel!
    var currentAnswerTextField:UITextField!
    var scoreLabel:UILabel!
    var letterButtons = [UIButton]()
    
    override func loadView() {
        configMainView()
        
        // Start Builing Your UI In Code
        
        // Configuring scoreLable
        configScoreLabel()
        
        // Configuring cluesLabel
        configCluesLabel()
        
        // Configuring answersLabel
        configAnswersLabel()
        
        // Configuring currentAnswer
        configCurrentAnswerTextField()

        //configuring submitButton
        let submitButton = UIButton(type: .system)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle("Submit", for: .normal)
        view.addSubview(submitButton)

        //configuring clearButton
        let clearButton = UIButton(type: .system)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.setTitle("Clear", for: .normal)
        view.addSubview(clearButton)

        //Configure LetterButtons
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        configLettersButtons(buttonsView: buttonsView)
        
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100.0),
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6,constant: -100),
            
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100.0),
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4,constant: -100),
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
            
            currentAnswerTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswerTextField.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20.0),
            currentAnswerTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            submitButton.topAnchor.constraint(equalTo: currentAnswerTextField.bottomAnchor),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: -100),
            submitButton.heightAnchor.constraint(equalToConstant: 44.0),
            
            clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clearButton.centerYAnchor.constraint(equalTo: submitButton.centerYAnchor),
            clearButton.heightAnchor.constraint(equalToConstant: 44.0),
            
            buttonsView.widthAnchor.constraint(equalToConstant: 750.0),
            buttonsView.heightAnchor.constraint(equalToConstant: 320.0),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: submitButton.bottomAnchor,  constant: 20.0),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20.0)
        ])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func configScoreLabel() {
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
    }
    
    func configCluesLabel() {
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = .systemFont(ofSize: 24.0)
        cluesLabel.numberOfLines = 0
        cluesLabel.text = "CLUES"
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1.0), for: .vertical)
        view.addSubview(cluesLabel)
    }

    func configAnswersLabel() {
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = .systemFont(ofSize: 24.0)
        answersLabel.textAlignment = .right
        answersLabel.numberOfLines = 0
        answersLabel.text = "ANSWERS"
        answersLabel.setContentHuggingPriority(UILayoutPriority(1.0), for: .vertical)
        view.addSubview(answersLabel)
    }
    
    func configCurrentAnswerTextField() {
        currentAnswerTextField = UITextField()
        currentAnswerTextField.translatesAutoresizingMaskIntoConstraints = false
        currentAnswerTextField.isUserInteractionEnabled = false
        currentAnswerTextField.placeholder = "Tap letters to guees"
        currentAnswerTextField.textAlignment = .center
        currentAnswerTextField.font = .systemFont(ofSize: 44.0)
        view.addSubview(currentAnswerTextField)
    }
    
    func configMainView() {
        view = UIView()
        view.backgroundColor = .white
    }
    
    func configLettersButtons(buttonsView:UIView) {
        let width = 150
        let height = 80
        
        for row in 0..<4 {
            for colu in 0..<5 {
                let button = UIButton(type: .system)
                button.frame = CGRect(x: width*colu, y: height*row, width: width, height: height)
                button.setTitle("WWW", for: .normal)
                button.titleLabel?.font = .systemFont(ofSize: 36.0)
                buttonsView.addSubview(button)
                letterButtons.append(button)
            }
        }
    }
}

