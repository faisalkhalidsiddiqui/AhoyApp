//
//  ViewController.swift
//  ahoyweather
//
//  Created by FAISAL KHALID on 05/02/2022.
//

import UIKit
import RxSwift

import RxCocoa

class WeatherDashboardViewController: UIViewController {
    
    let viewModel = WeatherDashboardViewModel()
    @IBOutlet weak var tableview: UITableView!
    var disposeBag  = DisposeBag()
  
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var tempH: UILabel!
    @IBOutlet weak var tempL: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var shortDescription: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var weatherLocation = "Dubai"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.tableview.rowHeight = 100.0
            
            

        }
        
        
        
  
        // Do any additional setup after loading the view.
        
        
        
        viewModel.fetchAllWeatherDataViewModels(byCity: weatherLocation).bind(to: tableview.rx.items(cellIdentifier: "weatherdashboardcell",cellType: WeatherDashboardCell.self)) { index,listModel,cell in
           
            DispatchQueue.main.async {
                if index == 0 {
                    self.activityIndicator.stopAnimating()
                    self.thumbnail.image = listModel.thumbnail

                    self.tempH.text = listModel.tempH
                    self.tempL.text = listModel.tempL
                    self.city.text = self.weatherLocation
                    self.shortDescription.text = listModel.shortDescription
                }
                
                cell.tempL.text = listModel.tempL
            cell.tempH.text = listModel.tempH
            cell.day.text = listModel.day
                
                print( listModel.tempH)
            cell.thumbnail.image = listModel.thumbnail
            cell.shortDescription.text = listModel.shortDescription
                
            }
          
                
           
            
          
        }.disposed(by: disposeBag)
        
    
        

    }


}

