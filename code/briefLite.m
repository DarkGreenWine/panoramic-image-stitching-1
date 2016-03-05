function [locs, desc] = briefLite(im)

load('parameters.mat');
load('testPattern.mat');

[locsDoG, GaussianPyramid] = DoGdetector(im, sigma0, k, levels, th_contrast, th_r);
[locs, desc] = computeBrief(im, GaussianPyramid, locsDoG, k, levels, compareX, compareY);

end
