
%part i) Plot signal and distorted signal
T = 0:.1:40;

figure 
hold on

plot(T,x(T));
plot(T,y(x(T),n(T)));
legend('x(t)','y(t)');
%part ii) Recover using low pass 

y_sample = y(x(T), n(T));

y_transformed = fft(y_sample);

y_filtered = y_transformed;
percent_cut = .0625;
y_filtered(length(y_filtered)*percent_cut:length(y_filtered)*(1-percent_cut)) = 0;
y_recover = ifft(y_filtered);

%{
ft1 = fft(x(T))
ft2 = fft(n(T))
nyquist(ft1)
figure 
hold on
plot(T, ft1)
plot(T, ft2)
legend('forier x','forier n')
%}

figure
hold on 
plot(T, y_transformed);
plot(T, y_filtered);
legend('Forier Tansform of y(t)','Filtered Forier Transform of y(t)')
figure 
hold on
plot(T, abs(y_recover), 'r');
plot(T, x(T));
legend('Recovered signal x(t)','Original signal x(t)')

%part iii) recover using butterword

%{
[A,B] = butter(1,.05,'low');

[A,B] = butter(1,0.0625, 'low')

y_butfilt = filter(A,B,y_transformed);

y_butreco = ifft(y_butfilt);
%}

Wp = 45/200;
Ws = 1/200;

[p,W] = buttord(Wp,Ws,8,40)

[A,B,C,D] = butter(p,W);
hd = dfilt.statespace(A,B,C,D)
y_fil = y_transformed;
y_fil(length(y_fil)*percent_cut:length(y_fil)*(1-percent_cut)) = 0;

y_butfilt = filter(hd,(y_fil));
y_butreco = ifft(y_butfilt);

figure
hold on
plot(T,abs(y_butreco));
plot(T, x(T));
legend('recovered, well sorta','orignal bish')
figure 
hold on
plot(T, y_transformed)
plot(T, y_butfilt)
plot(T, y_filtered)
legend('orignal trans', 'but hurt', 'ghetto filler')


function x1 = x(T)
    x1 = 10*exp((-T.^2)/2);
end

function n1 = n(T)
    n1 = 20*cos(8*pi*T) + 2*sin(8*pi*T);
end

function y1 = y(x,n)
    y1 = x + n;
end
