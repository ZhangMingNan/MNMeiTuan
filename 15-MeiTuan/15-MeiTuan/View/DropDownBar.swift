//
//  DropDownBar.swift
//  15-MeiTuan
//
//  Created by 张明楠 on 15/8/17.
//  Copyright (c) 2015年 张明楠. All rights reserved.
//

import UIKit
protocol DropDownBarDelegate {
    func selectedCell(searchParam:[SearchParam])
}
class DropDownBar: UIView, DropDownPanelDelegate {
    var buttons = [DropDownButton(),DropDownButton(),DropDownButton()]
    //保存条件查询的结果数组
    var searchParams = [SearchParam(title: "全部分类"),SearchParam(title: "全程"),SearchParam(title: "智能排序")]
    var dataArray:[DropDownModel]?
    let panelH:CGFloat = 322
    let animateDuration = 0.3
    var mask:UIView?
    var panel:DropDownPanel?
    var delegate:DropDownBarDelegate?
    //当前选中的按钮索引
    var currentIndex = -1 {
        didSet{
            for i in 0..<buttons.count{
                if currentIndex != i {
                    self.buttons[i].selected = false
                }
            }
            //不等于-1说明需要展开显示数据
            if currentIndex != -1 {
                //判断table的类型是一级还是二级,设置表格的宽度和高度
                var model = self.dataArray![self.currentIndex]
                self.panel!.showTableView(model)
                //清空查询条件
                self.searchParams[currentIndex].conditions.removeAll(keepCapacity: false)

            }
        }
    }
    //接收到通知
    func selectedCell(notify:NSNotification){
        if let cat = notify.userInfo!["cat"]as? MerchantCategory {
            self.buttons[self.currentIndex].title = cat.name!
           // self.titles[self.currentIndex] = cat.name!
            self.searchParams[self.currentIndex].conditions.append(cat.name!)
            packupButClick()
            //向代理发送选中通知
            if let delegate = self.delegate {
                delegate.selectedCell(self.searchParams)
            }

        }
    }
    override  init(frame: CGRect) {
        super.init(frame: frame)
        //临时放到这里]


        var catArr = loadMerchantCategoryData()
        self.dataArray = [catArr,loadCityData(),load()]

        //避免使用除法提高性能
        var butW = frame.width * 0.3333
        for i in 0..<buttons.count {
            var but = self.buttons[i]
            but.title = self.searchParams[i].title!
            but.frame = CGRectMake(CGFloat(i) * butW, 0,butW, frame.height)
      
            self.addSubview(but)
        }
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapBut:"))

        self.panel = DropDownPanel(frame: CGRectMake(0,CGRectGetMidY(self.frame) - panelH, frame.width, panelH));
         self.backgroundColor = UIColor.whiteColor()
        self.panel?.delegate = self

        //SELECTED_NOTIFY
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "selectedCell:", name: "SELECTED_NOTIFY", object: nil)
    }
    func packupButClick() {
        tapMask()
    }

    override func didMoveToSuperview() {
        self.mask = UIView(frame: self.superview!.bounds)
        self.mask!.backgroundColor = UIColor.blackColor()
        self.mask!.hidden = true
        self.mask?.alpha = 0
        self.superview!.insertSubview(self.mask!, belowSubview: self)
        self.mask?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapMask"))

        self.superview?.insertSubview(self.panel!, aboveSubview: self.mask!)
    }
    func tapMask(){
       hiddenMask()
       movePanel()
    }

    func movePanel(){
        UIView.animateWithDuration(animateDuration, animations: { () -> Void in
            self.panel?.setOrigin(CGPointMake(0, CGRectGetMaxY(self.frame) - panelH - 5))
        })
    }
    func hiddenMask(){
        UIView.animateWithDuration(animateDuration, animations: { () -> Void in
            self.mask?.alpha = 0
            }, completion: { (Bool) -> Void in
                self.mask?.hidden = true
        })
    }
    func tapBut(tap:UITapGestureRecognizer){
        var location =  tap.locationInView(self)
        for i in 0..<self.buttons.count {
            var but = self.buttons[i]
            if CGRectContainsPoint(but.frame, location) {
                if i == self.currentIndex {
                    self.buttons[self.currentIndex].selected = false
                    hiddenMask()
                    movePanel()
                   self.currentIndex = -1
                }else {
                    but.selected = true
                    self.currentIndex = i

                    //显示遮罩层
                    self.mask?.hidden = false
                    UIView.animateWithDuration(animateDuration, animations: { () -> Void in
                        self.mask?.alpha = 0.6
                    })
                    //显示panel
                    UIView.animateWithDuration(animateDuration, animations: { () -> Void in
                        self.panel?.setOrigin(CGPointMake(0, CGRectGetMaxY(self.frame)))
                    })
                }

            }
        }

    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()

    }
}
class DropDownButton:UIButton{
    var title = ""{
        didSet{
            self.setTitle(title, forState: UIControlState.Normal)
            self.setTitle(title, forState: UIControlState.Selected)
        }
    }
    override  init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = false
        self.titleLabel?.font = UIFont.systemFontOfSize(12)
        var sep = UIImageView(image: UIImage(named: "icon_dropdown_tabseperator_line"))
        sep.setOrigin(CGPointMake(frame.width - sep.image!.size.width,0))
        self.addSubview(sep)
        self.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        self.setTitleColor(mainColor, forState: UIControlState.Selected)
        self.setBackgroundImage(UIImage.resizableImageWithName("btn_dropdown_tabitem"), forState: UIControlState.Normal)
        self.setImage(UIImage(named: "icon_dropdown_triangle_down"), forState: UIControlState.Normal)
        self.setImage(UIImage(named: "icon_dropdown_triangle_up"), forState: UIControlState.Selected)
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        return CGRectMake(contentRect.width - 15,contentRect.height - 24, 8, 8)
    }
}


