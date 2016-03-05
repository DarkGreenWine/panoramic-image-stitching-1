clear;

im1 = imread('../data/incline_L.png');
im2 = imread('../data/incline_R.png');

[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);
matches = briefMatch(desc1, desc2, 0.5);

H2to1 = ransacH(matches, locs1, locs2);
save('../results/q6_1.mat', 'H2to1');

panoImg = imageStitching(im1, im2, H2to1);
imshow(panoImg);
imwrite(panoImg,'../results/q6_1.jpg','jpg');

panoImgNoClip = imageStitching_noClip(im1, im2, H2to1);
imshow(panoImgNoClip);
imwrite(panoImgNoClip,'../results/q6_2_pan.jpg','jpg');
