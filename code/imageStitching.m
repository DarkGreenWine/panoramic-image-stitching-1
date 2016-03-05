function [panoImg] = imageStitching(img1, img2, H2to1)

out_size = [750,1600];

warp_img1 = warpH(img1, eye(3), out_size);
warp_img1 = im2double(warp_img1);
warp_img2 = warpH(img2, H2to1, out_size);
warp_img2 = im2double(warp_img2);

mask1 = zeros(size(img1));
mask1(1,:) = 1; mask1(end,:) = 1; mask1(:,1) = 1; mask1(:,end) = 1;
mask1 = bwdist(mask1, 'city');
mask1 = mask1/max(mask1(:));
warp_mask1 = warpH(mask1, eye(3), out_size);

mask2 = zeros(size(img2));
mask2(1,:) = 1; mask2(end,:) = 1; mask2(:,1) = 1; mask2(:,end) = 1;
mask2 = bwdist(mask2, 'city');
mask2 = mask2/max(mask2(:));
warp_mask2 = warpH(mask2, H2to1, out_size);

panoImg = (warp_img1.*warp_mask1+warp_img2.*warp_mask2)./(warp_mask1+warp_mask2);
panoImg = im2uint8(panoImg);

end

