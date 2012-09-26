function [ solution,minE,D,P,greedyDistance] = TSP(  )
% this is David Dralle's simulated annealing solution

% function [ solution,minE,D,P,greedyDistance] = TSP(  )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Iter = 1000000;

x = [1:1:19];
D = zeros(19,19);
P = [7*rand(19,1), 17*rand(19,1), 27*rand(19,1)]; %create points
for i = 1:19
    for j = 1:19  %create distance matrix
        D(i,j) = sqrt((P(i,1)-P(j,1))^2+(P(i,2)-P(j,2))^2+(P(i,3)-P(j,3))^2);
    end
end


greedy = zeros(1,19);
min = 2;
minDist = D(1,2);
greedy(1) = 1;
for i = 1:18
    for j = 1:19
        if(D(greedy(i),j) < minDist && length(find(greedy == j)) == 0)
            minDist = D(greedy(i),j);
            min = j;
        end
    end
    minDist = 100;
    greedy(i+1) = min;
end

E = 0;
for i = 1:(length(greedy)-1)
    E = E + D(greedy(i),greedy(i+1));
end

greedyDistance = E;

x = greedy;

minE = E;
T = 5;

for i = 1:1:Iter
    location = ceil(17*rand(1)+1);
    if location == 18
        oldE = D(x(location-1),x(location));
        newE = D(x(location+1),x(location-1));
    else
        oldE = D(x(location-1),x(location)) + D(x(location+1),x(location+2));
        newE = D(x(location+1),x(location-1)) + D(x(location),x(location+2));
    end
    deltaE = newE - oldE;
    Const = exp(-deltaE/T); 
    if deltaE < 0 
        temp = x(location);
        x(location)= x(location+1);
        x(location+1) = temp;
        E = E + deltaE;
        if (E < minE)
            minE = E;
            solution = x;
        end
    else
        Const = exp(-deltaE/T); 
        if (Const > rand(1))
            temp = x(location);
            x(location)= x(location+1);
            x(location+1) = temp;
            E = E + deltaE;
            if (E < minE)
                minE = E;
                solution = x;
            end
        end
    end
end


T = 3;

for i = 1:1:Iter
    location = ceil(17*rand(1)+1);
    if location == 18
        oldE = D(x(location-1),x(location));
        newE = D(x(location+1),x(location-1));
    else
        oldE = D(x(location-1),x(location)) + D(x(location+1),x(location+2));
        newE = D(x(location+1),x(location-1)) + D(x(location),x(location+2));
    end
    deltaE = newE - oldE;
    Const = exp(-deltaE/T); 
    if deltaE < 0 
        temp = x(location);
        x(location)= x(location+1);
        x(location+1) = temp;
        E = E + deltaE;
        if (E < minE)
            minE = E;
            solution = x;
        end
    else
        Const = exp(-deltaE/T); 
        if (Const > rand(1))
            temp = x(location);
            x(location)= x(location+1);
            x(location+1) = temp;
            E = E + deltaE;
            if (E < minE)
                minE = E;
                solution = x;
            end
        end
    end
end

T = 1;

for i = 1:1:Iter
    location = ceil(17*rand(1)+1);
    if location == 18
        oldE = D(x(location-1),x(location));
        newE = D(x(location+1),x(location-1));
    else
        oldE = D(x(location-1),x(location)) + D(x(location+1),x(location+2));
        newE = D(x(location+1),x(location-1)) + D(x(location),x(location+2));
    end
    deltaE = newE - oldE;
    Const = exp(-deltaE/T); 
    if deltaE < 0 
        temp = x(location);
        x(location)= x(location+1);
        x(location+1) = temp;
        E = E + deltaE;
        if (E < minE)
            minE = E;
            solution = x;
        end
    else
        Const = exp(-deltaE/T); 
        if (Const > rand(1))
            temp = x(location);
            x(location)= x(location+1);
            x(location+1) = temp;
            E = E + deltaE;
            if (E < minE)
                minE = E;
                solution = x;
            end
        end
    end
end



Path = zeros(19,3);
for i = 1:19
    Path(i,:) = P(solution(i),:);
end

%plot3(Path(:,1),Path(:,2),Path(:,3), '--rs')
    

end

