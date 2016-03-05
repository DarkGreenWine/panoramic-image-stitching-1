function [bestH] = ransacH(matches, locs1, locs2, nIter, tol)

if nargin<4
    nIter = 1000;
end

if nargin<5
    tol = 1;
end

p1 = locs1(matches(:,1),1:2)';
p2 = locs2(matches(:,2),1:2)';

numMatches = size(p1,2);
numPointsRansac = 4;

bestH = zeros(3,3);
bestInliers = -1;

for i=1:nIter
    chosenMatches = randperm(numMatches, numPointsRansac);
    p1ChosenMatches = p1(:,chosenMatches);
    p2ChosenMatches = p2(:, chosenMatches);
    H = computeH(p1ChosenMatches, p2ChosenMatches);
    
    warp_p2 = H*[p2;ones(1,numMatches)];
    lambda = warp_p2(3,:);
    den = [1;1;1]*lambda;
    warp_p2 = warp_p2 ./ den;
    warp_p2 = round(warp_p2(1:2,:));
    
    warp_errors = sqrt(sum(abs(p1-warp_p2).^2,1)) / numMatches;
    selectedIndices = warp_errors<tol;
    numInliers = sum(selectedIndices);
    
    if numInliers > bestInliers
        bestInliers = numInliers;
        % bestH = H(:,:);
        bestIndices = selectedIndices(:);
        bestH = computeH(p1(:,bestIndices), p2(:, bestIndices));
    end
    
end

end

