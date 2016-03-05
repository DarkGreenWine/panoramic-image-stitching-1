clear;

im1 = imread('../data/model_chickenbroth.jpg');
[locs1, desc1] = briefLite(im1);
im2 = im1(:);

imageRotations = 30:30:360;
imageRotationsSize = size(imageRotations,2);
matchesVector = zeros(imageRotationsSize,1);

for i=1:imageRotationsSize
    i
    if imageRotations(i)==0
        im2 = im1(:,:,:);
    else
        im2 = imrotate(im1, imageRotations(i));
    end
    [locs2, desc2] = briefLite(im2);
    matches = briefMatch(desc1, desc2);
    matchesVector(i) = size(matches,1);
end

barChart = bar(imageRotations, matchesVector);
xlabel('Rotation (in degrees)');
ylabel('Number of Matches');
saveas(gcf,'../results/EC2_RotationError_2.jpg');