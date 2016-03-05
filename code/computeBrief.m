function [locs,desc] = computeBrief(im, GaussianPyramid, locsDoG, k, levels, compareX, compareY, patchWidth)

if nargin<8
    patchWidth = 9;
end

imageRotations = [0];
imageScalings = [1.0];
%imageRotations = 30:30:360;
%imageScalings = 0.4:0.3:1.0;
[numLocs, ~] = size(locsDoG);
locs = [];
desc = [];

for imageRotation=imageRotations
    for imageScaling=imageScalings
        effectiveImage = imrotate(imresize(im,imageScaling),imageRotation);
        [nr, nc, ~] = size(effectiveImage);
        for i=1:numLocs
            locationX = floor(locsDoG(i,2)*imageScaling);
            locationY = floor(locsDoG(i,1)*imageScaling);
            % locationL = locsDoG(i,3);
            patchRadius = ceil((patchWidth-1)/2);
            if locationX-patchRadius >= 1 && locationX+patchRadius <= nr && locationY-patchRadius >= 1 && locationY+patchRadius <= nc
                patch = effectiveImage(locationX-patchRadius:locationX+patchRadius,locationY-patchRadius:locationY+patchRadius);
                patch = patch(:);
                descriptor = patch(compareX) < patch(compareY);
                locs = [locs;locsDoG(i,:)];
                desc = [desc; descriptor'];
            end
        end
    end
end

end
