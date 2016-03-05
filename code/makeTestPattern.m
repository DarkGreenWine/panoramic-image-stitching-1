function [compareX, compareY] = makeTestPattern(patchWidth, nbits)

mu = patchWidth/2.0;
sigma = patchWidth/5.0;
sample = round(normrnd(mu, sigma, [nbits, 4]));
sample = max(sample, 1);
sample = min(sample, patchWidth);
compareX = sub2ind([patchWidth, patchWidth], sample(:,1), sample(:,2));
compareY = sub2ind([patchWidth, patchWidth], sample(:,3), sample(:,4));
save('testPattern.mat', 'compareX', 'compareY');

end

