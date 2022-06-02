function  CS235DT()
 
load fisheriris                            % Load the data
n = size(meas,1);                          % How many instances do we have? 
rng(1)                                     % Seed the random number generator for reproducibility
idxTrn = false(n,1);                       % Initialize a vector of indices to a train subset
idxTrn(randsample(n,round(0.5*n))) = true; % Training set logical indices
idxVal = idxTrn == false;                  % Validation set logical indices
 
% Learn a tree ONLY on the idxTrn subset: Call it Md1, as in Model 1
Mdl = fitctree(meas(idxTrn,:),species(idxTrn),'PredictorNames',{'SepalLen' ' SepalWidth' 'PetalLen' 'PetalWidth'});
 
view(Mdl,'Mode','graph')                   % Let us see the tree we learned
 
% Classify ONLY the idxVal subset
label = predict(Mdl,meas(idxVal,:));       % Predict (classify) the test data, on the trained model
[label,species(idxVal)]                    % Echo the predicted and then true labels side by side
numMisclass = sum(~strcmp(label,species(idxVal)))  % How many did we get wrong?
 
end
