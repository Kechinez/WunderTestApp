//
//  ParentView.swift
//  WunderTestApp
//
//  Created by Nikita Kechinov on 27.09.2018.
//  Copyright © 2018 Nikita Kechinov. All rights reserved.
//

import UIKit

class ParentView: UIView {

    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentView)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        let guide = self.safeAreaLayoutGuide
        contentView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    }
    
}
