import QtQuick 2.8
import QtQuick.Controls 2.0

Dial {
    id: dial

    background: Item
    {
        x: dial.width / 2 - width / 2
        y: dial.height / 2 - height / 2
        width: 240
        height: 240

        Image {
            id: imageFill
            visible: false;
            source: "Assets/Select/dial_inside_bottom_240x240.png"
            width: 240
            height: 240
        }
        Image {
                anchors.centerIn: parent
                width: 20
                height: 40
                fillMode: Image.PreserveAspectFit
                source: "Assets/Select/EVCS_charge_icon_20x40.png"
        }

        ShaderEffect {
            id: shEffect;
            width: 240
            height: 240
            x: 0;
            y: 0;
            rotation: -95
            property variant src: imageFill;
            property real angle: dial.angle *0.017453292519943295769236907684890;
            vertexShader: "
                uniform highp mat4 qt_Matrix;
                attribute highp vec4 qt_Vertex;
                attribute highp vec2 qt_MultiTexCoord0;
                varying highp vec2 coord;
                void main() {
                    coord = qt_MultiTexCoord0;
                    gl_Position = qt_Matrix * qt_Vertex;
                }"

            fragmentShader: "
                            varying highp vec2 coord;
                            uniform sampler2D src;
                            uniform lowp float qt_Opacity;
                            uniform lowp float angle;
                            void main() {

                                lowp float pixelAngleTan = atan( coord.y - 0.5, coord.x - 0.5 );
                                if ( ( pixelAngleTan > angle ) || ( pixelAngleTan < -2.44346 ) || ( pixelAngleTan > 2.44346 ) )
                                {
                                    gl_FragColor = vec4( 0, 0,0, 0);
                                }
                                else
                                {
                                    gl_FragColor = texture2D(src, coord) * qt_Opacity;
                                }
                            }"

        }
        Image {
            source: "Assets/Select/dial_outside_top_240x240.png"
            width: 240
            height: 240
        }
    }
    handle: Image {
        id: handleItem
        x: dial.background.x + dial.background.width / 2 - width / 2
        y: dial.background.y + dial.background.height / 2 - height / 2
        width: 16
        height: 16
        //color: dial.pressed ? "#17a81a" : "#21be2b"
        //radius: 8
        source: "Assets/Select/EVCS_dial_button_16x16.png"
        antialiasing: true
        opacity: dial.enabled ? 1 : 0.3
        transform: [
            Translate {
                x: -8
                y: -Math.min(dial.background.width, dial.background.height) * 0.4 + handleItem.height / 2 - 8

            },
            Rotation {
                angle: dial.angle
                origin.x: handleItem.width / 2
                origin.y: handleItem.height / 2
            }
        ]
    }
}
