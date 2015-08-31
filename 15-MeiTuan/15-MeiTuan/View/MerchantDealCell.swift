//
//  MerchantDealCell.swift
//  15-MeiTuan
//
//  Created by 张明楠 on 15/8/22.
//  Copyright (c) 2015年 张明楠. All rights reserved.
//

import UIKit
 let detailLabelColor = UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 1)
 let titleLabelColor = UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1)
class MerchantDealCell: UITableViewCell {


    class func cellWithTableView(tb:UITableView)->MerchantDealCell{

        let cellId = "merchantCellId"
        var cell = tb.dequeueReusableCellWithIdentifier(cellId) as? MerchantDealCell
        if cell == nil {
            cell  = MerchantDealCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellId)
        }
        return cell!
    }


    var iconView:UIImageView?
    var title:UILabel?
    var cat:UILabel?
    var region:UILabel?
    var startView:StarView?
    var price:UILabel?
    var distance:UILabel?
    var purchaseCount:UILabel?

    var dealFrame:MerchantDealFrame?{
        didSet{
            if let df = dealFrame {
                self.iconView?.frame = df.icon
                self.iconView?.kf_setImageWithURL(NSURL(string: df.deal!.s_image_url!)!)
                self.title?.frame = df.title
                self.title?.text = df.deal!.title
                self.cat?.frame = df.cat
                self.cat?.text = df.deal?.categorie
                self.region?.frame = df.region
                self.region?.text = df.deal?.region
                self.startView?.frame = df.startView
                self.startView?.score = Float(arc4random() % 9 + 1) * 0.5
                self.price?.frame = df.price
                self.price?.text =  df.deal?.current_price
                self.distance?.frame = df.distance
                self.distance?.text = df.deal?.distance
                self.purchaseCount?.frame = df.purchaseCount
                self.purchaseCount?.text = df.deal?.purchase_count
            }
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.iconView = UIImageView()
        self.contentView.addSubview(self.iconView!)
        self.title = UILabel()
        self.title?.textColor = titleLabelColor
        self.title?.font = UIFont.systemFontOfSize(dealTitleFont)
        self.contentView.addSubview(self.title!)

        self.cat = UILabel()
        self.cat?.textColor = detailLabelColor
        self.cat?.font = UIFont.systemFontOfSize(detailFont)
        self.contentView.addSubview(self.cat!)

        self.region = UILabel()
                self.region?.textColor = detailLabelColor
        self.region?.font = UIFont.systemFontOfSize(detailFont)
        self.contentView.addSubview(self.region!)

        self.startView = StarView()

        self.contentView.addSubview(self.startView!)

        self.price = UILabel()
                    self.price?.textColor = detailLabelColor
        self.price?.font = UIFont.systemFontOfSize(detailFont)
        self.contentView.addSubview(self.price!)

        self.distance = UILabel()
         self.distance?.textColor = detailLabelColor
        self.distance?.font = UIFont.systemFontOfSize(detailFont)
        self.contentView.addSubview(self.distance!)


        self.purchaseCount = UILabel()
                 self.purchaseCount?.textColor = detailLabelColor
        self.purchaseCount?.font = UIFont.systemFontOfSize(detailFont)
        self.contentView.addSubview(self.purchaseCount!)

        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.backgroundView = UIImageView(image: UIImage.resizableImageWithName("bg_tableViewCell_highlighted"))

    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
