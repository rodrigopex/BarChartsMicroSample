import bb.cascades 1.2

Container {
    id: self
    preferredHeight: 1280
    property alias model: chartList.dataModel
    property alias title: titleLabel.text
    function setData(values) {
        arr.clear()
        arr.insertList(values)
        chartList.getMax()
    }
    function clear() {
        arr.clear()
    }
    attachedObjects: [
        LayoutUpdateHandler {
            id: frameHandler
            onLayoutFrameChanged: {
                console.log("Bar list:Layout changed:", layoutFrame.height)
                if (frameHandler.layoutFrame.height > 10)
                    chartList.height = frameHandler.layoutFrame.height - 50
            }
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
    ListView {
        id: chartList
        property int max: 10
        scrollIndicatorMode: ScrollIndicatorMode.None
        onMaxChanged: {
            console.log("Max list:", chartList.max)
        }
        property int height: 10
        onHeightChanged: {
            console.log("Current height:", height)
        }
        dataModel: GroupDataModel {
            id: arr
            sortingKeys: ["title"]
            sortedAscending: false
        }
        onDataModelChanged: {
            chartList.getMax()
        }
        function getMax() {
            console.log("List model changed!")
            for (var indexPath = arr.first(); ! indexPath.isEmpty; indexPath = arr.after(indexPath)) {
                console.log("Trying max:", arr.data(indexPath).value)
                if (chartList.max < arr.data(indexPath).value) {
                    chartList.max = arr.data(indexPath).value
                }
            }
        }
        layout: StackListLayout {
            orientation: LayoutOrientation.RightToLeft
        }
        onCreationCompleted: {
            arr.insert({
                        "title": "10/12",
                        "value": 150
                    })
            arr.insert({
                        "title": "11/12",
                        "value": 350
                    })
            arr.insert({
                        "title": "12/12",
                        "value": 350
                    })
            chartList.getMax()
        }
        listItemComponents: [
            ListItemComponent {
                type: "item"
                BarForList {
                    title: ListItemData.title
                    displayValue: ListItemData.value
                    actualHeight: ListItem.view.height * ListItemData.value / ListItem.view.max
                    onActualHeightChanged: {
                        console.log("actualHeight", actualHeight)
                    }
                }
            },
            ListItemComponent {
                type: "header"
                Container {
                }
            }
        ]
    }
}
