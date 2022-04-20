# 🏦 은행 창구 매니저

1. 프로젝트 기간: 2021.12.20 - 2021.12.31

<br>

## 🗂 목차
- [📱 구현 화면](#-구현-화면)
- [📃 구현 내용](#-구현-내용)
- [🚀 Trouble Shooting](#-Trouble-Shooting)
- [🤔 고민한 점](#-고민한-점)
- [⌨️ 키워드](#-키워드)

## 📱 구현 화면

| 초기 화면 | 진행중인 화면 |
| :---: | :---: |
| ![image](https://user-images.githubusercontent.com/90945013/162282925-e2364725-5ce8-494b-8c9c-aaa5f2a88316.png) | ![image](https://user-images.githubusercontent.com/90945013/162283166-b75291ee-a25d-4aa6-9c27-c0255f6104cd.png) |

<br>

## 📃 구현 내용

### Queue 구현
- Linked-list 타입을 구현하여 Queue 타입을 구현
- Linked-list, Queue 타입을 다양한 데이터를 취급할 수 있도록 Generics을 통해 구현
- Queue 타입이 생각한대로 작동하는지 확인할 수 있도록 Unit Test 수행
- Enqueue, Dequeue, Clear, Peek, isEmpty 등 기능 구현

### 동시성 프로그래밍
- 동기(Synchronous)와 비동기(Asynchronous)의 이해를 통해 요구사항에 맞는 적절한 로직 구현
- 쓰레드에 대한 이해를 바탕으로 적절한 동시성프로그래밍 로직 구현
- 동시성 프로그래밍에 대한 이해를 하고 기반기술인 GCD를 사용하여 구현

### View
- UI를 스토리보드를 사용하지 않고 코드만 사용하여 구현
- 동시성 프로그래밍에서의 UI 업데이트에 대한 주의점 들을 고려하여 구현
- 커스텀뷰를 활용하여 구현
- 스택뷰를 사용하여 구현

### 기타
- 객체지향과 타입의 추상화 및 일반화를 적절히 생각하여 각 타입의 역할을 나누어 구현

<br>

## 🚀 Trouble Shooting

### 1. 타이머

#### 문제점
- 프로젝트의 요구사항으로 타이머의 시간을 밀리초까지 UI에 표현해야 했다. 
- 처음에는 정석대로 0.001초마다 UI를 업데이트하도록 구현했는데 1000번의 업데이트를 1초 안에 해내지 못하여, 현실에서 2초 정도가 지나야 비로소 타이머가 1초를 가리키는 문제

#### 원인
- 로직이 0.001초 마다 0.001을 더하고 UI를 업데이트 하는 방식이다. 그래서 1초에 1000번의 연산과 UI업데이트를 해야한다.
- 성능이 따라주지 못해 싱크가 밀려 시간을 제대로 세지 못하는 문제가 발생했다. 

#### 해결방안
- 다른 리소스의 환경에서 테스트를 진행해보았는데 문제가 없는 경우도 있었지만, 사용자 모두에게 문제가 없어야한다고 생각하였다.
- 0.013초가 많은 환경에서의 테스트를 통과할 수 있었고, 보기에도 어색함이 없었다.
- 그래서 초를 0.013초로 늘리는 방식을 택했다. 
- 더 좋은 방법은 시작 전에 시작시간을 구해두고 시작시간과의 차이를 통해 타이머를 구성하면 더 좋을 것이라고 생각한다.

### 2. 초기화 버튼 동작 방식

#### 문제점
- 초기화 버튼을 터치하게 되면 타이머와 고객번호, DispatchQueue에 있는 작업들을 초기화 해주어야한다.
- DispatchQueue에는 작업을 취소하는 기능이 없어 OperationQueue를 사용해야 하는데, 현재 OprationQueue를 공부하고 사용할 시간이 없다고 판단했다.

#### 해결방안
- 근본적인 해결 대신 우선 사용자가 보기에 초기화가 된 것 처럼 보일 수 있도록 구현하였다.
- 초기화 버튼을 터치하게 되면 타이머를 초기화 하고 Bank 타입과 커스텀 뷰로 만들어 놓은 BankManagerView 도 초기화 하도록 구현하였다. 델리게이트 또한 재할당을 함으로서 다시 연결을 할 수 있도록 하였다.

<br>

## 🤔 고민한 점
### 1. Queue를 class로 만든 이유

Queue가 구조체라면 아래의 코드에서 문제가 발생한다.
Queue의 인스턴스는 다르지만 Node의 참조가 같아서, 다른 큐에 영향을 미치게 된다.
같은 이유로 Bank도 class로 만들게 되었다.

```swift
var queue = Queue<Int>()
queue.enqueue(1)
queue.enqueue(2)

var queue2 = queue
queue2.enqueue(3)
// dequeue 예상
queue.dequeue() // 1
queue.dequeue() // 2
queue.dequeue() // 3

// dequeue 예상
queue2.dequeue() // 1
queue2.dequeue() // 2
queue2.dequeue() // 3
```

### 2. 비동기작업 구현 방법

```swift
private let semaphore: DispatchSemaphore

let group = DispatchGroup()
while let client = clients.dequeue() {
	semaphore.wait()
	DispatchQueue.global().async(group: group) {
		self.respond(to: client)
	  	self.semaphore.signal()
    }
}
group.wait()
```
은행 업무 로직을 Dispatch Queue를 사용하여 코드를 구현하였다.

DispatchGroup을 사용하여 비동기 작업들을 그룹화 해주고 모든 작업이 끝날 때 까지 프로그램이 종료되지 않고 기다리도록 하였다.   
semaphore를 활용하여 은행원 수(쓰레드 수)를 제어할 수 있도록 했고, Bank 타입의 이니셜라이저를 통해 초기화 할 수 있도록 했다.   


### 3. Bank와 BankManager로 역할분리

콘솔앱을 구동하기 위해 필요한 역할들을 핵심적인 역할이라 할 수 있는 **은행 업무 처리**와 사용자 입력을 받고 임의의 고객 수를 생성하는 등 앱 구동과 관련한 역할로 나누었다.

두 역할이 구분된다고 판단되어 타입을 분리하였다.    
은행 업무 처리는 Bank에서 앱구동과 관련한 동작들은 BankManager에서 수행하도록 구현하였다.

### 4. Naming 관련 고민

구체적인 이름을 정하려고 고민했다.   
>admit(numberOfClients: Int)  
→ addClientsToQueue(by numberOfClients: Int)

Bank 타입의 work라고 하면 다소 추상적인듯하여 조금 더 구체적인 고객을 응대한다는 의미로 respond로 수정했다
>work(for: Client)  
→ respond(to client: Client)

### 5. 동시성 처리에 대한 로직

예금업무는 동시에 2명까지, 대출업무는 1명이 업무를 처리해야 한다.   
이를 위해 Concurrent Queue에 DispatchSemaphore를 설정하는 구조로 구현하였다.    
이후 세마포어를 기다리는 작업을 Main Thread에게 시키면 App이 멈추므로 업무별 Serial Queue를 만들어주고 거기서 기다리도록 구현하였다.

![](https://user-images.githubusercontent.com/70484506/147523227-a157d8d0-ffa3-4b3c-a806-c36881c31550.png)

### 6. 어떤 메서드가 내부에서 async를 호출하는지 밖에서 보이지 않는데 티를 내야 할까?

현재 로직은 예금업무 고객와 대출업무 고객을 두개의 시리얼큐를 만들어 각 큐에 넣어주고 시리얼 큐 안에서 글로벌큐를 만들고 세마포어로 쓰레드 수를 제어하고있다.

그런데 코드가 너무 길어져 함수를 분리하는 과정에서 아래 코드 중 `processDepositService `메서드와 `processLoanService`메서드 안에서 async() 메서드를 사용하게 된다. 그래서 한눈에 로직을 파악하는 것이 어렵다고 보였다.

`DispatchWorkItem` 을 사용해보려고 했으나 while문 안에서만 사용할 수 있는 client 상수를 사용할 수 없었다.

이런 상황에서 메서드 안에 async() 메서드를 사용하고 있다는 것을 쉽기 알리기 위해서 생각한 방법은 메서드명으로 알리기, 주석으로 알려주기 아니면 애초에 이런 로직은 함수로 분리하지 않는다? 등 생각을 해보았다.

이런 고민을 해보았는데 우선 메서드명으로 알리는 것이 가장 좋다고 생각했고, 정 안되면 주석을 써야한다고 생각했다.  
그래서 아래 코드처럼 메서드명을 명확히 하고 파라미터를 DispatchGroup으로 받기 때문에 async인지 단번에 알수는 없지만 DispatchQueue를 사용한다는 것을 알릴 수 있다고 생각했다.

```swift
private func processAllServices() {
    while let client = clients.dequeue() {
        switch client.business {
        case .deposit:
            depositDispatchQueue.async(group: group) {
                self.depositSemaphore.wait()
                DispatchQueue.main.sync {
                    self.delegate?.addProcessingClient(client: client)
                    self.delegate?.removeWaitingClient(client: client)
                }
                self.processDepositService(to: client, group: self.group)
            }
        case .loan:
            loanDispatchQueue.async(group: group) {
                self.loanSemaphore.wait()
                DispatchQueue.main.sync {
                    self.delegate?.addProcessingClient(client: client)
                    self.delegate?.removeWaitingClient(client: client)
                }
                self.processLoanService(to: client, group: self.group)
            }
        }
    }
}

private func processDepositService(to client: Client, group: DispatchGroup) {
    DispatchQueue.global().async(group: group) {
        Thread.sleep(forTimeInterval: Service.deposit.processingTime)
        DispatchQueue.main.sync {
            self.delegate?.removeProcessingClient(client: client)
        }
        self.depositSemaphore.signal()
    }
}

private func processLoanService(to client: Client, group: DispatchGroup) {
    DispatchQueue.global().async(group: group) {
        Thread.sleep(forTimeInterval: Service.loan.processingTime)
        DispatchQueue.main.sync {
            self.delegate?.removeProcessingClient(client: client)
        }
        self.loanSemaphore.signal()
    }
}
```

### 7. CustomView를 정의하여 뷰컨으로부터 view에 대한 설정을 분리

스토리보드가 아닌 코드로만 UI를 구성해야 한다는 요구사항이 있었다. 그러다보니 기존 방식대로 view 설정을 뷰컨에서 해주면 뷰컨의 크기가 너무 커져서, view에 대한 설정을 뷰컨으로부터 분리할 방법을 생각해보았다

UIView를 상속받는 BankMangerView를 정의하고 인스턴스 생성 시점에 UI를 설정하게 구현하였다. 그리고 뷰컨에서는 viewDidLoad() 시점에 그 인스턴스를 생성하여 자신의 view 프로퍼티에 넣어주는 방식으로 구현하였다.

### 8. 타이머 동작 방식

타이머 동작 방식은 Timer 와 RunLoop를 사용하여 특정 시간마다 코드를 반복하도록 하였다.
0.013초 마다 경과 시간에 0.013을 더하고 레이블을 업데이트 하도록 구현하였다.
업무가 끝나서 타이머를 중지해야 할 때는 Timer.invalidate()를 사용하여 중지하도록 하였다.

하지만 0.013초 마다 0.013을 더하고 레이블을 업데이트 하도록 하는 연산에 걸리는 시간은 크게 고려하지 않아 약간의 오차가 발생할 수 있을 것 같다.

```swift
timer = Timer(timeInterval: 0.013, repeats: true) { _ in
    self.elapsedServiceTime += 0.013
    self.delegate?.updateServiceTimeLabel(serviceTime: self.elapsedServiceTime)
}
guard let timer = timer else {
    return
}
RunLoop.current.add(timer, forMode: .common)
```

### 9. 현재 작업을 끊지 않고 10명 추가하기

작업중에 startBankingService()를 호출하면 DispatchQueue에 작업을 추가하고 반환하도록 했다.
모든 작업이 끝나면 타이머를 끝내는 코드가 한번만 호출된다.

```swfit
private var isProcessing = false

func startBankingService() {
    guard isProcessing == false else {
        processAllServices()
        return
    }
    isProcessing = true
    proessAllServices()

    group.notify(queue: DispatchQueue.global()) {
        self.isProcessing = false
    }
}
```

### 10. Bank가 변경될 때, 뷰를 업데이트 하는 방법

Bank가 변경될 때, 뷰를 업데이트 하기위해 델리게이트 패턴을 사용했다.

```swift
weak var delegate: BankDelegate?

func addClientsToQueue(by numberOfClients: Int) {
    (1...numberOfClients).forEach {
        let client = Client(waitingNumber: self.numberOfClients + $0)
        clients.enqueue(client)
        delegate?.addWaitingClient(client: client)
    }
    self.numberOfClients += numberOfClients
}
```

<br>

## ⌨️ 키워드

- `Linked-list`, `Stack`, `Queue`
- `Generics`
- `동기(Synchronous)`, `비동기(Asynchronous)`, `동시성(Concurrency)`, `Thread`
- `GCD`, `DispatchQueue`, `SerialQueue`, `Concurrent Queue`
- `추상화(Abstraction)`, `일반화(Generalization)`
- `Custom View`, `Stack View`
