# Data Structure

- 자료를 효율적으로 이용할 있도록 저장하는 방법
- 1차원 형태의 단순한 메모리 공간의 데이터를 현실 세계의 복잡한 다차원 데이터로 변환하는 효율적인 방법에 대한 것
- **검색, 삽입, 변경, 삭제** 등 주요 작업에 대해 **적은 메모리 용량과 빠른 연산 속도**를 갖도록 하는 효과적인 알고리즘을 구현하는 데 중요한 역할을 한다.

## Principles

- 자료 구조의 특징

  - 정확성(Correctness) : 필요한 자료에 대해 필요한 연산을 정확히 적용할 수 있어야 함
  - 효율성(Efficiency) : 상황에 맞는 자료구조를 사용하여 자료 처리의 효율성을 높일 수 있다
  - 추상화(Abstraction) : 복잡한 자료의 핵심 개념 또는 기능을 추상화하여 간단하고 쉽게 사용할 수 있도록 설계해야 함
  - 재사용성(Reusability) : 추상화된 개념을 모듈화(ADT(Abstract Data Type))하여 독립적이고 쉽게 재사용할 수 있도록 만들어야 함

- 선택 기준

  - 자료의 크기와 처리 시간
  - 자료의 활용 및 갱신 빈도
  - 활용 용이성

  | Data Structure | Advantages                                                   | Disadvantages                                                |
  | -------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
  | Array          | Quick Insert<br />Fast access if index known                 | Slow search<br />Slow deletes<br />Fixed size                |
  | Ordered Array  | Faster search than unsorted Array                            | Slow insert<br />Slow deletes<br />Fixed size                |
  | Stack          | LIFO access                                                  | Slow access to other items                                   |
  | Queue          | FIFO access                                                  | Slow access to other items                                   |
  | Linked List    | Quick inserts<br />Quick deletes                             | Slow search                                                  |
  | Binary Tree    | Quick search<br />Quick inserts<br />Quick deletes<br />(If the tree remains balanced) | Deletion algorithm is complex                                |
  | Red-Black Tree | Quick search<br />Quick inserts<br />Quick deletes<br />(Tree always remains balanced) | Complex to implement                                         |
  | 2-3-4 Tree     | Quick search<br />Quickk inserts<br />Quick deletes<br />(Tree always remains balanced)<br />(Similar trees good for disk storage) | Complex to implement                                         |
  | Hash Table     | Very fast access if key is known<br />Quick inserts          | Slow deletes<br />Access slow if key is not known<br />Ineffficient memory usage |
  | Heap           | Quick inserts<br />Quick deletes<br />Access to largest item | Slow access to other items                                   |
  | Graph          | Best models real-world situations                            | Some algorithms are slow and very complex                    |

## 시간 복잡도

- 시간 복잡성 : 데이터 연산 시간에 대한 복잡도. 연산 시간이 작을 수록 좋다
- 공간 복잡성 : 데이터 연산 및 저자엥 필요한 메모리 공간에 대한 복잡도. 필요한 공간이 작을 수록 좋다
- 경우에 따라 다르지만, 일반적으로 **시간 복잡도**를 더 중요하게 생각한다.

### Worst Case

- Big-O 표기법. 일반적으로 많이 사용됨.
- 최악의 경우를 가정하여 가장 오래 걸리는 시간을 나타냄.
- 데이터의 크기 `N`에 대해 `O(N)`, `O(logN)`, `O(NlogN)` 등

### Average Case

- Theta 표기법
- 평균적인 경우를 가정한 표현식

### Best Case

- Big-Omega 표기법
- 최선의 경우를 가정한 표현식