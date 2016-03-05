clear;

im1 = imread('../data/model_chickenbroth.jpg');
im2 = im1(:);

[locs1, desc1] = briefLite(im1);
matchesVector = zeros(36,1);

for i=0:35
    im2 = imrotate(im1, 10*i);
    [locs2, desc2] = briefLite(im2);
    matches = briefMatch(desc1, desc2);
    matchesVector(i+1) = size(matches,1);
end

barChart = bar(10*[0:35], matchesVector);
xlabel('Rotation (in degrees)');
ylabel('Number of Matches');
saveas(gcf,'RotationError_EC1.jpg');