%here we read in the file of interest, it has been placed in the working
%director labeled "MATLAB".

userinput2 = "'Format your input data into a 3-column, tab or space delimited, plain-text file with columns representing sample ID, cycle number, and delta Rn, respectively.\nEnsure that the number of cycles is the same for all samples or this script will not work properly.\nDo not include labels in your data file.\nSpecify absolute path with filename or relative filename (for files in this script's directory) now please:  \n";
datafile = input(userinput2,'s')
datamatrix = dlmread(datafile);
userinput1 = 'On what cycle number does the fluorescent signal exceed the background level (What is your Ct value)?\nHint: It is important that this Ct value be uniform for all samples. \n ' ;
beginoncycle = input(userinput1);
%filtering datamatrix to only include ct of interest
datamatrix2 = datamatrix(datamatrix(:,2) >= beginoncycle(1,1),:);
totaluniquesamples = size(unique(datamatrix2(:,1)),1);
totalrows = size(datamatrix2,1);
numbercyclespersample = totalrows/totaluniquesamples;
divisionmultiplier=[1:totaluniquesamples];
divisionindexes=divisionmultiplier.*numbercyclespersample;

%various QC metrics no needed unless debugging
%fooa = datamatrix(:,1);
%foo  = unique(fooa);

%histogram(datamatrix(:,end))

i = 1;
while i < (size(datamatrix2,1)-numbercyclespersample+1)
    answ(i,:) = mle(datamatrix2(i:i+numbercyclespersample-1,3),'distribution', 'logistic');
    i = i+numbercyclespersample-1;
end

%k=1;
%while k < (size(datamatrix2,1)-numbercyclespersample+1);
%    plotmatrix((datamatrix2(k:k+numbercyclespersample-1,2)),(datamatrix2(k:k+numbercyclespersample-1,3)));
%    hold on;
%    k = k+numbercyclespersample-1;
%end --- this part is unfinished

answerlist = answ(1:numbercyclespersample-1:end,1:2);
samplelist = unique(datamatrix2(:,1));
disp = 'Here are your answers. The first column is the label you started with (usually a well number). The second column is the scale parameter (alpha). The third column is the shape parameter for the logistic distribution.'
finalanswer = [samplelist answerlist]
dlmwrite('mle_output.txt', finalanswer)
