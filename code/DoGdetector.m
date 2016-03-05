function [locsDoG, GaussianPyramid] = DoGdetector(im, sigma0, k, levels, th_contrast, th_r)

GaussianPyramid = createGaussianPyramid(im, sigma0, k, levels);
[dogPyramid, dogLevels] = createDoGPyramid(GaussianPyramid, levels);
PrincipalCurvature = computePrincipalCurvature(dogPyramid);
locsDoG = getLocalExtrema(dogPyramid, dogLevels, PrincipalCurvature, th_contrast, th_r);

imshow(rgb2gray(im));
axis image;
hold on;
plot(locsDoG(:,1), locsDoG(:,2), 'go', 'MarkerFaceColor', 'green');
hold off;
print('InterestPoints.jpg', '-djpeg');

end
