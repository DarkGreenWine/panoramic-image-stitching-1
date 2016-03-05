function locsDoG = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature, th_contrast, th_r)

locsDoG = [];
[nr, nc, nl]= size(DoGPyramid);
localMaximumValues = zeros(nr, nc, nl);

for l=1:nl
    pyramidLevel = DoGPyramid(:,:,l);
    localMaximumValues(:,:,l) = DoGPyramid(:,:,l);
    
    for i=-1:1
        for j=-1:1
            shiftedPyramidLevel = circshift(pyramidLevel, [i j]);
            localMaximumValues(:,:,l) = bsxfun(@max, localMaximumValues(:,:,l), shiftedPyramidLevel);
        end
    end
end

localMaximumValues(:,:,1) = bsxfun(@max, localMaximumValues(:,:,1), localMaximumValues(:,:,2));
for l=2:nl-1
    localMaximumValues(:,:,l) = bsxfun(@max, localMaximumValues(:,:,l), localMaximumValues(:,:,l-1));
    localMaximumValues(:,:,l) = bsxfun(@max, localMaximumValues(:,:,l), localMaximumValues(:,:,l+1));
end
localMaximumValues(:,:,nl) = bsxfun(@max, localMaximumValues(:,:,nl), localMaximumValues(:,:,nl-1));

localMaximumCondition = (localMaximumValues==DoGPyramid)&(localMaximumValues>th_contrast)&(PrincipalCurvature<th_r);

for l=1:nl
    [rows, cols] = find(localMaximumCondition(:,:,l));
    lVector = l*ones(size(rows));
    locsDoG = [locsDoG; [cols, rows, lVector]];
end

end
