% This section of code reads data being logged by the ESP-32 on a serial port and computes the 
% 20 second averages of RSSI readings grouped by MAC addresses to get the most accurate readings.
% For a more detailed analysis refer to section 3.3 of the project report. 

serialportlist("available")
s = serialport("/dev/cu.usbserial-10", 115200);
configureTerminator(s, "LF"); 
flush(s);
aps = ["AP1","AP2","AP3","AP4","AP5"];
rssi_logs = containers.Map();

% Initialize each AP with an empty array
for i = 1:length(aps)
    rssi_logs(aps(i)) = [];
end

disp("Starting serial reading for 20 seconds...");
startTime = datetime('now');
durationSeconds = 20;

while seconds(datetime('now') - startTime) < durationSeconds
    if s.NumBytesAvailable > 0
        line = readline(s);
        disp(line);

        if contains(line, "Label:") && contains(line, "MAC:") && contains(line, "RSSI:")
            parts = split(line, char(9));
            if length(parts) >= 4
                label_part = strrep(parts{2}, "Label: ", "");
                rssi_part = strrep(parts{4}, "RSSI: ", "");
                rssi_val = str2double(strrep(rssi_part, " dBm", ""));

                if ismember(label_part, aps)
                    % Append RSSI values
                    rssi_logs(label_part) = [rssi_logs(label_part), rssi_val];
                end
            end
        end
    end
end

% Compute averages
disp("=== Average RSSI Readings Over 20 Seconds ===");
avg_rssi_values = containers.Map();
val=[-120,-120,-120,-120,-120];
for i = 1:length(aps)
    values = rssi_logs(aps(i));

    if isempty(values)
        avg = -120;  % If no reading is received
    else
        avg = mean(values);
    end
    avg_rssi_values(aps(i)) = avg;
    val(i)=avg;
    fprintf("%s: %.2f dBm\n", aps(i), avg);
end

ap1=val(1);
ap2=val(2);
ap3=val(3);
ap4=val(4);
ap5=val(5);