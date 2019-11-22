//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = CGSize(width: 375, height: 700)
        self.view = view
    }
    
    override func viewDidLoad() {
        let greenView = setupSuperView()
        let redView = setupSubView(superView: greenView)

        greenView.bounds.origin = CGPoint(x: 100, y: 100)
    }
    
    func setupSuperView() -> UIView {
        let greenView = UIView(frame: CGRect(x: 50, y: 50, width: 200, height: 200))
        greenView.backgroundColor = .green
        view.addSubview(greenView)
        return greenView
    }
    
    func setupSubView(superView: UIView) -> UIView {
        let redView = UIView(frame: CGRect(x: 100, y: 100, width: 80, height: 80))
        redView.backgroundColor = .red
        superView.addSubview(redView)
        return redView
    }
}

class PracticeTwoController : UIViewController {
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = CGSize(width: 375, height: 700)
        self.view = view
    }
    
    
    
    override func viewDidLoad() {
        // 1. View를 하나씩 만들어서 추가하는 방식
//        addSubviews()
        
        // 2. 색으로 view를 구분해서 loop를 이용해 추가하는 방식
        addSubviewsUsingLoop()
    }
    
    func addSubviews() {
        let blueView = setupSubView(size: decreasedRectFrame(from: view.frame), color: .blue)
        view.addSubview(blueView)
        let redView = setupSubView(size: decreasedRectFrame(from: blueView.frame), color: .red)
        blueView.addSubview(redView)
        let greenView = setupSubView(size: decreasedRectFrame(from: redView.frame), color: .green)
        redView.addSubview(greenView)
    }
    
    func addSubviewsUsingLoop() {
        var colors: [UIColor] = [.blue, .red, .green]
        
        var superView: UIView = view
        for color in colors {
            let subView = setupSubView(size: decreasedRectFrame(from: superView.bounds), color: color)
            superView.addSubview(subView)
            superView = subView
        }
    }
    
    func setupSubView(size: CGRect, color: UIColor) -> UIView {
        let subview = UIView()
        subview.frame = size
        subview.backgroundColor = color
        return subview
    }
    
    func decreasedRectFrame(from frame: CGRect) -> CGRect {
        return CGRect(x: frame.minX + 30, y: frame.minY + 30, width: frame.width - 60, height: frame.height - 60)
    }
}

class ThirdPracticeController : UIViewController {
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = CGSize(width: 375, height: 700)
        self.view = view
    }
    
    override func viewDidLoad() {
        
        let upper = setupUpperView()
        let lower = setupLowerView()
        
    }
    
    func setupUpperView() -> UIView {
        let subview = UIView()
        subview.frame = CGRect(x: 30, y: 30, width: view.frame.width - 60, height: 150)
        subview.backgroundColor = .blue
        view.addSubview(subview)
        return subview
    }
    
    func setupLowerView() -> UIView {
        let subview = UIView()
        subview.frame = CGRect(x: 30, y: view.frame.height - 30 - 150 , width: view.frame.width - 60, height: 150)
        subview.backgroundColor = .blue
        view.addSubview(subview)
        return subview
    }
}

// Present the view controller in the Live View window
let vc = MyViewController()
let vc2 = PracticeTwoController()
let vc3 = ThirdPracticeController()
vc.preferredContentSize = CGSize(width: 375, height: 700)
vc2.preferredContentSize = CGSize(width: 375, height: 700)
vc3.preferredContentSize = CGSize(width: 375, height: 700)
PlaygroundPage.current.liveView = vc2
