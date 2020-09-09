clc
clear all
close all

%%  Load Dataset
load templateProjection.mat
residue= zeros(size(EEGdat)); %initialize residual data

for trial_i=1:size(residue,2)
    X=[ones(npnts,1) eyedat(:,trial_i)];
    b=(X'*X)\(X'*EEGdat(:,trial_i));  %compute regression coefficients for EEG channel 
    yHat=X*b; %predicted data
    
    %new data are the residuals after projecting out the best EKG fit
    residue(:,trial_i)=(EEGdat(:,trial_i)-yHat)';
end

%% Plotting
plot(timevec,mean(eyedat,2))
hold on
plot(timevec,mean(EEGdat,2))
hold on
plot(timevec,mean(residue,2))
legend('Artifact(EOG)','Data Channel(EEG)','Residue')
xlabel('Time')
title('Artifact removal')

%show all trials in a map
figure
subplot(1,3,1)
imagesc(timevec,[],eyedat)
title('Artifact(EOG)')
subplot(1,3,2)
imagesc(timevec,[],EEGdat)
title('Data Channel(EEG)')
subplot(1,3,3)
imagesc(timevec,[],residue)
title('Residue')