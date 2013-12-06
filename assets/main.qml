/*
 * Copyright (c) 2011-2013 BlackBerry Limited.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import bb.cascades 1.0

Page {
    Container {
        BarChart {
            id: chart
            title: qsTr("Bar Chart Micro Sample")
            topPadding: 20
            leftPadding: 20
            rightPadding: 20
            bottomPadding: 20
            onCreationCompleted: {
                chart.values = [ {
                        "title": "10/12",
                        "value": 350
                    }, {
                        "title": "11/12",
                        "value": 150
                    },
                    {
                        "title": "12/12",
                        "value": 200
                    }, {
                        "title": "13/12",
                        "value": 100
                    },
                    {
                        "title": "14/12",
                        "value": 400
                    }, {
                        "title": "15/12",
                        "value": 500
                    },
                    {
                        "title": "16/12",
                        "value": 300
                    } ]
                chart.render()
            }
        }
        Container {
            bottomPadding: 20
            horizontalAlignment: HorizontalAlignment.Center
            Button {
                text: "Generate values and plot"
                onClicked: {
                    var v = []
                    for (var i = 0; i < 7; ++ i) {
                        v.push({
                                "title": (10 + i) + "/12",
                                "value": Math.round(800 * Math.random())
                        })
                        
                    }
                    chart.values = v
                    chart.render()
                }
            }
        }
    }
}