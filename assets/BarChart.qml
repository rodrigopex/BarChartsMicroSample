import bb.cascades 1.0
Container {
    id: self
    property bool ready: false
    property alias title: titleLabel.text
    property variant values
    function setData(v) {
        values = v
        render()
    }
    function render() {
        if (self.ready) {
            var max = 0
            for (var i = 0; i < values.length; ++ i) {
                console.log("bar:", i)
                if (max < values[i].value) max = values[i].value
            }
            if (barsContainer.controls.length == 0) {
                for (var i = 0; i < values.length; ++ i) {
                    var newBar = barFactory.createObject(barsContainer)
                    console.log("current value", frameHandler.layoutFrame.height * values[i].value / max)
                    console.log(":::", frameHandler.layoutFrame.height, values[i].value, max)
                    newBar.actualHeight = frameHandler.layoutFrame.height * values[i].value / max
                    newBar.displayValue = values[i].value
                    newBar.title = values[i].title
                    barsContainer.add(newBar)
                }
            } else {
                for (var i = 0; i < values.length; ++ i) {
                    console.log("current value", frameHandler.layoutFrame.height * values[i].value / max)
                    console.log(":::", frameHandler.layoutFrame.height, values[i].value, max)
                    barsContainer.controls[i].displayValue = values[i].value
                    barsContainer.controls[i].title = values[i].title
                    barsContainer.controls[i].actualHeight = frameHandler.layoutFrame.height * values[i].value / max
                }
            }
        }
    }
    function clearData() {

    }
    attachedObjects: [
        ComponentDefinition {
            id: barFactory
            source: "Bar.qml"
        }
    ]
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
        id: chart
        property int max: 500
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        Container {
            id: barsContainer
            //background: Color.Yellow
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
                        self.ready = true
                        console.log("Layout changed:", layoutFrame.height)
                        self.render()
                    }
                }
            ]
        }
    }
}
