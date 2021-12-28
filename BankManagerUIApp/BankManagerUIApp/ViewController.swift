//
//  BankManagerUIApp - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    let addClientsButton = UIButton()
    let initAppButton = UIButton()
    let timeNoticeLabel = UILabel()
    let waitingQueueNoticeLabel = UILabel()
    let runningQueueNoticeLabel = UILabel()
    let waitingQueueStackView = UIStackView()
    let runningQueueStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        initAllUIComponents()
        addDummyLabels()
    }
}

extension ViewController {
    func initAllUIComponents() {
        initButtons()
        initTimeNoticeLabels()
        initQueueNoticeLabels()
        initQueueStackViews()
    }
    
    private func initButtons() {
        addClientsButton.setTitle("고객 10명 추가", for: .normal)
        addClientsButton.setTitleColor(.systemBlue, for: .normal)
        view.addSubview(addClientsButton)
        addClientsButton.translatesAutoresizingMaskIntoConstraints = false
        addClientsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        addClientsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        addClientsButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        
        initAppButton.setTitle("초기화", for: .normal)
        initAppButton.setTitleColor(.systemRed, for: .normal)
        view.addSubview(initAppButton)
        initAppButton.translatesAutoresizingMaskIntoConstraints = false
        initAppButton.topAnchor.constraint(equalTo: addClientsButton.topAnchor).isActive = true
        initAppButton.leadingAnchor.constraint(equalTo: addClientsButton.trailingAnchor).isActive = true
        initAppButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        initAppButton.bottomAnchor.constraint(equalTo: addClientsButton.bottomAnchor).isActive = true
    }
    
    private func initTimeNoticeLabels() {
        timeNoticeLabel.text = "업무시간 - 00:00:00"
        timeNoticeLabel.textColor = .black
        timeNoticeLabel.textAlignment = .center
        view.addSubview(timeNoticeLabel)
        timeNoticeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeNoticeLabel.topAnchor.constraint(equalTo: initAppButton.bottomAnchor).isActive = true
        timeNoticeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        timeNoticeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func initQueueNoticeLabels() {
        waitingQueueNoticeLabel.text = "대기중"
        waitingQueueNoticeLabel.textColor = .white
        waitingQueueNoticeLabel.backgroundColor = .systemGreen
        waitingQueueNoticeLabel.textAlignment = .center
        view.addSubview(waitingQueueNoticeLabel)
        waitingQueueNoticeLabel.translatesAutoresizingMaskIntoConstraints = false
        waitingQueueNoticeLabel.topAnchor.constraint(equalTo: timeNoticeLabel.bottomAnchor).isActive = true
        waitingQueueNoticeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        waitingQueueNoticeLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        
        runningQueueNoticeLabel.text = "작업중"
        runningQueueNoticeLabel.textColor = .white
        runningQueueNoticeLabel.backgroundColor = .systemPurple
        runningQueueNoticeLabel.textAlignment = .center
        view.addSubview(runningQueueNoticeLabel)
        runningQueueNoticeLabel.translatesAutoresizingMaskIntoConstraints = false
        runningQueueNoticeLabel.topAnchor.constraint(equalTo: waitingQueueNoticeLabel.topAnchor).isActive = true
        runningQueueNoticeLabel.leadingAnchor.constraint(equalTo: waitingQueueNoticeLabel.trailingAnchor).isActive = true
        runningQueueNoticeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        runningQueueNoticeLabel.bottomAnchor.constraint(equalTo: waitingQueueNoticeLabel.bottomAnchor).isActive = true
    }
    
    private func initQueueStackViews() {
        waitingQueueStackView.axis = .vertical
        waitingQueueStackView.alignment = .center
        waitingQueueStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(waitingQueueStackView)
        waitingQueueStackView.topAnchor.constraint(equalTo: runningQueueNoticeLabel.bottomAnchor).isActive = true
        waitingQueueStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        waitingQueueStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true

        
        runningQueueStackView.axis = .vertical
        runningQueueStackView.alignment = .center
        runningQueueStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(runningQueueStackView)
        runningQueueStackView.topAnchor.constraint(equalTo: waitingQueueStackView.topAnchor).isActive = true
        runningQueueStackView.leadingAnchor.constraint(equalTo: waitingQueueStackView.trailingAnchor).isActive = true
        runningQueueStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension ViewController {
    func addDummyLabels() {
        let dummy1 = UILabel()
        let dummy2 = UILabel()
        dummy1.text = "ABCD"
        dummy2.text = "EFGH"
        waitingQueueStackView.addArrangedSubview(dummy1)
        waitingQueueStackView.addArrangedSubview(dummy2)
        
        let dummy3 = UILabel()
        let dummy4 = UILabel()
        dummy3.text = "1234"
        dummy4.text = "5678"
        runningQueueStackView.addArrangedSubview(dummy3)
        runningQueueStackView.addArrangedSubview(dummy4)
    }
}