// MARK: 下拉框面板
protocol DropDownPanelDelegate {
    func packupButClick()
}
class DropDownPanel: UIView,UITableViewDelegate,UITableViewDataSource {
    var packupBut:UIButton?
    var delegate:DropDownPanelDelegate?
    var masterData = [MerchantCategory](){
        didSet{
       self.masterTabView?.reloadData()
        }
    }
    var slaveData = [MerchantCategory](){
        didSet{
        self.slaveTabView?.reloadData()
        }
    }

    func showTableView(model:DropDownModel){
        if model.type == DropDownTableType.One {
            self.masterTabView?.setWidth(screenWidth)
            self.slaveTabView?.hidden = true
            self.masterData = model.categorys!
        }else {
            self.masterTabView?.setWidth(screenWidth * 0.5)
            self.slaveTabView?.hidden = false
            self.masterData = model.categorys!
            self.slaveData = [MerchantCategory]()
        }
    }
    // MARK: 主要表格
    var masterTabView:UITableView?
    var slaveTabView:UITableView?

    override  init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        self.packupBut = UIButton()
        self.packupBut?.adjustsImageWhenHighlighted = false
        self.addSubview(self.packupBut!)

        self.packupBut?.setBackgroundImage(UIImage.resizableImageWithName("btn_dropdown_packup"), forState: UIControlState.Normal)
        self.packupBut?.addTarget(self, action: "packupButClick", forControlEvents: UIControlEvents.TouchUpInside)

        self.masterTabView = UITableView(frame:CGRectMake(0, 0, frame.width * 0.5, frame.height-29.5), style: UITableViewStyle.Plain)
        self.masterTabView?.delegate = self
        self.masterTabView?.dataSource = self
        self.addSubview(self.masterTabView!)
        self.slaveTabView = UITableView(frame:CGRectMake(frame.width * 0.5, 0, frame.width * 0.5, frame.height-29.5), style: UITableViewStyle.Plain)
        self.slaveTabView?.delegate = self
        self.slaveTabView?.dataSource = self
        self.addSubview(self.slaveTabView!)

