% This code is the combination of all the sections that were developed individually for 
% different tasks. The individual sections can be found in the ./individual_sections folder.
% For a detailed analysis of this code please refer to sections 3.2, 3.3, 3.4 and 3.5 of the project report.


serialportlist("available")
s = serialport("/dev/cu.usbserial-10", 115200);
configureTerminator(s, "LF"); 
flush(s);
aps = ["AP1","AP2","AP3", "AP4","AP5"];
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


clear s
close all;
side =817; % dm floor length
width = 165; % dm floor width
matri = zeros(width,side); 
% wh = 24; % dm wall height

% router coordinates
towers = [ 70 , 85;
           70 ,297;
           128, 388;
           70 , 480;
           130 , side;];

ap1=val(1);
ap2=val(2);
ap3=val(3);
ap4=val(4);
ap5=val(5);
 

% Getting expected value of radius from calculated function
%  AP1
out=@(r) 10.^((-40.81-r)/(10*2.10));
rssi = ap1;  % RSSI reading from ESP32
distance_est_AP1 = out(rssi);
fprintf("Estimated distance from AP1 for RSSI %.1f dBm: %.2f meters\n", rssi, distance_est_AP1);

% AP2 
out=@(r) 10.^((-61.65-r)/(10*1.80));
rssi = ap2;  % RSSI reading from ESP32
distance_est_AP2 = out(rssi);
fprintf("Estimated distance from AP2 for RSSI %.1f dBm: %.2f meters\n", rssi, distance_est_AP2);

% AP3 
out=@(r) 10.^((-30.53-r)/(10*3.69));
rssi = ap3;  % RSSI reading from ESP32
distance_est_AP3 = out(rssi);
fprintf("Estimated distance from AP3 for RSSI %.1f dBm: %.2f meters\n", rssi, distance_est_AP3);

% AP4
out=@(r) 10.^((-39.59-r)/(10*1.79));
rssi = ap4;  % RSSI reading from ESP32
distance_est_AP4 = out(rssi);
fprintf("Estimated distance from AP4 for RSSI %.1f dBm: %.2f meters\n", rssi, distance_est_AP4);

% AP5
out=@(r) 10.^((-50.06-r)/(10*2.46));
rssi = ap5;  % RSSI reading from ESP32
distance_est_AP5 = out(rssi);
fprintf("Estimated distance from AP5 for RSSI %.1f dBm: %.2f meters\n", rssi, distance_est_AP5);

mdis=60;
h=10;
for i=1:width
    for j=1:side
        if (Edist(i,j,towers(1,1),towers(1,2))<distance_est_AP1*10 && distance_est_AP1<mdis)
            matri(i,j)=matri(i,j)+h;
        end
        
        if (Edist(i,j,towers(2,1),towers(2,2))<distance_est_AP2*10 && distance_est_AP2<mdis)
            matri(i,j)=matri(i,j)+h;
        end
        
        if (Edist(i,j,towers(3,1),towers(3,2))<distance_est_AP3*10 && distance_est_AP3<mdis)
            matri(i,j)=matri(i,j)+h;
        end
        
        if (Edist(i,j,towers(4,1),towers(4,2))<distance_est_AP4*10 && distance_est_AP4<mdis)
            matri(i,j)=matri(i,j)+h;
        end

        if (Edist(i,j,towers(5,1),towers(5,2))<distance_est_AP5*10 && distance_est_AP5<mdis)
            matri(i,j)=matri(i,j)+h;
        end
    end
end

hmax=0;
for i = 1:width
    for j = 1:side
        if matri(i,j)>hmax
            hmax = matri(i,j);
        end
    end
end

bin_matri=zeros(width,side);
for i = 1:width
    for j = 1:side
        if matri(i,j)~=hmax
            bin_matri(i,j)=0;
        else 
            bin_matri(i,j)=1;
        end
    end
end

% Making Walls
matri = Hline(1,1,width,matri);
matri = Hline(700,1,width,matri);
matri = Hline(side,1,width,matri);
matri = Vline(1,1,side,matri);
matri = Vline(width,1,side,matri);
lwalls = [109,144,218,255,369,406,443,555,594];
lwalls = round(lwalls);

for i=1:length(lwalls)
    matri=Hline(lwalls(i),80,165,matri);
end
    
matri = Vline(80,1,594,matri);

rwalls = [40,109,144,170,218,255,292,329,406,480,555,594,632];
rwalls = round(rwalls);

for i=1:length(rwalls)
    matri=Hline(rwalls(i),1,52,matri);
end

matri = Vline(52,1,632,matri);

matri = Vline(128,lwalls(1),lwalls(2),matri);
matri = Vline(128,lwalls(3),lwalls(4),matri);
matri = Vline(128,lwalls(5),lwalls(6),matri);
matri = Vline(128,lwalls(8),lwalls(9),matri);

% Doors and alleys

matri = Rmv(1,665,700,matri);
matri = Rmv(1,170,218,matri);
matri = Rmv(52,170,218,matri);


% Routers

th = 50;

for i=1:length(towers)
    matri(towers(i,1), towers(i,2)) = th;
    matri(towers(i,1)+1, towers(i,2)) = th;
    matri(towers(i,1)-1, towers(i,2)) = th;
    matri(towers(i,1), towers(i,2)+1) = th;
    matri(towers(i,1), towers(i,2)-1) = th;
end

stats = regionprops(bin_matri, 'Centroid');
centroid_coords = stats.Centroid;

centroid_X=round(centroid_coords(2));
centroid_y=round(centroid_coords(1));

expected_centroid=85;

disp("The centroid is at the coordinates:")
disp(num2str(centroid_X)+"  "+num2str(centroid_y))

matri(centroid_X,centroid_y) = expected_centroid;
matri(centroid_X+1,centroid_y-1) = expected_centroid;
matri(centroid_X+1,centroid_y+1) = expected_centroid;
matri(centroid_X-1,centroid_y-1) = expected_centroid;
matri(centroid_X-1,centroid_y+1) = expected_centroid;
matri(centroid_X,centroid_y-1) = expected_centroid;
matri(centroid_X,centroid_y+1) = expected_centroid;
matri(centroid_X-1,centroid_y) = expected_centroid;
matri(centroid_X-1,centroid_y) = expected_centroid;


% Plotting probable location

dist=[distance_est_AP1,distance_est_AP2,distance_est_AP3,distance_est_AP4,distance_est_AP5];
figure;
for i=1:5
    xr=towers(i,1);
    yr=towers(i,2);
    r=dist(i)*10; % dm
    if dist(i)>mdis
        continue
    end
    theta = linspace(0, 2*pi, 200);
    xc = yr + r*cos(theta);
    yc = xr + r*sin(theta);
    plot3(xc, yc, repmat(40, size(xc)), 'r-', 'LineWidth', 2);
    hold on;
end
 
surf(matri);
shading interp;
colormap(parula);  % parula
axis equal tight;
view(45, 45);
hold on;

% Necessary functions
function dis = Edist(x1,y1,x2,y2)
    dis = sqrt((x1-x2)^2+(y1-y2)^2);
end

function matri = Hline(y,x1,x2,matri)
    wh = 24;
    for i = x1:x2
        matri(i,y)=wh;
    end
end


function matri = Vline(x,y1,y2,matri)
    wh = 24;
    for i = y1:y2
        matri(x,i)=wh;
    end
end

function matri = Rmh(y,x1,x2,matri)
    for i = x1:x2
        matri(i,y)=0;
    end
end

function matri = Rmv(x,y1,y2,matri)
    for i = y1:y2
        matri(x,i)=0;
    end
end