# Practice - Calculator

- 다음 연산이 가능하도록 계산기 구현하기

  ```
  연산 : 12 = 3          
  결과 : 3 - 12는 초기화 되고 최초에 3을 누른 것부터 다시 시작
  
  연산 : 12 + 3 = + 4 =  
  결과 : 19 - 12 + 3 + 4 = 19
  
  연산 : 12 + 3          
  결과 : 12 (화면상에는 3) - 아직 3이 더해지지 않은 상태
  
  연산 : 12 + 3 -        
  결과 : 15 - '-'버튼이 눌려지는 순간 앞의 + 연산이 수행됨
  
  연산 : 12 + 3 * + - *  
  결과 : 15 - 연산자만 바꾸는 것은 결과에 영향 없이 다음에 수행할 연산자를 덮어씀
  
  연산 : 12 + - * / 3 =  
  결과 : 4 - 마지막으로 누른 연산자(/)로 연산. 12 / 3 = 4
  
  연산 : 12 + =          
  결과 : 24 -  12 + 12 = 24
  
  연산 : 12 + = = =      
  결과 : 24 - 12 + 12 = 24,  등호(=)는 이전 연산자에 대해 한 번만 계산
  
  연산 : 12 +-*/ +-*/    
  결과 : 12 - 연산자를 막 바꿔가면서 눌렀을 때 이상 없는지 체크
  
  연산 : 1 * 2 + 3 / 2 - 1 = 
  결과 : 1.5 - 연산자 우선순위와 관계없이 항상 앞에 있던 연산자부터 계산
  ```

## 문제 정의

- 계산기가 동작하는 원리를 다음과 같이 파악
  - 기본적으로 `A + B = C`의 형태로 계산됨
  - 연산을 수행하기 위해 연산자와 피연산자가 각각 두 개씩 필요함
- 계산기가 동작하는 기준을 다음과 같이 나눔
  - 연산자(Operator) 입력 : 현재 입력된 피연산자 상태에  따라 몇 번째 연산자에 저장될지 구분
    - 연산자 입력 시, 첫 번째 연산자가 입력되지 않았다면 첫 번째 연산자로 입력
    - 단, 아무런 숫자도 입력하지 않았을 때는 무시되어야함
    - 연산자 입력 시, 두 번째 연산자가 입력되지 않았다면, 첫 번째 연산자로 두 피연산자를 연산한 후 그 결과를 첫 번째 피연산자로 저장, 새로 입력한 연산자는 첫 번째 연산자로 저장
    - 단, 첫 번쨰 연산자 입력 후 다음 숫자를 입력하지 않았다면 모두 첫 번쨰 연산자로 입력되어야함
    - 첫 번째 연산자가 `+`, `-`, `x`, `÷`일 때 뒤이어 오는 연산자가 `=`이라면 첫 번째 피연산자 두개로 첫 번째 연산자의 연산 수행
  - 피연산자(Operand) 입력 : 현재 입력된 연산자 상태에  따라 몇 번째 피연산자에 저장될지 구분
    - 숫자 입력 시, 연산자 입력이 들어오기 전 까지 입력하는 숫자를 순서대로 이어붙여서 하나의 피연산자로 저장. 
    - 첫 번쨰 연산자가 입력되지 않은 상태라면, 입력되는 숫자들을 첫 번쨰 피연산자로 저장
    - 두 번째 연산자가 입력되지 않은 상태라면, 입력되는 숫자들을 두 번째 피연산자로 저장
  - AC(All Clear) : 저장했던 모든 연산자, 피연산자 등을 초기화

## 기능 구현

- 계산기의 연산 종류는 5가지로 제한되기 때문에 `enum`을 활용하여 입력되는 연산자 종류를 제한함.

- 각 연산자별로 피연산자를 연산할 수 있는 `operate(_:_:)` method 구현

  ```swift
  private enum Operator: Int {
      case plus, minus, multiply, divide, calculate, none
      
      func operate(_ operand1: Double, _ operand2: Double) -> Double? {
          switch self {
          case .plus:
              return operand1 + operand2
          case .minus:
              return operand1 - operand2
          case .multiply:
              return operand1 * operand2
          case .divide:
              guard operand2 > 0 else { return nil }
              return operand1 / operand2
          case .calculate, .none:
              return nil
          }
      }
  }
  ```

