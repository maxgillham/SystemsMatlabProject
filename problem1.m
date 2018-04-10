%----------------------------%
%Part I) Plot signals x and y% 
%----------------------------%
T = linspace(0,10,81);       %since noise has frequency of 4Hz
y_sample = y(x(T), n(T));    %use sampling rate of 81 from 0 to 10

figure
hold on
plot(T,x(T));
plot(T,y(x(T),n(T)));
title('Part 1: Signal and Distored Signal','fontweight','bold','fontsize',16)
legend('Origonal Signal','Distorted Signal');


%-----------------------------------------------%
%Part II) Recover signal using a low pass filter%
%-----------------------------------------------%
y_transformed = fft(y_sample);                  %taking forier transform of the distorted signal
percent_retained = 0.075;                       %percent of frequency to be retained
y_filtered = y_transformed;                     %setting forier segments from noise equal to zero
y_filtered(length(y_filtered)*percent_retained:length(y_filtered)*(1-percent_retained)) = 0;
y_recover = ifft(y_filtered);                   %getting back denoised signal


%---------------------------------------------------%
%Part III) Plot recovered signal and origonal signal%
%---------------------------------------------------%
figure 
hold on
subplot(2,1,1);
plot(T, real(y_recover), 'r');
title('Recovered Signal From Transform','fontweight','bold','fontsize',16)
subplot(2,1,2);
plot(T, x(T));
title('Origonal Signal','fontweight','bold','fontsize',16)


%------------------------------------%
%Part IV) Recover x using butterworth%
%------------------------------------%
[A,B,C,D] = butter(1,.29,'low');     %configuring an ideal low pass 
filt = ss2sos(A,B,C,D);              %filter for distorted signal
y_butfiltr = sosfilt(filt,y_sample); %applying filter to sample 


%-------------------------------------------------%
%Part 5) Plot recovered signal and origonal signal%
%-------------------------------------------------%
figure
hold on
subplot(2,1,1);
plot(T,(y_butfiltr));
title('Recovered Signal from Ideal Filter','fontweight','bold','fontsize',16);
subplot(2,1,2);
plot(T, x(T));
title('Origonal Signal','fontweight','bold','fontsize',16);


%--------------------%
%---FUNCTIONS USED---%
%--------------------%
function x1 = x(T)   %function for x(t)
    x1 = 10*exp((-T.^2)/2);
end

function n1 = n(T)   %function for n(t)
    n1 = 20*cos(8*pi*T) + 2*sin(8*pi*T);
end

function y1 = y(x,n) %function for y(x,n)
    y1 = x + n;
end
