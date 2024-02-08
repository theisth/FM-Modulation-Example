% Ahmet Ali Tilkicioğlu / ELEC361 Project - 2 / FM Project / 210102002163
clc
clear all

t0 = 4;                                         % 5 second variable
ts = 0.0001;                                    % sample time variable (second)  
t = 0:ts:t0-ts;                                 % 0 to 5 sec. sampled time
fs = 1/ts;                                      % sample frequency
r_df = 1;                                       % for getting integer value


kf = 50;                                        % frequency deviation constant  
w = 2;                                          % rectangular signal tao value
m = rectpuls(t-1,w) - rectpuls(t-3,w);          % m(t) signal
o = 2.*pi.*kf.*ts.*cumtrapz(m);                 % o(t) phase signal
y = 5*cos(500*pi.*t + o);                       % y(t) signal

% Demodulator Diagram

%                  z(t)         u(t)       l(t)
% y(t) ---> |d/dt| ---> |Diode| ---> |LPF| ---> |DC Blocking| ---> d_m(t)
%           

z = gradient(y,t);                              % y(t) differantial
u = abs(z);                                     % diode output (half wave)

M = fft(m);                                     % m(t) amplitude spectrum
O = fft(o);                                     % o(t) amplitude spectrum
Y = fft(y);                                     % y(t) amplitude spectrum
Z = fft(z);                                     % z(t) amplitude spectrum
U = fft(u);                                     % u(t) amplitude spectrum

df = 0.25;                                      % sampled frequency values
LPF_BW = 200;                                   % LPF bandwidth 
Max_freq = length(m);                           % Vector list lenght   

% Low Pass Filter
L = zeros(1,length(m));                                                                 
L(1:LPF_BW/df+1) = U(1:LPF_BW/df+1);                                                    
L((Max_freq-LPF_BW/df)+1:Max_freq) = U((Max_freq-LPF_BW/df)+1:Max_freq);                

l = ifft(L);                                    % inverse fourier transform

d_m = l - mean(l);                              % DC bloking 
D_M = fft(d_m);                                 % D_M(f) amplitude spectrum (Demodulated Signal)


shifted_M = abs(fftshift(M)/length(M));         % M(f) shift real frequency value
shifted_O = abs(fftshift(O)/length(O));         % O(f) shift real frequency value
shifted_Y = abs(fftshift(Y)/length(Y));         % Y(f) shift real frequency value
shifted_Z = abs(fftshift(Z)/length(Z));         % Z(f) shift real frequency value
shifted_U = abs(fftshift(U)/length(U));         % U(f) shift real frequency value
shifted_L = abs(fftshift(L)/length(L));         % L(f) shift real frequency value
shifted_D_M = abs(fftshift(D_M)/length(D_M));   % D_M(f) shift real frequency value

f = fs/length(M)*(-length(M)/2:length(M)/2-1);  % sampled all frequency values

% PLOT m(t), M(f)
figure(1)

subplot(2,1,1)
plot(t,m(1:length(t)))                      % plotting m(t)
xlabel('time (s)')
ylabel('m(t)')
title('m signal')

subplot(2,1,2)
plot(f,shifted_M)                           % plotting M(f)
xlabel('frequency (hz)')
ylabel('M(f)')
title('M spectral')

% PLOT o(t), O(f)
figure(2)

subplot(2,1,1)
plot(t,o(1:length(t)))                      % plotting o(t)
xlabel('time (s)')
ylabel('o(t)')
title('o signal')

subplot(2,1,2)
plot(f,shifted_O)                           % plotting O(f)
xlabel('frequency (hz)')
ylabel('O(f)')
title('O spectral')

% PLOT y(t), Y(f)
figure(3)

subplot(2,1,1)
plot(t,y(1:length(t)))                      % plotting y(t)
xlabel('time (s)')
ylabel('y(t)')
title('y signal')

subplot(2,1,2)
plot(f,shifted_Y)                           % plotting Y(f)
xlabel('frequency (hz)')
ylabel('Y(f)')
title('Y spectral')


% PLOT z(t), Z(f)
figure(4)

subplot(2,1,1)
plot(t,z)                                   % plotting z(t)
xlabel('time (s)')
ylabel('z(t)')
title('z signal')

subplot(2,1,2)
plot(f,shifted_Z)                           % plotting Z(f)
xlabel('frequency (hz)')
ylabel('Z(f)')
title('Z spectral')


% PLOT u(t), U(f)
figure(5)

subplot(2,1,1)
plot(t,u(1:length(t)))                      % plotting z(t)
xlabel('time (s)')
ylabel('u(t)')
title('u signal')

subplot(2,1,2)
plot(f,shifted_U)                           % plotting Y(f)
xlabel('frequency (hz)')
ylabel('U(f)')
title('U spectral')


% PLOT l(t), L(f)
figure(6)

subplot(2,1,1)
plot(t,l(1:length(t)))                      % plotting z(t)
xlabel('time (s)')
ylabel('l(t)')
title('l signal')

subplot(2,1,2)
plot(f,shifted_L)                           % plotting Y(f)
xlabel('frequency (hz)')
ylabel('L(f)')
title('L spectral')


% PLOT d_m(t), D_M(f)
figure(7)

subplot(2,1,1)
plot(t,d_m(1:length(t)))                      % plotting z(t)
xlabel('time (s)')
ylabel('d_m(t)')
title('d_m signal')

subplot(2,1,2)
plot(f,shifted_D_M)                           % plotting Y(f)
xlabel('frequency (hz)')
ylabel('D_M(f)')
title('D_M spectral')

% PLOT comparison m(t) D_M(t)

figure(8)

subplot(2,1,1)
plot(t,m(1:length(t)))                      % plotting m(t)
xlabel('time (s)')
ylabel('m(t)')
title('m signal')


subplot(2,1,2)
plot(t,d_m(1:length(t)))                    % plotting z(t)
xlabel('time (s)')
ylabel('d_m(t)')
title('d_m signal')