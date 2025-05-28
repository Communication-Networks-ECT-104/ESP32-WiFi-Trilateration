// This code runs on ESP-32 wifi module where it detects all available 2.4 GHz wifi networks and
// filters all networks that refer to IITR-WiFi. It then logs the individual signal strength recieved
// from each router with there MAC addresses. For a detailed analysis refer to section 3.1 of the project report.

#include "WiFi.h"

void setup() {
    Serial.begin(115200);
    WiFi.mode(WIFI_STA);
    WiFi.disconnect(true);
    delay(100);
}

void loop() {
    int n = WiFi.scanNetworks();
    if (n == 0) {
        Serial.println("No networks found");
    } else {
        for (int i = 0; i < n; ++i) {
            String ssid = WiFi.SSID(i);
            String bssid = WiFi.BSSIDstr(i); // MAC address of the scanned AP
            int rssi = WiFi.RSSI(i);

            if (ssid == "IITR_WIFI") {
                String apLabel = "";

                if (bssid == "00:XX:XX:XX:AP:01") {
                apLabel = "AP1";
                }

                else if (bssid == "00:XX:XX:XX:AP:02") {
                apLabel = "AP2";
                }

                else if (bssid == "00:XX:XX:XX:AP:03") {
                apLabel = "AP3";
                }

                else if (bssid == "00:XX:XX:XX:AP:04") {
                apLabel = "AP4";
                }

                else if (bssid == "00:XX:XX:XX:AP:05") {
                apLabel = "AP5";
                }

                if (apLabel != "") {
                Serial.printf("SSID: %s\tLabel: %s\tMAC: %s\tRSSI: %.1f dBm\n",ssid.c_str(), apLabel.c_str(), bssid.c_str(), (float)rssi);
                }
            }
        }
    }

    delay(2000); // Scan every 2 seconds
}