ViewController {
    var timer: Timer? = Timer
    var bank = Bank()
    func tap() {
        타이머 시작()  // 현재 상태에 따라: 시작, 재개, 아무동작 없음
        bank.큐에 10명 추가()
        if bank.working == false {
            bank.startBankingService()
        } else {
            bank.processAllServices()
        }
    }
    
    func startTimer() {
        
    }
    
    func stopTimer() {
        
    }
    
    func addLabel(client: Client) {
        stack.addSubview(dfdfd)
    }
    
    func removeLabel(client: Client) {
    }
    
    func addLabel2(client: Client) {
        stack.addSubview(dfdfd)
    }
    
    func removeLabel2(client: Client) {
    }
    
    func initButton() {
        // - StackView, Bank 새로 만들기
        // - 타이머 초기화 하기
    }
}

Bank {
    
}
