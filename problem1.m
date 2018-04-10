
%part i) Plot signal and distorted signal
T = linspace(0,10,81);
y_sample = y(x(T), n(T));

figure
hold on
plot(T,x(T));
plot(T,y(x(T),n(T)));
title('Part 1: Signal and Distored Signal','fontweight','bold','fontsize',16)
legend('Origonal Signal','Distorted Signal');


figure 
hold on
plot(T,fft(x(T)))
plot(T,fft(n(T)))
legend('x', 'n')
%part ii) Recover signal using a low pass filter
y_transformed = fft(y_sample);
percent_cut = 0.075;
y_filtered = y_transformed;
y_filtered(length(y_filtered)*percent_cut:length(y_filtered)*(1-percent_cut)) = 0;
y_recover = ifft(y_filtered);


figure
hold on
subplot(2,1,1);
plot(T, y_transformed);
title('Forier Transform of Distorted Signal','fontweight','bold','fontsize',16);
subplot(2,1,2);
plot(T, y_filtered);
title('Filtered Forier Transform','fontweight','bold','fontsize',16)


figure 
hold on
subplot(2,1,1);
plot(T, real(y_recover), 'r');
title('Recovered Signal','fontweight','bold','fontsize',16)
subplot(2,1,2);
plot(T, x(T));
title('Origonal Signal','fontweight','bold','fontsize',16)


%part iii) recover using butterworth


[A,B,C,D] = butter(1,.29,'low');
hd = ss2sos(A,B,C,D)

y_butfiltr = sosfilt(hd,y_sample);


figure
hold on
plot(T,(y_butfiltr));
plot(T, x(T));
legend('Recovered Signal','Origonal Signal')


function x1 = x(T)
    x1 = 10*exp((-T.^2)/2);
end

function n1 = n(T)
    n1 = 20*cos(8*pi*T) + 2*sin(8*pi*T);
end

function y1 = y(x,n)
    y1 = x + n;
end
