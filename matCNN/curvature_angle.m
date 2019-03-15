function [output] = curvature_angle(img)
    contour=edge(img);  
    [x,y]=find(contour);
    pixels=[x,y];
    curvature=zeros(1,fix((length(pixels)-1)/20));
    for i=1:20:(fix((length(pixels)-1)/20)*20-19)
        B={pixels(i,1),pixels(i,2)};
        A={pixels(i+10,1),pixels(i+10,2)};
        C={pixels(i+20,1),pixels(i+20,2)};
        m1=(B{2}-A{2})/(B{1}-A{1});
        m2=(C{2}-A{2})/(C{1}-A{1});
        curvature(i)=abs(atand(abs((m2-m1)/(1+m1*m2))));
    end
    sumcurve=0;
    for i=1:length(curvature)
        if curvature(i)<70
            sumcurve=sumcurve+1;
        end
    end
    output=sumcurve/length(curvature);
end