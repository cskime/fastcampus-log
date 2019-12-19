//
//  CustomCell.swift
//  BasicTableView
//
//  Created by Giftbot on 2019/12/05.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
  
  let myLabel = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    // 커스텀 뷰를 올릴 때는 contentView 위에 추가
    contentView.addSubview(myLabel)
    myLabel.textColor = .yellow
    myLabel.backgroundColor = .black
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // View에서 subview들에 대한 레이아웃 조정
  override func layoutSubviews() {
    super.layoutSubviews()
    
    // init에서는 customcell 자체에 대한 정확한 frame이 잡혀있지 않기 때문에 self.frame을 기준으로 크기를 잡을 수 없음
    // frame을 정할 때 cgrect에 고정값이 들어간다면 init에서 해도 상관없지만, self.frame을 사용하려고 한다면 self의 frame이 설정된 뒤의 타이밍인 layoutSubviews에서 사용해야함.
    // cellForRowAt에서 해도 같은 문제가 발생함. cellForRowAt은 cell의 데이터를 설정하고 스타일과 타입을 설정하는 곳이기 때문에 layout이 정확히 설정된 단계가 아님. cell.frame.height을 찍어보면 rowHeight을 80으로 설정했어도 실제 값은 기본값인 44.0ㅇ, 나옴. 즉, 아직 layout은 설정되지 않은 시기라는 뜻
    // ViewController 단계에서 frame을 설정하고 싶다면 tableViewDelegate의 willDisplay:forRowAt 에서 설정해야함. Cell이 화면에 나타나기 직전이므로 frame이 잡혀있을 것
    // Call Stack : cellForRowAt -> willDisplay -> layoutSubviews
    myLabel.frame = CGRect(x: self.frame.width - 120, y: 15, width: 100, height: frame.height - 30)
    
    // 하지만 오토레이아웃은 init에서 해도 문제가 없음. 실제로 오토레이아웃이 조정되는 경우는 updatecontsraints같이 더 뒤에 잡히기 때문에 init에서 잡아도 당장 잡히지 않고 constriant가 잡히는 시점에 잡힘
  }
    
    
    // Autolayout을 적용하는 경우
    override func updateConstraints() {
        super.updateConstraints()
    }
}