- 숫자를 누르는 순서대로 뒤로 이어 붙여져야 하기 때문에 피연산자를 저장할 변수를 display용 `String` 변수와 계산용 `Double` 변수로 구분해서 사용함

  ```swift
  private var leftOperand: Double?
  private var displayLeft: String = "" {
      didSet {
          if let number = Double(self.displayLeft) {
              self.leftOperand = number
              self.displayText = decimalFormat(from: number)
          } else {
              self.leftOperand = nil
          }
      }
  }
  
  private var rightOperand: Double?
  private var displayRight: String = "" {
      didSet {
          if let number = Double(self.displayRight) {
              rightOperand = number
              self.displayText = decimalFormat(from: number)
          } else {
              rightOperand = nil
          }
      }
  }
  ```

- 계산기의 숫자, 연산자, AC 버튼을 누를 때 동작을 다음과 같이 구현. 버튼의 각 action method에서는 계산하는 로직을 빼고 해당하는 피연산자 또는 연산자에 입력하는 동작만 구현함

  ```swift
  @IBAction func numberTouched(_ sender: UIButton) {
      switch firstOperator {
      case .none:
          guard displayLeft.count < 13 else { return }
          displayLeft += sender.titleLabel!.text!
      case .calculate:
          firstOperator = .none
          displayLeft = ""
          numberTouched(sender)
      default:
          guard displayRight.count < 13 else { return }
          displayRight += sender.titleLabel!.text!
      }
  }
  
  @IBAction func clearTouched(_ sender: UIButton) {
      displayText = "0"
      displayLeft = ""
      displayRight = ""
      firstOperator = .none
      secondOperator = .none
  }
  
  @IBAction func calcTouched(_ sender: UIButton) {
      guard let currentOperator = Operator(rawValue: sender.tag) else { return }
      if !displayLeft.isEmpty && displayRight.isEmpty {
          firstOperator = currentOperator
      } else {
          secondOperator = currentOperator
      }
  }
  ```

- 실제 계산이 이루어지는 때는 연산자가 입력되는 시점이므로, `calcTouched(_:)` 호출로 인해 `firstOperator` 또는 `secondOperator`에 연산자가 입력되었을 때 해당 변수들의 `didSet`에서 현재 계산기에 입력된 상태에 따라 계산하도록 함

  ```swift
  private var firstOperator: Operator = .none {
      didSet {
          if secondOperator == .none {
              switch oldValue {
              case .plus, .minus, .multiply, .divide:
                  guard let left = leftOperand, 
                    rightOperand == nil,
                    firstOperator == .calculate, 
                    let calculation = oldValue.operate(left, left) else { return }
                  self.displayText = "\(decimalFormat(from: calculation))"
                  self.displayLeft = ""
                  self.displayRight = ""
                  firstOperator = .calculate
              default:
                  return
              }
          }
      }
  }
  private var secondOperator: Operator = .none {
      didSet {
          if let left = leftOperand, let right = rightOperand,
              let calculation = firstOperator.operate(left, right)
          {
              self.displayLeft = "\(decimalFormat(from: calculation))"
              self.displayRight = ""
              firstOperator = secondOperator
              secondOperator = .none
          }
      }
  }
  ```

## Refactoring adapting MVC Pattern

- 프로젝트에 **MVC** 패턴을 적용시켜서 refactoring
- 스토리보드를 사용하지 않고 모든 UI를 코드로 구현
- AutoLayout 적용

### Class Design

#### Model

- `Calculator`
  - `update(operand:)`, `update(operator:)`, `clear()` : 계산기 데이터 update
  - `fetch()` : 계산기로부터 계산 결과를 요청

#### View

- `NumberPadView`
  - `CalculatorButton`
    - `CalculatorButtonDelegate`를 이용해서 `CalculatorViewController`에 action method 구현을 **delegation**(`touched(_:)`)
- `DisplayLabel`
- `CalculatorTitle`

#### Controller

- `CalculatorViewController`

  - `CalculatorButtonDelegate`를 채택하여 버튼을 터치했을 때 들어오는 사용자 입력을 **Model(`Calculator`)**에 알려주고, 변경된 사항을 **View(`DisplayLabel`)**에 update

    ```swift
    // View에서 사용자 입력을 받았을 때 Controller를 통해 Model과 상호 데이터 update
    extension CalculatorViewController: CalculatorButtonDelegate {
    	func touched(_ sender: UIButton) {
        // 계산기에서 누른 버튼 종류에 따라 model update
    		switch sender.titleLabel!.text! {
    		case "AC":
    			calculator.clear()
    		case let item where Int(item) != nil:
    			calculator.update(operand: Double(item)!)
    		case let op:
    			calculator.update(operator: op)
    		}
        
        // Model에서 update된 내용을 View에 반영
    		display.text = calculator.fetch()
    	}
    }
    ```

    