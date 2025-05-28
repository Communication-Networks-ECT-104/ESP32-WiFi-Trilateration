
% This code returns graphs of the error analysis that was conducted during the 
% testing of trilateration system. For results please refer to section 5 of the project report.


close all;
a=[
 13.5 , 62.4; % In South Block Lobby
 6.72, 53.1; % In front of second office in the corridor
 6.72, 32.05; % At the mid point of the corridor
 9.5  , 17.0; % In the corner of the new lab in front of corridor stairs
 9.6  , 52.8; % Communication Systems lab
 15.5 , 35.9 % Signal Processing lab
];

% Predicted positions
pred1=[8.5,47.1;10.8,68.5;9.9,67.4];
pred2=[7.1,48.3;9.5,23.7;10.2,25.9];
pred3=[10.3,35.8;10.5,35.2;8.1,35.6];
pred4=[8.2,12.8;8.2,12.3;8.2,12.5];
pred5=[12.0,45.2;8.9,41.4;12.6,47.7];
pred6=[12.8,38.8;12.8,38.9;12.8,38.9];

% Making a 3D array
preds = cat(3,pred1,pred2,pred3,pred4,pred5,pred6);

colors = [
    0.0000, 0.4470, 0.7410;  % Blue
    0.8500, 0.3250, 0.0980;  % Red-Orange
    0.9290, 0.6940, 0.1250;  % Yellow
    0.4940, 0.1840, 0.5560;  % Purple
    0.4660, 0.6740, 0.1880;  % Green
    0.3010, 0.7450, 0.9330;  % Cyan
];


%% X axis analysis

ax= a(:,1);
fig=figure;
fig.Position = [0 0 1000 500];

% Predictions vs actual 
subplot(1,2,1)
for i=1:length(a)
    px=squeeze(preds(:,1,i));
    scatter(ax(i), px, 80, 'filled', 'MarkerFaceColor', colors(i,:));
    hold on;
    avg=sum(px)/3;
    scatter(ax(i), avg, 80, 'x', 'MarkerEdgeColor', colors(i,:));
    hold on;
end
lims = [min(ax,[],'all')  max(ax,[],'all')];
plot(lims, lims, 'r--', 'LineWidth', 1.5);
xlabel('Actual X Coordinates (m) ');
ylabel('Predicted X Coordinate (m)');
title('Actual vs. Predicted X');
grid on;

% Errors vs Location
subplot(1,2,2);
errors=[0,0,0,0,0,0];
for i=1:length(a)
    px=squeeze(preds(:,1,i));
    avg=sum(px)/3;
    errors(i)=avg-ax(i);    
end
location={'A','B','C','D','E','F'};
b=bar(location,errors);
for k = 1:length(errors)
    b.FaceColor = 'flat';
    b.CData(k,:) = colors(k,:);
end
xlabel('Location');
ylabel('Error (m)');
title('Error vs Location');
grid on;


%% Y axis analysis

ay= a(:,2);
fig=figure;
fig.Position = [0 0 1000 500];

% Predictions vs actual 
subplot(1,2,1)
for i=1:length(a)
    py=squeeze(preds(:,2,i));
    scatter(ay(i), py, 80, 'filled', 'MarkerFaceColor', colors(i,:));
    hold on;
    avg=sum(py)/3;
    scatter(ay(i), avg, 80, 'x', 'MarkerEdgeColor', colors(i,:));
    hold on;
end
lims = [min(ay,[],'all')  max(ay,[],'all')];
plot(lims, lims, 'r--', 'LineWidth', 1.5);
xlabel('Actual Y Coordinates (m) ');
ylabel('Predicted Y Coordinate (m)');
title('Actual vs. Predicted Y');
grid on;

% Errors vs Location
subplot(1,2,2);
errors=[0,0,0,0,0,0];
for i=1:length(a)
    py=squeeze(preds(:,2,i));
    avg=sum(py)/3;
    errors(i)=avg-ay(i);    
end
location={'A','B','C','D','E','F'};
b=bar(location,errors);
for k = 1:length(errors)
    b.FaceColor = 'flat';
    b.CData(k,:) = colors(k,:);
end
xlabel('Location');
ylabel('Error (m)');
title('Error vs Location');
grid on;


%% Cluster plot

figure;
for i=1:length(a)
    px=squeeze(preds(:,1,i));
    py=squeeze(preds(:,2,i));
    scatter(px, py, 80, 'filled', 'MarkerFaceColor', colors(i,:));
    hold on;
    avgx=sum(px)/3;
    avgy=sum(py)/3;
    scatter(avgx, avgy, 80, 'x', 'MarkerEdgeColor', colors(i,:));
    hold on;
    scatter(a(i,1), a(i,2), 80, '^', 'MarkerFaceColor', colors(i,:),'MarkerEdgeColor', colors(i,:));
    hold on;
end

plot([1, 16.5], [1, 1], 'k-', 'LineWidth', 1.5);
plot([1, 16.5], [81.7, 81.7], 'k-', 'LineWidth', 1.5);
plot([1, 16.5], [70, 70], 'k-', 'LineWidth', 1.5);
plot([1, 1], [1, 81.7], 'k-', 'LineWidth', 1.5);
plot([16.5, 16.5], [1, 81.7], 'k-', 'LineWidth', 1.5);
plot([8, 8], [1, 59.4], 'k-', 'LineWidth', 1.5);
plot([5.2, 5.2], [1, 63.2], 'k-', 'LineWidth', 1.5);
plot([8, 16.5], [59.4, 59.4], 'k-', 'LineWidth', 1.5);
plot([1, 5.2], [63.2, 63.2], 'k-', 'LineWidth', 1.5);

axis equal;
set(gca, 'XDir', 'reverse')

% Add legend
h1=plot(nan, nan, 'o','Color', 'k', 'MarkerFaceColor', 'k');
h2=plot(nan, nan, 'x', 'Color', 'k');
h3=plot(nan, nan, '^', 'Color', 'k', 'MarkerFaceColor', 'k');
hLegend=legend([h1,h2,h3], {'Predicted positions', 'Avg. Prediction', 'Actual position'});
xlabel('X axis (16.5m');
ylabel('Y axis (81.7m)');
title('South Block ECE Department');
grid on;