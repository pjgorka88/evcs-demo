import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import App 1.0

Item {
    id: batteryItem
    width: 100
    height: 280

    property double initialCharge: 0
    property double topUpCharge:   0

    property double chargedPercentage: Variables.initialCharge
    property bool   chargingStarted: false

    signal signalChargeCompleted();

    function initializeValues()
    {
        propA.restart();
        propA.from = Variables.initialCharge;
    }

    function getColor()
    {
        if ( chargingStarted === true )
        {
            if ( chargedPercentage < 25 )
            {
                return Qt.rgba( 1,0,0,1 );
            }
            else if ( chargedPercentage < 75 )
            {
                return Qt.rgba( 1,1,0,1 );
            }
            else
            {
                return Qt.rgba( 0,1,0,1 );
            }
        }
        else
        {
            return Qt.rgba( 1,1,1,1 );
        }
    }

    function updateColor()
    {
        shEffect2.colorValue  = getColor();
        batteryBar.colorValue = getColor();
    }

    PropertyAnimation
    {
        id: propA;
        running: batteryItem.chargingStarted;
        target:  batteryItem;
        property: "chargedPercentage";
        to: 100;
        duration: Variables.timeToComplete;
    }

    onChargedPercentageChanged:
    {
        if ( chargingStarted )
        {
            updateColor();
            batteryBar.topValue = batteryItem.chargedPercentage;
            if ( chargedPercentage >= topUpCharge  )
            {
                chargedPercentage = topUpCharge;
                batteryItem.chargingStarted = false;
                batteryItem.signalChargeCompleted();
            }
        }
    }

    BatteryBars
    {
        id: batteryBar
        bottomValue: 0
        topValue: batteryItem.topUpCharge
    }

    BatteryBars
    {
        id: topBatteryPart
        visible: batteryItem.chargingStarted
        bottomValue: batteryItem.chargedPercentage
        topValue: 0
        opacity: 0.5

        PropertyAnimation
        {
            id: propB;
            running: batteryItem.chargingStarted;
            loops: 1
            target: topBatteryPart;
            property: "topValue";
            from: batteryItem.chargedPercentage
            to: 100;
            duration: 4000;

            onStopped:
            {
                propB.from = batteryItem.chargedPercentage;
                propB.start();
            }
        }
    }

    Image {
        x: 0
        y: 0
        opacity: 0.1
        width: 100
        height: 280
        source: "Assets/Battery/EVCS_UI_battery_100x280.png"
    }

    Image {
        id: imageGlow
        x: 0
        y: 0
        visible: false
        width: 100
        height: 280
        source: "Assets/Battery/EVCS_UI_battery_frames_100x280.png"
    }

    ShaderEffect {
        id: shEffect2;
        width: 100
        height: 280
        x: 0;
        y: 0;
        property variant src: imageGlow;
        property color colorValue: Qt.rgba( 1,1,1,1 );
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
                        uniform sampler2D src;
                        uniform lowp float qt_Opacity;
                        void main() {

                            lowp vec4 tex0 = texture2D(src, coord);
                            gl_FragColor = tex0 *colorValue * qt_Opacity;
                        }"

    }

}
