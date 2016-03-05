clear;

im1 = imread('../data/pf_floor_rot.jpg');
[locs1, desc1] = briefLite(im1);
im2 = im1(:);

imageScalings = 0.4:0.3:1.0;
imageScalingsSize = size(imageScalings,2);
matchesVector = zeros(imageScalingsSize,1);

for i=1:imageScalingsSize
    im2 = imresize(im1, imageScalings(i));
    [locs2, desc2] = briefLite(im2);
    matches = briefMatch(desc1, desc2);
    matchesVector(i) = size(matches,1);
end

barChart = bar(imageScalings, matchesVector);
xlabel('Scaling');
ylabel('Number of Matches');
saveas(gcf,'../results/EC2_ScalingError_3.jpg');