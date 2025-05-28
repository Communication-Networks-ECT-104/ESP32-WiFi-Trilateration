
% This section of code uses the pathloss functions derived earlier to approximate expected value 
% of distances of device from all router. Then it plots circles to mark the region possible
% with respect to each router and then calculates the centroid of the region common between all
% expected regions. For a more detailed analysis refer to section 3.5 of the project report.


% Getting expected value of radius from trained function
%  AP1
out=@(r) 10.^((-40.81-r)/(10*2.16));
rssi = ap1;  % RSSI reading from ESP32
distance_est_AP1 = out(rssi);
fprintf("Estimated distance for RSSI %.1f dBm: %.2f meters\n", rssi, distance_est_AP1);

% AP2 
out=@(r) 10.^((-61.65-r)/(10*1.86));
rssi = ap2;  % RSSI reading from ESP32
distance_est_AP2 = out(rssi);
fprintf("Estimated distance for RSSI %.1f dBm: %.2f meters\n", rssi, distance_est_AP2);

% AP3 
out=@(r) 10.^((-30.53-r)/(10*3.69));
rssi = ap3;  % RSSI reading from ESP32
distance_est_AP3 = out(rssi);
fprintf("Estimated distance for RSSI %.1f dBm: %.2f meters\n", rssi, distance_est_AP3);

% AP4
out=@(r) 10.^((-39.59-r)/(10*1.80));
rssi = ap4;  % RSSI reading from ESP32
distance_est_AP4 = out(rssi);
fprintf("Estimated distance for RSSI %.1f dBm: %.2f meters\n", rssi, distance_est_AP4);

% AP5
out=@(r) 10.^((-50.06-r)/(10*2.52));
rssi = ap5;  % RSSI reading from ESP32
distance_est_AP5 = out(rssi);
fprintf("Estimated distance for RSSI %.1f dBm: %.2f meters\n", rssi, distance_est_AP5);

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

expected_centroid=150;

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
