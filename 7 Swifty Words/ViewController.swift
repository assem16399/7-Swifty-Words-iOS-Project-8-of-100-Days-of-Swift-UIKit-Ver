//
//  ViewController.swift
//  7 Swifty Words
//
//  Created by Aasem Hany on 24/11/2022.
//

import UIKit

class ViewController: UIViewController {

    var cluesLabel:UILabel!
    var hintsLabel:UILabel!
    var currentAnswerTextField:UITextField!
    var scoreLabel:UILabel!
    var letterButtons = [UIButton]()
    var activatedLetterButtons = [UIButton]()
    
    var solutions = [String]()
    var answeredQuestions = 0
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var level = 1
    override func loadView() {
        // Start Builing Your UI In Code

        configMainView()
            
        configScoreLabel()
        
        configCluesLabel()
        
        configAnswersLabel()
        
        configCurrentAnswerTextField()

        let submitButton = UIButton(type: .system)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle("Submit", for: .normal)
        submitButton.addTarget(self, action: #selector(onSubmitTapped), for: .touchUpInside)
        submitButton.configuration = .filled()
        view.addSubview(submitButton)

        //configuring clearButton
        let clearButton = UIButton(type: .system)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.setTitle("Clear", for: .normal)
        clearButton.addTarget(self, action: #selector(onClearTapped), for: .touchUpInside)
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
            
            hintsLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100.0),
            hintsLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            hintsLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4,constant: -100),
            hintsLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
            
            currentAnswerTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswerTextField.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20.0),
            currentAnswerTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            submitButton.topAnchor.constraint(equalTo: currentAnswerTextField.bottomAnchor,constant: 10),
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
        performSelector(inBackground: #selector(loadLevel), with: nil)
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
        hintsLabel = UILabel()
        hintsLabel.translatesAutoresizingMaskIntoConstraints = false
        hintsLabel.font = .systemFont(ofSize: 24.0)
        hintsLabel.textAlignment = .right
        hintsLabel.numberOfLines = 0
        hintsLabel.text = "ANSWERS"
        hintsLabel.setContentHuggingPriority(UILayoutPriority(1.0), for: .vertical)
        view.addSubview(hintsLabel)
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
                button.addTarget(self, action: #selector(onLetterTapped), for: .touchUpInside)
                buttonsView.addSubview(button)
                letterButtons.append(button)
            }
        }
    }
    
    @objc func loadLevel() {
        var clues = ""
        var formattedHints = ""
        var letterBits = [String]()
        
        guard let levelFileUrl = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") else{return}
        
        guard let levelContents = try? String(contentsOf: levelFileUrl) else{return}
        
        let levelLines = levelContents.components(separatedBy: "\n").shuffled()
        
        for (index,line) in levelLines.enumerated() {
            let lineParts = line.components(separatedBy: ": ")
            let unformattedSolution = lineParts[0]
            let clue = lineParts[1]
            clues += "\(index + 1).\(clue)\n"
            let formattedSolution = unformattedSolution.replacingOccurrences(of: "|", with: "")
            formattedHints += "\(formattedSolution.count) letters\n"
            solutions.append(formattedSolution)
            let bits = unformattedSolution.components(separatedBy: "|")
            letterBits += bits
        }
        letterBits.shuffle()

        updateUI(clues: clues, hints: formattedHints, letterBits: letterBits)

    }
    
     func updateUI(clues:String, hints:String,letterBits:[String]) {
         DispatchQueue.main.async {
             [weak self] in
             self?.cluesLabel.text = clues.trimmingCharacters(in: .whitespacesAndNewlines)
             self?.hintsLabel.text = hints.trimmingCharacters(in: .whitespacesAndNewlines)
             
             
             if self?.letterButtons.count == letterBits.count {
                 guard let letterButtonsRange = self?.letterButtons.indices else{return}
                 for index in letterButtonsRange {
                     self?.letterButtons[index].setTitle(letterBits[index], for: .normal)
                 }
             }
         }
        
    }
    
    @objc func onSubmitTapped(_ sender: UIButton){
        guard let textFieldText = currentAnswerTextField.text else{return}
        guard let indexOfAnswer = solutions.firstIndex(of: textFieldText) else {
            score -= 1
            let ac = UIAlertController(title: "OOPS!!!", message: "Try another guess",preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Okay", style: .default))
            present(ac, animated: true)
            return
            
        }
        currentAnswerTextField.text?.removeAll()
        activatedLetterButtons.removeAll()
        score += 1
        answeredQuestions += 1
        var hintsList = hintsLabel.text?.components(separatedBy: "\n")
        hintsList?[indexOfAnswer] = textFieldText
        hintsLabel.text = hintsList?.joined(separator: "\n")
        
        if answeredQuestions % 7 == 0 && level < 2 {
            let ac = UIAlertController(title: "Well Done!", message: "Are you ready for the next level?", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Let's Gooo", style: .default, handler: {[unowned self]_ in
                self.level = 2
                solutions.removeAll()
                for button in self.letterButtons {
                    button.isEnabled = true
                }
                self.performSelector(inBackground: #selector(loadLevel), with: nil)
            }))
            present(ac, animated: true)
        }
    }
    
    @objc func onClearTapped(_ sender: UIButton){
        currentAnswerTextField.text?.removeAll()
        for button in activatedLetterButtons {
            button.isEnabled = true
        }
        activatedLetterButtons.removeAll()
    }
    
    @objc func onLetterTapped(_ sender: UIButton){
        guard let letterText = sender.titleLabel?.text else {return}
        activatedLetterButtons.append(sender)
        currentAnswerTextField.text = currentAnswerTextField.text?.appending(letterText)
        sender.isEnabled = false
    }
}
