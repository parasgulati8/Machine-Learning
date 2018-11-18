load data3.mat
[Theta, Iterations] = perceptron1(data);
function [theta, mistakes] = perceptron1(Data)
%PERCEPTRON function calculates the optimum theta and the number of
%iterations it took to reach the optimum
theta = rand(1,3)' ;
t = 1;
y = Data(:,3);
x = [ones(200,1) Data(:,[1 2])];
xmc = [];
ymc = [];
ErrVector = [];
thetaMod = 10;
R = [];
while (thetaMod > 0.001)
     temp = theta;
     xmc = [];
     ymc = [];
% Code to find the misclassified data and calculating the Risk corresponding to it in interation t
for i = 1:length(Data)
        if(y(i) * (x(i,:) * theta) <= 0)
            xmc = [xmc; x(i,:)];
            ymc = [ymc; y(i)];
        end
end
if size(xmc) > 0
    R(t) = (-1/length(ymc))*sum(ymc .* (xmc * theta));
end
%------------------------------------------%
% To find the next theta value for the misclassified data--------
for i = 1:length(Data)
        if(y(i) * (x(i,:) * theta) <= 0)
            theta = theta + (y(i) .* x(i,:)');
        end 
end
%-------------------------------
% Calculating the modulus of difference between previous and next theta 
thetaMod = theta-temp; thetaMod = thetaMod .^ 2; thetaMod = sqrt(sum(thetaMod));

% Binary classifiction error calculated for iteration t
err = 0;
for i = 1:length(Data)
   if (-y(i) * (x(i,:) * theta)) > 0
       err = err + 1;
   else
       err = err + 0;
   end
end
ErrVector(t) = err;
% -------------------------------------
t = t+1;
end
mistakes = t;
% plotting the Perceptron error with the iterations
plot(1:length(R), R);
title('Perceptron Error');
% ------------------
% PLotting below the Linear Decision Boundary on the 2d x data
figure;
A = -(theta(2)/theta(3)) * x(:,2) - (theta(1)/theta(3));  
B = x(:,2);
plot(A,B, '.');
hold on
plot (x(:,3), x(:,2), 'x');
title('Decision Boundary');
%------------------------------------------------------------
%plotting the Classification error
figure;
plot (1:length(ErrVector), ErrVector);
title('Binary Classification Error');
% -------------------------------------------------------------
end