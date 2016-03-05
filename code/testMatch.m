clear;

im1 = imread('../data/pf_desk.jpg');
im2 = imread('../data/pf_pile.jpg');

[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);
matches = briefMatch(desc1, desc2);
plotMatches(im1, im2, matches, locs1, locs2);
print('../results/ImageMatchPFDeskPile.jpg', '-djpeg');