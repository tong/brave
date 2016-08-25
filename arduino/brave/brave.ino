
#include <Brain.h>

Brain brain( Serial );

void setup() {
    Serial.begin( 9600 );
}

void loop() {

    if( brain.update() ) {

        //Serial.println( brain.readErrors() );
        Serial.println( brain.readCSV() );

        //uint8_t signal = brain.readSignalQuality();

        /*
        Serial.write( brain.readSignalQuality() );
        Serial.write( brain.readAttention() );
        Serial.write( brain.readMeditation() );
        //Serial.write( brain.readPowerArray() );
        Serial.write( brain.readDelta() );
        Serial.write( brain.readTheta() );
        Serial.write( brain.readLowAlpha() );
        Serial.write( brain.readHighAlpha() );
        Serial.write( brain.readLowBeta() );
        Serial.write( brain.readHighBeta() );
        Serial.write( brain.readLowGamma() );
        Serial.write( brain.readMidGamma() );
        */
    }
}
