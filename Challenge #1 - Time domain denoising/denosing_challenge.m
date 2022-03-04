%% Plan of work:
% 1. Median filter to denoise the spikes.
% 2. The signal is "narrow" (amplitude-wise), so mean-smooth filter may
% work the best.

clf
load denoising_codeChallenge.mat
n = length(origSignal);

% Applying median filter
median_filtsig = origSignal;

threshold = 4;
outofThreshold = find(abs(origSignal)>threshold);

k = 5; % actual loop-window is k*2+1
for i = 1:length(outofThreshold)
    lowbnd = max(1, outofThreshold(i)-k);
    uppbnd = min(outofThreshold(i)+k, n);
    median_filtsig(outofThreshold(i)) = median(origSignal(lowbnd:uppbnd));
end


% Applying mean filter
mean_filtsig = median_filtsig;
k = 140;
for j = 1:n
    lowbnd = max(1, j-k);
    uppbnd = min(n, j+k);
    mean_filtsig(j) = mean(median_filtsig(lowbnd:uppbnd));
end

% plotting the given original and filtered signal for comparison
subplot(3,1,1)
plot(origSignal, Color='k'); hold on
plot(cleanedSignal, Color='r', LineWidth=2)
title("Given Original and Filtered Signals")
legend('Original signal', 'Filtered signal')

% plotting my filtered signal after *median* filter and comparing it to the
% given filtered signal
subplot(3,1,2)
plot(median_filtsig, Color='r'); hold on
plot(cleanedSignal, Color='k', LineWidth=2)
title("My Filtered Signal (after *median* filter) Compared to Given Filtered Signal")
legend('My filtered signal', 'Given filtered signal')

% plotting my filtered signal after *mean* filter and comparing it to the
% given filtered signal
subplot(3,1,3)
plot(mean_filtsig, Color='r', LineWidth=1.5); hold on
plot(cleanedSignal, Color='k', LineWidth=1.5)
title("My Filtered Signal (after *mean* filter) Compared to Given Filtered Signal")
legend('My filtered signal', 'Given filtered signal')


