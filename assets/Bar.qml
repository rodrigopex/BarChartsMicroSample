import bb.cascades 1.0

Container {
    id: self
    property alias displayValue: valueLabel.text
    property alias title: titleLabel.text
    property alias actualHeight: bar.preferredHeight
    rightMargin: 20
    verticalAlignment: VerticalAlignment.Bottom
    layoutProperties: StackLayoutProperties {
        spaceQuota: 1
    }
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        Label {
            id: valueLabel
            text: "200"
            textStyle.base: SystemDefaults.TextStyles.SmallText
            horizontalAlignment: HorizontalAlignment.Center
        }
    }
    Container {
        Divider {
        }
    }
    Container {
        id: bar
        preferredHeight: 200
        horizontalAlignment: HorizontalAlignment.Fill
        background: Color.create("#CC3F10")
    }
    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        Label {
            id: titleLabel
            text: "10/12"
            textStyle.base: SystemDefaults.TextStyles.SmallText
            horizontalAlignment: HorizontalAlignment.Center
            textStyle.fontWeight: FontWeight.W600
        }
    }
}
