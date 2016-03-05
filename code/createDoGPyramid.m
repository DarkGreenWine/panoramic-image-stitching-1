function [DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels)

[nr, nc, nl]= size(GaussianPyramid);

DoGPyramid = zeros(nr, nc, nl-1);
DoGLevels = levels(2:end);

for l=1:nl-1
    DoGPyramid(:,:,l) = GaussianPyramid(:,:,l) - GaussianPyramid(:,:,l+1);
end

end