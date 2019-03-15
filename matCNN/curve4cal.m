function [ kval, val, tt ] = curve4cal( a )
     
    disp('Choose x or y as valuable. Press [enter] to end');
    val = input('','s'); 
 
    fprintf('Input %s value and Press [ENTER] to end\n', val)
    if val == 'x'
        tt = input('');
        t1 = asin(tt*sqrt(3/2));
    else
        tt = input('');
        t1 = acos(tt*sqrt(4/3));
    end
     
    kval = a(t1);
     
    t = 0:.01*pi:2*pi;
 
    x = @(t)sqrt(2/3)*sin(t);
    y = @(t)sqrt(3/4)*cos(t);
     
    plot(x(t),y(t),'--k',x(t1),y(t1),'or')
    grid on, axis equal;
    title('3/2*x^2+4/3*y^2=1')
return  
end
