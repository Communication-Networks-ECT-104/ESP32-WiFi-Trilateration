
% This section is used to generate the floor plan of Ground floor, South Block of ECE department.
% All simulations done are later produced over this simulation. For detailed analysis refer to 
% section 3.2 of the project report.

close all;
side =817; % dm floor length
width = 165; % dm floor width
matri = zeros(width,side); 

towers = [ 70 , 85;
           70 ,297;
           128, 388;
           70 , 480;
           130 , side;];

% Right wall = x = 1-52
% Left wall = x = 165-80

% Making Walls
matri = Hline(1,1,width,matri); % bottom wall
matri = Hline(700,1,width,matri); % audi wall
matri = Hline(side,1,width,matri); % upper side
matri = Vline(1,1,side,matri); % right side
matri = Vline(width,1,side,matri); % left side

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