import UIKit

private let reuseIdentifier = "Cell"

let space = 20.0
var lineNumber = 5
var itemW = 0.0
var selectdIndex = 0
var level = 0

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadData()
        
        view.addSubview(mainCollectionView)
        
        self.title = "数学思维训练"
    }
    
    var randomData = 0
    var randomAnswer = 0

    var dataArray = [["\n🍉🍉 + 🍎 = 5 \n 🍉 + 🍎🍎 = 4 \n\n 🍎 = ?\n","\n🍉🍉🍉 + 🍎 = 9 \n 🍉 + 🍎🍎 = 8 \n\n 🍎 = ?\n","\n🍊🍊 + 🍎 = 7 \n 🍊🍊 + 🍎🍎 = 10 \n\n 🍎 = ?\n","\n🍊 + 🍎🍎🍎 = 28 \n 🍊🍊🍊 + 🍎 = 12 \n\n 🍎 = ?\n","\n🍓 + 🍊🍊 = 5 \n 🍊 + 🍓🍓 = 4 \n\n 🍓 = ?\n"],["\n🍌🍌🍌 + 🍎 = 11 \n 🍉 + 🍎🍎 = 16 \n 🍌🍌 + 🍉 = 10 \n\n 🍌 = ?","\n🍌 + 🍎 = 5 \n 🍉 + 🍎🍎 = 5 \n 🍉 + 🍎 = 3 \n\n 🍌 = ?\n","\n🍌 + 🍎🍎 = 8 \n 🍉 + 🍎🍎 = 5 \n 🍌🍌🍌 + 🍎 = 14 \n\n 🍌 = ?\n","\n🍌🍌 + 🍎🍎 = 14 \n 🍉 + 🍎🍎 = 5 \n 🍌 + 🍉 = 6 \n\n 🍌 = ?\n","\n🍊 + 🍎🍎 = 5 \n 🍉 + 🍎🍎 = 7 \n 🍊 + 🍉 = 4 \n\n 🍉 = ?\n"]]
    
    var answerArray = [[1,3,3,9,1],[2,3,4,5,3]]

    
    // MARK: - Netdata
    
    func loadData() {
        isfinish = false
        itemW = (view.bounds.size.width - space*Double((lineNumber + 1)))/Double(lineNumber) - 0.01
        randomData = Int(arc4random() % 5)
        randomAnswer = Int(arc4random() % 5)
        self.mainCollectionView.reloadData()
    }
    
    
    // MARK: - collectionview
    
    lazy var mainCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout.init()
        let collview = UICollectionView.init(frame: view.bounds, collectionViewLayout: layout)
        collview.delegate = self
        collview.dataSource = self
        collview.backgroundColor = UIColor.black
        collview.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collview.register(UINib.init(nibName: "BaseCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "BaseCollectionViewCell")
        
        return collview
        
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 1 {
            return 10
        }else if section == 0 {
            return 1
        }
        return 3
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    var isfinish = false
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: "BaseCollectionViewCell", for: indexPath) as! BaseCollectionViewCell
        
        cell.backgroundColor = .white
        cell.L.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        cell.L.textColor = .darkGray
        cell.layer.cornerRadius = 10

        if indexPath.section == 0 {
            
            cell.L.font = UIFont.systemFont(ofSize: 45, weight: .bold)
            cell.L.textColor = .black
            print(level%3)
            cell.setWith(title: dataArray[level%2][randomData], imageName: "1")
            cell.L.numberOfLines = 0
            
        }else if indexPath.section == 1{
            
            cell.backgroundColor = .systemGray6
            cell.setWith(title: String.init(format: "%ld", indexPath.row), imageName: "0")
            cell.layer.cornerRadius = itemW/2
            if isfinish && answerArray[level%2][randomData] == indexPath.row{
                cell.backgroundColor = .systemPink
                cell.L.textColor = .white
            }
            
        }else{
            
            if indexPath.row == 0 {
                cell.setWith(title: "重新开始", imageName: "0")
            }else if indexPath.row == 1{
                cell.setWith(title: String.init(format: "分数:%ld", level), imageName: "0")
            }else{
                cell.setWith(title: "赞", imageName: "0")
            }
            
            cell.backgroundColor = .systemGray5

        }
        
        return cell
    }
    
    
    // MARK: - UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
             if view.bounds.size.height/view.bounds.size.width > 2.0 {
                 return CGSize(width: view.bounds.size.width - space*2, height: view.bounds.size.width - space*2)
            }
            return CGSize(width: view.bounds.size.width - space*2, height: view.bounds.size.width*0.5 - space*2)
        }else if indexPath.section == 2{
            let W = (view.bounds.size.width - space*Double((3 + 1)))/Double(3) - 0.01
            return CGSize(width: W, height: W/2)

        }
        return CGSize(width: itemW, height: itemW)

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if answerArray[level%2][randomData] == indexPath.row{
                level = level + 1
                self.loadData()
            }else{
                isfinish = true
                // 显示提示信息
                let alert = UIAlertController(title: "回答错误", message: "分数将清0", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "重新开始", style: .default, handler: {_ in 
                    level = 0
                    self.loadData()
                }))
                alert.addAction(UIAlertAction(title: "取消", style: .default, handler: nil))

                self.present(alert, animated: true, completion: nil)
                self.mainCollectionView.reloadData()
            }
        }else if indexPath.section == 2{
            if indexPath.row == 0 {
                level = 0
                self.loadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return space
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return space
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 2 {
            return UIEdgeInsets.init(top: space*2, left: space, bottom: space, right: space)
        }
        return UIEdgeInsets.init(top: space, left: space, bottom: space, right: space)
    }
    
}
