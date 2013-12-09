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
    property alias actualHeight: bar.preferredHeight
    property alias displayValue: valueLabel.text
    property alias title: titleLabel.text
    rightMargin: 20
    preferredHeight: 1280
    layout: DockLayout {
    }
    Container {
        verticalAlignment: VerticalAlignment.Bottom
        layoutProperties: StackLayoutProperties {
            spaceQuota: 1
        }
        Container {
            horizontalAlignment: HorizontalAlignment.Center
            Label {
                id: valueLabel
                text: "200"
                textStyle.base: SystemDefaults.TextStyles.SmallText
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
            horizontalAlignment: HorizontalAlignment.Center
            Label {
                id: titleLabel
                text: "10/12"
                textStyle.base: SystemDefaults.TextStyles.SmallText
                textStyle.fontWeight: FontWeight.W600
            }
        }
    }
}
