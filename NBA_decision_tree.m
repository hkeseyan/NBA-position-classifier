function  NBADT()
 
NBA = xlsread('NBA_playerdata_smaller.xlsx');                            % Load the data
NBA(1,:) = [];                  % row 1 is titles
NBA(400:end,:) = [];
%NBA(:,1:2) = [];                % do not need column 2
mins = NBA(:,2);                % minutes array
%NBA(:,2:3) = [];                % remove 
%NBA(:,15:16) = [];              % remove
stats = NBA(:,7:10);
%stats = stats./mins;
positions = NBA(:,1);

n = size(stats,1);                          % How many instances do we have? 
%rng(1)                                     % Seed the random number generator for reproducibility
idxTrn = false(n,1);                       % Initialize a vector of indices to a train subset
idxTrn(randsample(n,round(0.5*n))) = true; % Training set logical indices
idxVal = idxTrn == false;                  % Validation set logical indices
 
% Learn a tree ONLY on the idxTrn subset: Call it Md1, as in Model 1
Mdl = fitctree(stats(idxTrn,:),positions(idxTrn),'PredictorNames',{'TR', 'AS', 'ST', 'BK'});
 
view(Mdl,'Mode','graph')                   % Let us see the tree we learned
 
for i = 1:30
    % Classify ONLY the idxVal subset
    label = predict(Mdl,stats(idxVal,:));       % Predict (classify) the test data, on the trained model
    [label,positions(idxVal)]                    % Echo the predicted and then true labels side by side
    numMisclass(i) = sum(~strcmp(label,positions(idxVal)))  % How many did we get wrong?
end;
disp(sum(numMisclass)/30/n)
histogram(positions)
title('Decision Tree for NBA player positions')
end
