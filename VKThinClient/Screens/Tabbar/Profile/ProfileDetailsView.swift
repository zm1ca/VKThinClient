//
//  ProfileDetailsView.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 30.06.21.
//

import UIKit

class ProfileDetailsView: UIView {
    
    let titleLabel = UILabel()
    let valueLabel = UILabel()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func set(title: String, value: Int) {
        self.titleLabel.text = title
        self.valueLabel.text = "\(value)"
    }
    
    private func configure() {
        titleLabel.text = "Group"
        valueLabel.text = "Value"
        
        layer.cornerRadius = 12
        clipsToBounds      = true
        backgroundColor    = .lightGray
        
        addSubview(titleLabel)
        addSubview(valueLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -20),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            valueLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)
        ])
    }

}
