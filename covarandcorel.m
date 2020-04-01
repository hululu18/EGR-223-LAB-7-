function [covar,corel,stdX,stdY,meanX,meanY] = covarandcorel(matrixA)
%marirxA is a input argument where column 1 is X and column 2 is Y

[m,n] = size(matrixA);

column1 = matrixA(:,1); %copying the 1st column from the matrix A
column2 = matrixA(:,2); %copying the 2nd column from the matrix A

meanX = mean(column1);
meanY = mean(column2);

%calculating covariance 
covar = column1 .* column2;
covar = covar - (meanX * meanY);
covar = sum(covar);
covar = covar/(m-1);


%calculating coeff of correlation 
stdX = std(column1);
stdY = std(column2);
corel = covar/(stdX*stdY);

end