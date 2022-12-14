//
//  QSTableTestController.swift
//  QSSwiftDemo
//
//  Created by tianmaotao on 2022/8/30.
//

import UIKit
import AVKit

class QSTableTestController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.register(QSTableViewCell.self, forCellReuseIdentifier: "tableViewCellId")
        return tableView
    }()
    var viewModels: [QSListCardViewModel] = []
    var playerVC: AVPlayerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let persons: [Dictionary<String, Any>] = [
            ["name" : "张无忌", "sex" : "男", "age" : 22, "desc" : ""],
            ["name" : "赵敏", "sex" : "女", "age" : 20, "desc" : ""],
            ["name" : "小昭", "sex" : "女", "age" : 19, "desc" : ""],
            ["name" : "周芷若", "sex" : "女", "age" : 20, "desc" : ""],
            ["name" : "蛛儿", "sex" : "女", "age" : 18, "desc" : ""],
        ]
        
        for dic in persons {
            let vm = QSListCardViewModel()
            if let name = dic["name"] as? String {
                vm.name = name
            }
            if let sex = dic["sex"] as? String {
                vm.sex = sex
            }
            if let age = dic["age"] as? Int {
                vm.age = age
            }
            if let desc = dic["desc"] as? String {
                vm.brief = "倚天屠龙记主演：\(vm.name) \(desc)"
            }
            viewModels.append(vm)
        }
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    ///UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: QSTableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellId", for: indexPath) as! QSTableViewCell
        cell.bind(by: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vm = viewModels[indexPath.row]
        print("我是\(vm.name)，我今年\(vm.age)岁了，我是\(vm.sex)的")
        switch indexPath.row {
        case 0:
            jumpTabTestPage()
        case 1:
            openAVPlayer()
        default:
            print("")
        }
    }
    
    func createAVPlayer() {
        if self.playerVC != nil {
            self.playerVC?.view.removeFromSuperview()
            self.playerVC = nil
        }
        let playerVC = AVPlayerViewController()
        let player = AVPlayer(url: URL(string: "https://liveop.cctv.cn/hls/4KHD/playlist.m3u8")!)
        playerVC.player = player
        playerVC.showsPlaybackControls = true
        playerVC.player?.play()
        playerVC.requiresLinearPlayback = false
        playerVC.view.frame = CGRect(x: 0, y: self.view.frame.height - 200, width: self.view.frame.width, height: 200)
        self.playerVC = playerVC
        view.addSubview(playerVC.view)
    }
    
    // MARK: events
    private func openAVPlayer() {
        createAVPlayer()
    }
    
    private func jumpTabTestPage() {
        let tabVC = QSTabTestController()
        self.present(tabVC, animated: true)
    }
}


protocol QSListCardProtocol {
    var name: String { get }
    var sex: String { get }
    var age: Int { get }
    var brief: String { get }
}

class QSListCardViewModel: QSListCardProtocol {
    var name: String
    var sex: String
    var age: Int
    var brief: String
    init() {
        name = ""
        sex = ""
        age = 0
        brief = ""
    }
}

class QSTableViewCell : UITableViewCell {
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.textColor = UIColor.black
        nameLabel.numberOfLines = 1
        nameLabel.textAlignment = .left
        return nameLabel
    }()
    let sexLabel: UILabel = {
        let sexLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        sexLabel.font = UIFont.systemFont(ofSize: 14)
        sexLabel.textColor = UIColor.lightGray
        sexLabel.numberOfLines = 1
        sexLabel.textAlignment = .left
        return sexLabel
    }()
    var descLabel: UILabel = {
        let descLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        descLabel.font = UIFont.systemFont(ofSize: 14)
        descLabel.textColor = UIColor.lightGray
        descLabel.numberOfLines = 0
        descLabel.textAlignment = .left
        return descLabel
    }()
    var viewModel: QSListCardViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(nameLabel)
        self.addSubview(sexLabel)
        self.addSubview(descLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRect(x: 12, y: 20, width: self.frame.width - 24, height: nameLabel.font.lineHeight)
        sexLabel.frame = CGRect(x: 12, y: nameLabel.frame.maxY + 5, width: self.frame.width - 24, height: sexLabel.font.lineHeight)
        descLabel.frame = CGRect(x: 12, y: sexLabel.frame.maxY, width: self.frame.width - 24, height: 50)
    }
    
    fileprivate func bind(by viewModel: QSListCardViewModel?) {
        self.viewModel = viewModel
        if self.viewModel != nil {
            nameLabel.text = self.viewModel?.name
            sexLabel.text = self.viewModel?.sex
            descLabel.text = self.viewModel?.brief
        }
        self.setNeedsLayout()
    }
}
