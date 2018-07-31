%here we read in the file of interest, it has been placed in the working
%director labeled "MATLAB".

datamatrix = dlmread('data.txt');

%various QC metrics
%fooa = datamatrix(:,1);
%foo  = unique(fooa);
%fo = transpose(foo);

%plot of data (assuming that the data to be plotted is in the subsequent
%columns)
x=datamatrix(:,2);
y=datamatrix(:,3);
plotmatrix(x,y)

%histogram(datamatrix(:,end))

%MLE of the last column of data. This assumes that the data is in a
%standard qPCR configuration (logistic function)
mle(datamatrix(:,end), 'distribution', 'logistic')
