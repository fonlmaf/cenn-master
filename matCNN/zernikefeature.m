function f=zernikefeature(image)  
number = 12;  
count = 1;  
%p = rgb2gray(image);  
p = logical(not(image));  
for n=0:1:12  
    for m=-12:1:12  
        temp = n-abs(m);  
        if mod(temp,2)==0&&n>=abs(m)  
            [t, a, tempp] = Zernikmoment(p,n,m);  
            r(count,1) = n;  
            r(count,2) = m;  
            f(count) = a;  
            count = count+1;  
        end  
    end  
end  