function Long_Route(n)
%This is the function that will be used in the GUI when the user asks for the long route
%This code was developed with the help of the code Amaze by Cleve Moler obtained from Math Works
    %n = number of barrier nodes in a row
    %m = number of cells in one row
    %B = barriers of the graph
    %C = cells of the graph
    %c = current cell(node)
    %r = next cell(node)
    %ngh = list of neighbour cells
    %rp = random pick between all the neighbor cells
    %branches = list of nodes where a choice between more than two neighbors was made
    %storage = A list of all the cells that have been visited
    %[i,j] = "B" nodes from which the barrier in between will be eliminated

n = 15;

m=n-1; %This is the number of cells that will go in between the barriers

branching = 'middle'; %The program will follow the middle type branching, meaning it will choose the middle node from the options to travel next


Db = delsq(numgrid('S',n+2)); %This creates the 5 point discrete Laplacian that will be used to plot the barriers
B = graph(logical(Db),'omitselfloops'); %The logical function will make transform the "Db" data into binary and will plot the 1's. This plots the barriers

Dc = delsq(numgrid('S',m+2)); %This creates the 5 point discrete Laplacian that will be used to plot the cells
C = graph(logical(Dc),'omitselfloops');  %The logical function will make transform the "Dc" data into binary and will plot the 1's. This plots the nodes of the cells
    
available = 1:m^2; % All available nodes to be visited
branches = []; %This variable starts with the value of an empty matrix
storage = zeros(0,2); % List of all the nodes that have been visited, it starts as an empty matrix "[]"
c = 1; %This is the current node

%% ==================================================Show path=======================================
%This will plot all the process of the path to visit the cells, form the maze and choose the shortest path after all

[Bp,Cp] = plotboth(B,C); %This will plot the cells and barriers with the function plotboth before anything happens
        
while 1  

    available(c) = 0; 
    if ~any(available) %This if statement will break the loop if the variable "available" (cells available) is empty (equal to 0)
        break
    end

    [~,~,ngh] = find(available(neighbors(C,c))); %This looks for the neighbor cells to the current cell(node) "c"

    if ~isempty(ngh) %This if statement will ocurr while there are neighbor cells available
        rp = randi(length(ngh));  % This command will choose the next cell
        r = ngh(rp);            % Next random chosen cell or node
        if length(ngh) > 1 %This if statement will occur if a decision between two or more neighbors was made
            branches(end+1) = c; %A list of all decisions for more than two neighbors will be created
        end

        storage(end+1,:) = [c r]; %The current and next nodes are being added to the list of visited nodes
        [i,j] = wall(c,r,m); %The nodes of the wall between the current and next cells(C nodes) are recognized
        B = rmedge(B,i,j); %The barrier between the B nodes "i" and "j" are removed

            %This section here is used for the plot of what happened   
            highlight(Bp, i, j,'LineStyle', 'none'); %This will be used to plot how the barrier is removed

            highlight(Cp, c, r,'EdgeColor', cyan, ...
                'LineStyle', '-'); %This will be used to plot the movement of the worm from cell to cell

            drawnow; %This command plots all this process updating it everytime a change is made

        c = r; %The next cell "r" becomes the current one "c"

    else %This happens when a dead point is reacheched and there are no neighbors available (when all neighbor cells have been visited)

        for c = branches %We need to use the values of "branches" because a choice between two nodes was made and here a decision to go to another cell can be made
            if all(available(neighbors(C,c)) == 0) %If there are no available neighbours 
                branches(branches==c) = []; %Back tracks to the list of nodes where there was an available neighbor
            end
        end

        
        switch branching %Here another choice of node is made
            case 'first' %Goes to the first on the list
                rp = 1;
            case 'last' %Goes to the last node on the list
                rp = length(branches);
            otherwise %Goes to the middle node on the list
                rp = round(length(branches)/2);
        end

        c = branches(rp); 
        branches(rp) = [];
        
    end
end

C = graph(storage(:,1),storage(:,2)); %This value of "C" serves to plot all of the nodes of the cell
[~,Cp] = plotboth(B,C,'none'); %This is to plot the maze with only the barriers (without the nodes of the cells "C")(plotboth is a user-defined function)
path = shortestpath(C,1,m^2); %This serves to plot the path from the initial node "c=1" to the final one "c=m^2" 

%All the code down below from lines 97 to 103 is used to plot the path of the shortcut
    highlight(Cp,path, ...
        'edgecolor',cyan, ...
        'lineStyle','-', ...
        'nodecolor',cyan, ...
        'marker','o')
    highlight(Cp,[1 m^2])

        
   %% =======functions======
    
function [i,j] = wall(c,r,m) %This function will later be used to remove the barrier bewteen c and r
    switch r-  c %depending on the result of this substraction the location of the next neighbor can be found
        case -m  % the next cell is to the left of the current one
            i = c+ceil(c/m)-1; %Both these two lines select what are the value of "i" and "j" which are the node of the barrier blocking c from r
            j = i+1;           %The same happens for all the 4 cases regarding "i" and "j"
        case -1  % the next cell is on top of the current one
            i = c+ceil(c/m)-1;
            j = i+n;
        case 1  % the next cell is below the current one
            i = c+ceil(c/m);
            j = i+n;
        case m  % the next cell is to the right of the current one
            i = c+ceil(c/m)-1+n; 
            j = i+1;
    end
end

function cy  = cyan %This function is to set the color of the path, which in this case is a tone of cyan
    cy = [0 0.7 0.5];
end

function [Bp,Cp] = plotboth(B,C,Ccolor) %This function serves to plot both the barriers and the cells

    if nargin < 3 %If the number of input arguments is less than 3 the color selected will be cyan
        Ccolor = cyan;
    end
    
    if strcmp(Ccolor,'none') %If anywhere in the code the plot of C or B needs to be white or non-existent this if statement is used
        Ccolor = 'white';
        linestyle = 'none';
    else
        linestyle = '-'; %If it being white is non needed just a normal line color cyan will be plotted
    end


    k = (0:n^2-1)'; %All the lines from 143 to 150 serve to plot the variable "B" or the barriers 
    Bp = plot(B,'XData',floor(k/n), ...
        'YData',mod(n-k-1,n), ...
        'linewidth',2, ...
        'markersize',2, ...
        'nodelabel',{});
        axis equal
        set(gca,'xtick',[],'ytick',[])
        
    hold on %This will allow the cells to be plotted on top of the barriers


    k = 1:m^2; %All the lines from 155 to 162 serve to plot the variable "c" or the cells 
    Cp = plot(C,'XData',floor((k-1)/m)+0.5, ...
        'YData',mod(n-k-1,m)+0.5, ...
        'NodeLabel',{}, ...
        'NodeColor',Ccolor, ...
        'LineStyle',linestyle, ...
        'EdgeColor','white', ...
        'linewidth',3);

    hold off %This will erase the plot created if another one needs to be made
    drawnow
end 
end