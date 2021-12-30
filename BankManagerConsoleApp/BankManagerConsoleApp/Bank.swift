import Foundation

class Bank {
    enum Service: String, CaseIterable, CustomStringConvertible {
        case deposit
        case loan
        
        var processingTime: Double {
            switch self {
            case .deposit:
                return 0.7
            case .loan:
                return 1.1
            }
        }
        
        var description: String {
            switch self {
            case .deposit:
                return "예금"
            case .loan:
                return "대출"
            }
        }
    }
    
    private let clients = Queue<Client>()
    private var numberOfClients: Int = 0
    private let depositSemaphore: DispatchSemaphore
    private let loanSemaphore: DispatchSemaphore
    
    let depositDispatchQueue = DispatchQueue(label: Service.deposit.rawValue)
    let loanDispatchQueue = DispatchQueue(label: Service.loan.rawValue)
    let group = DispatchGroup()
    
    init(numberOfClients: Int, numberOfDepositBankTellers: Int, numberOfLoanBankTellers: Int) {
        self.depositSemaphore = DispatchSemaphore(value: numberOfDepositBankTellers)
        self.loanSemaphore = DispatchSemaphore(value: numberOfLoanBankTellers)
        addClientsToQueue(by: numberOfClients)
    }
    
    func startBankingService() {
        let startTime = Date()

        processAllServices()
        group.notify(queue: DispatchQueue.global()) {
            let elapsedTime = String(format: "%.2f", Date().timeIntervalSince(startTime))
            print("업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 \(self.numberOfClients)명이며, 총 업무시간은 \(elapsedTime)초입니다.")
        }
        addClientsToQueue(by: 10)
        processAllServices()
        
        
    }
    
    private func processAllServices() {
        while let client = clients.dequeue() {
            switch client.business {
            case .deposit:
                depositDispatchQueue.async(group: group) {
                    self.depositSemaphore.wait()
                    self.processDepositService(to: client, group: self.group)
                }
            case .loan:
                loanDispatchQueue.async(group: group) {
                    self.loanSemaphore.wait()
                    self.processLoanService(to: client, group: self.group)
                }
            }
        }
    }
    
    private func addClientsToQueue(by numberOfClients: Int) {
        (1...numberOfClients).forEach {
            let client = Client(waitingNumber: self.numberOfClients + $0)
            clients.enqueue(client)
//            delegate.addLabel()
//            group
        }
        self.numberOfClients += numberOfClients
    }

    private func processDepositService(to client: Client, group: DispatchGroup) {
        DispatchQueue.global().async(group: group) {
            print("\(client.waitingNumber)번 고객 예금업무 시작")
            Thread.sleep(forTimeInterval: Service.deposit.processingTime)
            print("\(client.waitingNumber)번 고객 예금업무 완료")
            self.depositSemaphore.signal()
        }
    }
    
    private func processLoanService(to client: Client, group: DispatchGroup) {
        DispatchQueue.global().async(group: group) {
            print("\(client.waitingNumber)번 고객 대출업무 시작")
            Thread.sleep(forTimeInterval: Service.loan.processingTime)
            print("\(client.waitingNumber)번 고객 대출업무 완료")
            self.loanSemaphore.signal()
        }
    }
}