        self.masterTabView?.separatorStyle = UITableViewCellSeparatorStyle.None
        self.slaveTabView?.separatorStyle = UITableViewCellSeparatorStyle.None
        self.masterTabView?.rowHeight = 41
        self.slaveTabView?.rowHeight = 41
        self.masterTabView?.showsVerticalScrollIndicator = false
        self.slaveTabView?.showsVerticalScrollIndicator = false


    }

    // MARK: 表格代理方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if tableView == self.masterTabView {
            return self.masterData.count
        }else {
            return self.slaveData.count
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == self.masterTabView {
            if self.masterData[indexPath.row].subcategories.count == 0 {
                //没有二级数据
                //发送选中数据.
                NSNotificationCenter.defaultCenter().postNotificationName("SELECTED_NOTIFY", object: nil, userInfo: ["cat":self.masterData[indexPath.row]])
            }else{
                self.slaveData = self.masterData[indexPath.row].subcategories
            }
        }else {

            NSNotificationCenter.defaultCenter().postNotificationName("SELECTED_NOTIFY", object: nil, userInfo: ["cat":self.slaveData[indexPath.row]])
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == self.masterTabView {
             var cell = DropDownMasterCell.cellWithTableView(tableView)
             var catFrame = MastreCategoryFrame()
             catFrame.cat = self.masterData[indexPath.row]
             cell.catFrame = catFrame
             return cell
        }else {
             var cell = DropDownSlaveCell.cellWithTableView(tableView)
             var catFrame = SlaveCategoryFrame()
             catFrame.cat = self.slaveData[indexPath.row]
             cell.catFrame = catFrame
             return cell
        }

    }


    func packupButClick(){
        self.delegate?.packupButClick()
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        //self.packupBut?.adjustsImageWhenHighlighted = false
        self.packupBut?.frame  = CGRectMake(0,CGRectGetMaxY(self.masterTabView!.frame)+2.5,screenWidth, 29.5)
    }
}

//主表的cell
let catNameFont = UIFont.systemFontOfSize(13)
let catCountFont = UIFont.systemFontOfSize(9)
class DropDownMasterCell:UITableViewCell{

    var icon:UIImageView?
    var name:UILabel?
    var count:UIButton?

    var catFrame:MastreCategoryFrame?{
        didSet{
            if let catFrame = catFrame {
                if let icon = catFrame.cat!.icon {
                    self.icon?.hidden = false
                    self.icon?.image = UIImage(named:icon)
                }else{
                    self.icon?.hidden = true
                }
                self.icon?.frame = catFrame.iconFrame
                self.name?.text = catFrame.cat!.name
                self.name?.frame = catFrame.nameFrame
                if catFrame.cat!.total != "" {
                    self.count?.hidden = false
                self.count?.setTitle(catFrame.cat!.total, forState: UIControlState.Normal)
                }else {
                    self.count?.hidden = true
                }
                self.count?.frame = catFrame.countFrame
            }
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.icon = UIImageView()
        self.contentView.addSubview(self.icon!)

        self.name = UILabel()
        self.name?.font = catNameFont
        self.contentView.addSubview(self.name!)

        self.count = UIButton()
        self.count?.titleLabel?.font = catCountFont
        self.count?.setBackgroundImage(UIImage.resizableImageWithName("btn_dropdown_count"), forState: UIControlState.Normal)
        self.contentView.addSubview(self.count!)
        var bgView = UIImageView(frame: CGRectMake(0, 0, screenWidth * 0.5, 42))

        bgView.image = UIImage.resizableImageWithName("bg_dropdown_leftpart")
        self.backgroundView = bgView
        self.selectedBackgroundView = UIImageView(image: UIImage(named: "bg_dropdown_left_selected"))
    }

    override func layoutSubviews() {
        super.layoutSubviews()

    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   class func cellWithTableView(tableView:UITableView)->DropDownMasterCell{
        let cellId = "panelCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? DropDownMasterCell
        if  cell == nil {
            cell = DropDownMasterCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellId)
        }
        return cell!
    }


}
//从表的cell
class DropDownSlaveCell:UITableViewCell{
    var catFrame:SlaveCategoryFrame?{
        didSet{
            if let catFrame = catFrame {
                self.name?.frame = catFrame.nameFrame
                self.count?.frame = catFrame.countFrame
                self.name?.text = catFrame.cat?.name
                self.count?.text = catFrame.cat?.total
            }
        }
    }
    var name:UILabel?
    var count:UILabel?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.name = UILabel()
        self.count = UILabel()
        self.name?.font = catNameFont
        self.count?.font = catCountFont
        self.contentView.addSubview(self.name!)
        self.contentView.addSubview(self.count!)
        var bgView = UIImageView(image: UIImage.resizableImageWithName("bg_dropdown_rightpart"))
        self.backgroundView = bgView
        var selectedBgView = UIImageView(image: UIImage.resizableImageWithName("bg_dropdown_right_selected"))
        self.selectedBackgroundView = selectedBgView
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    class func cellWithTableView(tableView:UITableView)->DropDownSlaveCell{
        let cellId = "panelCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? DropDownSlaveCell
        if  cell == nil {
            cell = DropDownSlaveCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellId)
        }
        return cell!
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

}












