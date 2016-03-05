function [PrincipalCurvature] = computePrincipalCurvature(DoGPyramid)
    
[nr, nc, nl]= size(DoGPyramid);
PrincipalCurvature = zeros(nr, nc, nl);

for l=1:nl
    [gradX, gradY] = gradient(DoGPyramid(:,:,l));
    [gradXX, gradXY] = gradient(gradX);
    [gradYX, gradYY] = gradient(gradY);
    num = ((gradXX + gradYY).^2);
    den = ((gradXX.*gradYY)-(gradXY.*gradYX));
    PrincipalCurvature(:,:,l) = num ./ den;
end

end