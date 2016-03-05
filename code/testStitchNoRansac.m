clear;

im1 = imread('../data/incline_L.png');
im2 = imread('../data/incline_R.png');

[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);
matches = briefMatch(desc1, desc2, 0.5);

p1 = locs1(matches(:,1),1:2)';
p2 = locs2(matches(:,2),1:2)';
H2to1 = computeH(p1, p2);
save('../results/q5_1.mat', 'H2to1');

panoImg = imageStitching(im1, im2, H2to1);
% imshow(panoImg);
imwrite(panoImg,'../results/q5_1.jpg','jpg');

panoImgNoClip = imageStitching_noClip(im1, im2, H2to1);
% imshow(panoImgNoClip);
imwrite(panoImgNoClip,'../results/q5_2_pan.jpg','jpg');
