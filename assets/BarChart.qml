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
Container {
    id: self
    property bool ready: false
    property alias title: titleLabel.text
    property variant values
    topPadding: 20
    leftPadding: 20
    rightPadding: 20
    bottomPadding: 20
    attachedObjects: [
        ComponentDefinition {
            id: barFactory
            source: "Bar.qml"
        }
    ]
    onValuesChanged: {
        self.render()
    }
    function setData(v) {
        values = v
    }
    function getMax(values) {
        var max = 0
        Math.max(values)
        for (var i = 0; i < values.length; ++ i) {
            if (max < values[i].value) max = values[i].value
        }
        console.log("MAX:", max)
        return max
    }
    function render() {
        if (self.ready) {
            var max = getMax(self.values)
            while (barsContainer.controls.length != values.length) {
                var diff = barsContainer.controls.length - values.length
                console.log("Diff", diff)
                if (diff > 0) {
                    var deletedItem = barsContainer.controls[0]
                    barsContainer.remove(deletedItem)
                    destroy(deletedItem)
                } else { //diff > 0
                    var newBar = barFactory.createObject(barsContainer)
                    barsContainer.add(newBar)
                }
            }
            var currentItem
            for (var i = 0; i < values.length; ++ i) {
                currentItem = barsContainer.controls[i]
                currentItem.displayValue = values[i].value
                currentItem.title = values[i].title
                currentItem.actualHeight = frameHandler.layoutFrame.height * values[i].value / max
            }
        }
    }
    function clearData() {
        self.values = []
    }
    Container {
        topPadding: 20
        horizontalAlignment: HorizontalAlignment.Center
        Label {
            id: titleLabel
            text: "Title"
            textStyle.base: SystemDefaults.TextStyles.TitleText
        }
    }
    Container {
        id: chartArea
        property bool empty: (self.values.length <= 0)
        layout: DockLayout {
        }
        Container {
            opacity: 0.5 * chartArea.empty
            background: Color.LightGray
            preferredHeight: 1280
            preferredWidth: 1280
        }
        Label {
            opacity: 1.0 * chartArea.empty
            text: "Chart is empty"
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            textStyle.base: SystemDefaults.TextStyles.BigText
        }
        Container {
            id: chart
            property int max: 500
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            Container {
                id: barsContainer
                preferredHeight: 1280
                preferredWidth: 1280
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Fill
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                attachedObjects: [
                    LayoutUpdateHandler {
                        id: frameHandler
                        onLayoutFrameChanged: {
                            console.log("Layout changed:", layoutFrame.height)
                            if (self.ready == false)
                                self.ready = true
                            self.render()
                        }
                    }
                ]
            }
        }
    }
}
