function [panoImg] = imageStitching_noClip(img1, img2, H2to1)

out_size = [750,3000];
[nr, nc, ~] = size(img2);
img2Corners = [1,1,1;nc,1,1;1,nr,1;nc,nr,1];
img2CornerTransform = (H2to1*img2Corners')';
lambda = img2CornerTransform(:,3);
img2CornerTransform = img2CornerTransform ./ (lambda*[1,1,1]);

panoWidth = max(max(img2CornerTransform(:,1)), size(img1,2)) - min(min(img2CornerTransform(:,1)), 1);
panoHeight = max(max(img2CornerTransform(:,2)), size(img1,1)) - min(min(img2CornerTransform(:,2)), 1);
scaleFactor = out_size(2)/panoWidth;
out_size(1) = round(scaleFactor*panoHeight);

panoWidthTranslation = abs(min(min(img2CornerTransform(:,1)), 0)) ;
panoHeightTranslation = abs(min(min(img2CornerTransform(:,2)), 0));

M = [scaleFactor, 0, panoWidthTranslation * scaleFactor;
    0, scaleFactor, panoHeightTranslation * scaleFactor;
    0, 0, 1];
H2to1 = M*H2to1;

warp_img1 = warpH(img1, M, out_size);
warp_img1 = im2double(warp_img1);
warp_img2 = warpH(img2, H2to1, out_size);
warp_img2 = im2double(warp_img2);

mask1 = zeros(size(img1));
mask1(1,:) = 1; mask1(end,:) = 1; mask1(:,1) = 1; mask1(:,end) = 1;
mask1 = bwdist(mask1, 'city');
mask1 = mask1/max(mask1(:));
warp_mask1 = warpH(mask1, M, out_size);

mask2 = zeros(size(img2));
mask2(1,:) = 1; mask2(end,:) = 1; mask2(:,1) = 1; mask2(:,end) = 1;
mask2 = bwdist(mask2, 'city');
mask2 = mask2/max(mask2(:));
warp_mask2 = warpH(mask2, H2to1, out_size);

panoImg = (warp_img1.*warp_mask1+warp_img2.*warp_mask2)./(warp_mask1+warp_mask2);
panoImg = im2uint8(panoImg);

end
