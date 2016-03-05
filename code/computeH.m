function H2to1 = computeH(p1,p2)

x2=p1(1,:)';
y2=p1(2,:)';
x1=p2(1,:)';
y1=p2(2,:)';

x1x2 = x1.*x2;
x2y1 = x2.*y1;
x1y2 = x1.*y2;
y1y2 = y1.*y2;
z = zeros(size(x1));
o = ones(size(x1));

A1 = [x1, y1, o, z, z, z, -x1x2, -x2y1, -x2];
A2 = [z, z, z, x1, y1, o, -x1y2, -y1y2, -y2];
A = [A1;A2];

[~,~,V] = svd(A);
h = V(:,end);
H2to1 = vec2mat(h,3);

end

