ViewController {
    var bank = Bank()
    func tap() {
        타이머 시작()  // 현재 상태에 따라: 시작, 재개, 아무동작 없음
        bank.큐에 10명 추가()
        self.stackView.큐에 10명 추가()
        if bank.working == false {
            bank.startBankingService()
        }
    }
}

Bank {
    
}
