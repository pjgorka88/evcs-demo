import QtQuick 2.7

Item
{
    id: root
    property double chargedJump:  0.2922
    property double chargedDelta: 0.01488
    property double bottomValue:  0
    property double topValue:     100
    property alias  colorValue:   shEffect1.colorValue

    Image {
        id: imageBars
        x: 0
        y: 0
        width: 100
        height: 280
        visible: false
        fillMode: Image.PreserveAspectFit
        source: "Assets/Battery/EVCS_UI_battery_100x280.png"
    }

    focus: true

    Image {
        id: imageGradient
        x: 0
        y: 0
        width: 100
        height: 280
        visible: false
        source: "Assets/Battery/EVCS_UI_battery_gradient_100x280.png"
    }

    ShaderEffect {
        id: shEffect1;
        x: 0
        y: 0
        width: 100
        height: 280
        property variant src: imageBars;
        property variant src1: imageGradient;
        property color  colorValue: Qt.rgba( 1,1,1,1 );
        property double chargedBottom: ( Math.floor( bottomValue * chargedJump ) * ( 1 / chargedJump ) )*(1-2*chargedDelta)*0.01 + chargedDelta;
        property double chargedTop:    ( Math.floor( topValue * chargedJump )    * ( 1 / chargedJump ) )*(1-2*chargedDelta)*0.01 + chargedDelta;


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
                        uniform lowp  vec4 colorValue;
                        uniform lowp  float chargedBottom;
                        uniform lowp  float chargedTop;
                        uniform sampler2D src;
                        uniform sampler2D src1;
                        uniform lowp float qt_Opacity;
                        void main() {

                            lowp float bottomMultiplier = step(chargedBottom, 1.0 - coord.y );
                            lowp float topMultiplier    = 1.0 - step(chargedTop, 1.0 - coord.y );

                            lowp vec4 tex0 = texture2D(src, coord);
                            lowp vec4 tex1 = texture2D(src1, coord);
                            gl_FragColor = clamp( tex0 *colorValue + tex1, vec4(0,0,0,0), vec4(1,1,1,1) ) * qt_Opacity * topMultiplier * bottomMultiplier;
                        }"

    }
}

