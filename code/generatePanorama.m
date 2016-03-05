function im3 = generatePanorama(im1, im2)

[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);
matches = briefMatch(desc1, desc2, 0.5);

H2to1 = ransacH(matches, locs1, locs2);
im3 = imageStitching_noClip(im1, im2, H2to1);

end

