//
//  BarChartView.swift
//  WeatherApp
//
//  Created by Lubarda, Miso on 8/21/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit

class BarChartView: UIView {
    private let columnSpace: CGFloat = 4

    func update(with values: [Double]) {
        reset()

        let maxValue = values.max() ?? 0

        let columnTupples: [(UIView, Double)] = values.map {
            let column = UIView()
            column.backgroundColor = .red
            return (column, $0)
        }

        columnTupples.enumerated().forEach { offset, columnTupple in
            let view = columnTupple.0
            let value = columnTupple.1
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)

            view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            view.heightAnchor.constraint(equalTo: heightAnchor, multiplier: CGFloat(value/maxValue)).isActive = true

            if columnTupples.first?.0 == view {
                view.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            } else if columnTupples.last?.0 == view {
                view.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            }

            if columnTupples.first?.0 != view {
                let previousView = columnTupples[offset - 1].0
                view.leftAnchor.constraint(equalTo: previousView.rightAnchor, constant: columnSpace).isActive = true
                view.widthAnchor.constraint(equalTo: previousView.widthAnchor, multiplier: 1).isActive = true
            }
        }
    }

    private func reset() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}
