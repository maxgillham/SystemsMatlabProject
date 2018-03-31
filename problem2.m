%b)
n = linspace(-100,100,1000);
xb = cos(0.16*pi*n);
yb = dnsample(xb,4);
nb_2 = dnsample(n,4);
figure(1)
hold on
subplot(2,1,1)
plot(n,xb)
subplot(2,1,2)
plot(nb_2,yb)
hold off

%c)
xc = cos(0.8*pi*n);
yc = dnsample(xc,4);
nc_2 = dnsample(n,4);
figure(2)
hold on
subplot(2,1,1)
plot(n,xc,'b')
subplot(2,1,2)
plot(nc_2,yc,'g')
hold off

%d)
fourx_b = fft(xb);
foury_b = fft(yb);
fourx_c = fft(xc);
foury_c = fft(yc);
figure(3)
hold on 
subplot(2,2,1)
plot(fftshift(abs(fourx_b)))
title('Original Signal (b)')

subplot(2,2,2)
plot(fftshift(abs(foury_b)))
title('Down Sampled Signal (b)')

subplot(2,2,3)
plot(fftshift(abs(fourx_c)))
title('Original Signal (c)')

subplot(2,2,4)
plot(fftshift(abs(foury_c)))
title('Down Sampled Signal (c)')
hold off

%a)
function y = dnsample(x, M)

    N = length(x);
    temp = zeros(floor(N/M));
    count = 1;
    yIndexCounter = 1;
    
    for i = 1:N
        if(count == 1)
           temp(yIndexCounter) = x(i);
           yIndexCounter = yIndexCounter + 1;
        end
        count = count + 1;
        if(count == M + 1)
            count = 1;
        end
    end
    y = temp;
    
end