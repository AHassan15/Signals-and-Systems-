clear all; 
close all; 

%--------------------------------------------------------------------------
%3 FIR Filter Design via the Window Method 
%PART (b) START - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%declare rect. windows 
w11=rectwin(11);  
w51=rectwin(51); 
w101=rectwin(101); 
%plot rect. windows
n_11=-5:5;
n_51=-25:25;
n_101=-50:50; 
figure(1); 
subplot(3,1,1), stem(n_11,w11); 
title('FIG.1-w_{11}[n]'); 
xlabel('n-axis'); 
ylabel('output'); 
subplot(3,1,2), stem(n_51,w51); 
title('FIG.1-w_{51}[n]'); 
xlabel('n-axis'); 
ylabel('output');
subplot(3,1,3), stem(n_101,w101); 
title('FIG.1-w_{101}[n]');
xlabel('n-axis'); 
ylabel('output');
%FFTs of rect. windows 
W11=fft(w11,1024); 
W51=fft(w51,1024); 
W101=fft(w101,1024); 
%plot FFTs of rect. windows individually 
k = 0:1023; 
omega = 2*pi*k/1024; 
figure(); %figure 2 
plot(omega/pi,abs(W11)); 
title('FIG.2-|W_{11}(e^{j\Omega})|'); xlabel('\Omega/\pi (DT frequency normalized by \pi)'); ylabel('W_{11}(e^{j\Omega})'); 
grid; 
figure(); %figure 3 
plot(omega/pi,abs(W51)); 
title('FIG.3-|W_{51}(e^{j\Omega})|'); xlabel('\Omega/\pi (DT frequency normalized by \pi)'); ylabel('H_{W51}(e^{j\Omega})'); 
grid; 
figure(); %figure 4 
plot(omega/pi,abs(W101)); 
title('FIG.4-|W_{101}(e^{j\Omega})|'); xlabel('\Omega/\pi (DT frequency normalized by \pi)'); ylabel('W_{101}(e^{j\Omega})');  
grid; 
%subplot the FFTs of the windows 
figure(); %figure 5  
subplot(3,1,1), plot(omega/pi,(abs(W11))); 
grid; title('|W_{11}(e^{j\Omega})|'); xlabel('\Omega/\pi (DT frequency normalized by \pi)'); ylabel('W_{11}(e^{j\Omega})'); 
subplot(3,1,2), plot(omega/pi,(abs(W51))); 
grid; title('|W_{51}(e^{j\Omega})|'); xlabel('\Omega/\pi (DT frequency normalized by \pi)'); ylabel('W_{51}(e^{j\Omega})'); 
subplot(3,1,3), plot(omega/pi,(abs(W101))); 
grid; title('|W_{101}(e^{j\Omega})|'); xlabel('\Omega/\pi (DT frequency normalized by \pi)'); ylabel('W_{101}(e^{j\Omega})'); 
%plot all 3 rect. windows together  
figure(); %figure 6  
plot(omega/pi,abs(W11),'b-',omega/pi,abs(W51),'r--',omega/pi,abs(W101),'g-.'); 
grid; title('FIG.6-|W_{11}(e^{j\Omega})|, |W_{51}(e^{j\Omega})|, |W_{101}(e^{j\Omega})|'); xlabel('\Omega/\pi (DT frequency normalized by \pi)'); ylabel('W_{11}(e^{j\Omega}), W_{51}(e^{j\Omega}), W_{101}(e^{j\Omega})');  
legend('11pt rectwin','51pt rectwin','101pt rectwin'); 
xlim([0 0.25]); 
%plot all 3 rect. windows on a 10*log_10 scale for comparison 
figure(); %figure 7
subplot(3,1,1), plot(omega/pi,10*log10(abs(W11)));
grid; title('10*log_{10}(|W_{11}(e^{j\Omega})|)'); xlabel('\Omega/\pi (DT frequency normalized by \pi)'); ylabel('10*log_{10}(|W_{11}(e^{j\Omega})|)dB'); 
subplot(3,1,2), plot(omega/pi,10*log10(abs(W51))); 
grid; title('10*log_{10}(|W_{51}(e^{j\Omega})|)'); xlabel('\Omega/\pi (DT frequency normalized by \pi)'); ylabel('10*log_{10}(|W_{51}(e^{j\Omega})|)dB'); 
subplot(3,1,3), plot(omega/pi,10*log10(abs(W101))); 
grid; title('10*log_{10}(|W_{101}(e^{j\Omega})|)'); xlabel('\Omega/\pi (DT frequency normalized by \pi)'); ylabel('10*log_{10}(|W_{101}(e^{j\Omega})|)dB'); 

%PART (b) END - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%PART (c) START - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%lowpass filter parameters
cutoff=(pi/4);  
n_5=-5:5;
n_25=-25:25;
n_50=-50:50;  
%creating the 3 lowpass filters 
h_11=(sin((cutoff).*n_5))./(pi.*n_5);
h_11(6)=0.25; %value at zero 
h_51=(sin((cutoff).*n_25))./(pi.*n_25);
h_51(26)=0.25; 
h_101=(sin((cutoff).*n_50))./(pi.*n_50); 
h_101(51)=0.25; 
%(i)plotting the filters 
figure(); %figure 8  
subplot(3,1,1), stem(n_5,h_11,'filled');
grid; title('3(c{i}):h_{lpf_{11}}[n]'); xlabel('n-axis'); ylabel('h_{lpf_{11}}[n]'); 
subplot(3,1,2), stem(n_25,h_51,'filled'); 
grid; title('3(c{i}):h_{lpf_{51}}[n]'); xlabel('n-axis'); ylabel('h_{lpf_{51}}[n]'); 
subplot(3,1,3), stem(n_50,h_101,'filled'); 
grid; title('3(c{i}):h_{lpf_{101}}[n]'); xlabel('n-axis'); ylabel('h_{lpf_{101}}[n]'); 
%(ii)frequency response of filters 
H11=fft(h_11,1024); 
H51=fft(h_51,1024); 
H101=fft(h_101,1024); 
figure(); %figure 9  
subplot(3,1,1), plot(omega/pi,(abs(H11)));
grid; title('|H_{W11}(e^{j\Omega})|'); xlabel('\Omega/\pi (DT frequency normalized by \pi)'); ylabel('|H_{W11}(e^{j\Omega})|'); 
subplot(3,1,2), plot(omega/pi,(abs(H51))); 
grid; title('|H_{W11}(e^{j\Omega})|'); xlabel('\Omega/\pi (DT frequency normalized by \pi)'); ylabel('|H_{W51}(e^{j\Omega})|'); 
subplot(3,1,3), plot(omega/pi,(abs(H101))); 
grid; title('|H_{W11}(e^{j\Omega})|'); xlabel('\Omega/\pi (DT frequency normalized by \pi)'); ylabel('|H_{W101}(e^{j\Omega})|'); 
%(iii)discussion 

%talk about something here 

%PART (c) END - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%PART (d) START - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%(i)making the blackman windows
blackman11=blackman(11); 
blackman51=blackman(51); 
blackman101=blackman(101); 
%plotting blackman windows 
figure(); %figure 10 
subplot(3,1,1), stem(n_5,blackman11); 
grid; title('FIG.10-11pt BMW'); xlabel('n-axis'); ylabel('BMW_{11}[n]'); 
subplot(3,1,2), stem(n_25,blackman51); 
grid; title('FIG.10-51pt BMW'); xlabel('n-axis'); ylabel('BMW_{51}[n]'); 
subplot(3,1,3), stem(n_50,blackman101); 
grid; title('FIG.10-101pt BMW'); xlabel('n-axis'); ylabel('BMW_{101}[n]');  
%(ii)plot the frequency reponse of the 3 blackman windows 
%FFTs of blackman windows 
BM11=fft(blackman11,1024); 
BM51=fft(blackman51,1024); 
BM101=fft(blackman101,1024); 
%plotting FFTs of blackman windows 
figure(); %figure 11 
subplot(3,1,1), plot(omega/pi,10*log10(abs(BM11))); 
grid; title('10*log_{10}(|BMW_{11}(e^{j\Omega})|)'); xlabel('\Omega/\pi (DT frequency normalized by \pi)'); ylabel('10*log_{10}(|BMW_{11}(e^{j\Omega})|)'); 
subplot(3,1,2), plot(omega/pi,10*log10(abs(BM51))); 
grid; title('10*log_{10}(|BMW_{51}(e^{j\Omega})|)'); xlabel('\Omega/\pi (DT frequency normalized by \pi)'); ylabel('10*log_{10}(|BMW_{51}(e^{j\Omega})|)'); 
subplot(3,1,3), plot(omega/pi,10*log10(abs(BM101)));
grid; title('10*log_{10}(|BMW_{101}(e^{j\Omega})|)'); xlabel('\Omega/\pi (DT frequency normalized by \pi)'); ylabel('10*log_{10}(|BMW_{101}(e^{j\Omega})|)'); 
%(iii)%designing the lowpass filters with blackman windows 
hlpf_BMW11=transpose(blackman11).*h_11; 
hlpf_BMW51=transpose(blackman51).*h_51; 
hlpf_BMW101=transpose(blackman101).*h_101; 
%frequency response
HLPF_BMW11=fft(hlpf_BMW11,1024); 
HLPF_BMW51=fft(hlpf_BMW51,1024); 
HLPF_BMW101=fft(hlpf_BMW101,1024); 
%plotting
figure(); %figure 12 
subplot(3,1,1),plot(omega/pi,20*log10(abs(HLPF_BMW11))); 
grid; title('20*log_{10}(|H_{BMW11}(e^{j\Omega})|)'); xlabel('\Omega/\pi (DT frequency normalized by \pi)'); ylabel('20*log_{10}(|H_{BMW11}(e^{j\Omega})|)'); 
subplot(3,1,2),plot(omega/pi,20*log10(abs(HLPF_BMW51))); 
grid; title('20*log_{10}(|H_{BMW51}(e^{j\Omega})|)'); xlabel('\Omega/\pi (DT frequency normalized by \pi)'); ylabel('20*log_{10}(|H_{BMW51}(e^{j\Omega})|)'); 
subplot(3,1,3),plot(omega/pi,20*log10(abs(HLPF_BMW101))); 
grid; title('20*log_{10}(|H_{BMW101}(e^{j\Omega})|)'); xlabel('\Omega/\pi (DT frequency normalized by \pi)'); ylabel('20*log_{10}(|H_{BMW101}(e^{j\Omega})|)'); 
%(iv)

%come back to this part later when you understand the directions 

%PART (d) END - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

%PART (e) START - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 
%see script attached 

%PART (e) END - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

%PART (f) START - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
winfxn='blackman'; 
M=5; %from -5 to 5, an 11 point blackman window 
[h,n]=firwinlpf((pi/4),M,winfxn); 
figure(); %figure 13 
stem(n,h,'filled'); 
grid; title('FIG.13-firwinlpf test:\Omega_{c}=\pi/4,M=5,blackman'); xlabel('n-axis'); ylabel('h_{BMW11}[n]'); 

%PART (f) END - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%--------------------------------------------------------------------------
%//////////////////////////////////////////////////////////////////////////

%//////////////////////////////////////////////////////////////////////////
%--------------------------------------------------------------------------
%4 Design of a Bandpass and Highpass FIR Filters  
%PART (a) START - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

%see hand calculations 

%PART (a) END - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

%see hand calculations 

%PART (b) START - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

%see hand calculations 

%PART (b) END - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

%PART (c) START - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%apply the firwinlpf function 
winfxn='rectwin'; 
[h_bp,n_bp]=firwinlpf((pi/3),50,winfxn); 
figure(); %figure 14
stem(n_bp,h_bp,'filled'); 
grid; title('4(c):FIG.14-w_{101}[n]*h_{ideal_{lpf}}[n]\Omega_c=\pi/3'); xlabel('n-axis'); ylabel('h_{w_{101}}[n]'); 
%modulate by a cosine function 
h_bp_101=1*transpose(h_bp).*cos(pi*n_bp); 
%H_BP_101=fft(h_bp_101,1024); 
[mag,omega]=freqz(h_bp_101,1,1024,'whole'); 
figure(); %figure 15 
%freqz(h_bp_101,1024,'whole'); 
plot(omega/pi,abs(mag)); 
grid; title('4(c):FIG.15-|H_{HP_{W101}}(e^{j\Omega})|~\Omega_c=\pi/3,\Omega_0=\pi'); xlabel('\Omega/\pi (DT frequency normalized by \pi)'); ylabel('H_{HP_{W101}}(e^{j\Omega})'); 
%PART (c) END - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

%PART (d) START - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%(i)

%see hand calculations 

%(ii)

%see hand calculations 

%(iii)
%parameters for the firwinlpf fuction 
winfxn='rectwin'; 
cutoff=pi/5;
M=50; %for a 101 point rectwin 
[h_101_2,n_101_2]=firwinlpf(cutoff,M,winfxn); 
figure(); %figure 16
stem(n_101_2,h_101_2,'filled');
grid; title('4d(iii):w_{101}[n]*h_{ideal_{lpf}}[n]:\Omega_c=\pi/5,M=101,rectwin \Omega_c=\pi/5'); xlabel('n-axis'); ylabel('h_{w_{101}}[n]'); 
%modulate by a cosine function 
h_bp_101_2=2*transpose(h_101_2).*cos(((2*pi)/5)*n_101_2);
%H_BP_101_2=fft(h_bp_101_2,1024);
[mag,phase]=freqz(h_bp_101_2,1,1024,'whole'); 
figure(); %figure 17 
plot(phase/pi,abs(mag)); 
grid; title('4d(iii):|H_{BP_{W101}}(e^{j\Omega})|~\Omega_c=\pi/5,\Omega_0=2\pi/5'); xlabel('\Omega/\pi (DT frequency normalized by \pi)'); ylabel('H_{BP_{W101}}(e^{j\Omega})'); 
%PART (d) END - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%5 AUDIO FILTERING EXAMPLE 
%PART (a) START - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

%see analytical calculations 

%PART (a) END - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

%PART (b) START - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

%see analytical calculations 

%PART (b) START- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

%see analytical calculations 

%PART (b) END - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

%PART (c) START - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%(i)PLAY THE NOISY SIGNAL XAUDIO WITH FS 
load noisytrack.mat 
%soundsc(xaudio,fs); 
%(ii)CREATE THE FILTERS AND FILTER THE AUDIO 
%lengths for the windows
%M_han=37;
M_han=44; %new length used to meet the requirements 
M_ham=47; 
M_black=68; 
window_cutoff=0.192744*pi; 
%use the firwinlpf function 
[h_han,m_han]=firwinlpf(window_cutoff,M_han,'hanning'); 
[h_ham,m_ham]=firwinlpf(window_cutoff,M_ham,'hamming'); 
[h_black,m_black]=firwinlpf(window_cutoff,M_black,'blackman'); 
%freqz of of the impulse respnose
[han_h,han_freq]=freqz(h_han,1,8192,'whole',fs); 
[ham_h,ham_freq]=freqz(h_ham,1,8192,'whole',fs); 
[black_h,black_freq]=freqz(h_black,1,8192,'whole',fs); 

%plotting the frequency response
figure();
subplot(3,1,1), plot(han_freq,abs(han_h)); 
grid; title('5(c):FIG.-|H_{HAN}(e^{j\Omega})|'); xlabel('Frequency(Hz)'); ylabel('|H_{HAN}(e^{j\Omega})|'); 
subplot(3,1,2), plot(ham_freq,abs(ham_h)); 
grid; title('5(c):FIG.-|H_{HAM}(e^{j\Omega})|'); xlabel('Frequency(Hz)'); ylabel('|H_{HAM}(e^{j\Omega})|'); 
subplot(3,1,3), plot(black_freq,abs(black_h)); 
grid; title('5(c):FIG.-|H_{BLACK}(e^{j\Omega})|'); xlabel('Frequency(Hz)'); ylabel('|H_{BLACK}(e^{j\Omega})|'); 

%plotting the passband of each filter 
figure(); 
subplot(3,1,1),plot(han_freq,abs(han_h));
ylim([0.9900,1.010]); 
xlim([0 5000]); 
grid; title('5(c):FIG.-Passband of |H_{HAN}(e^{j\Omega})|'); xlabel('Frequency(Hz)'); ylabel('H_{HAN}(e^{j\Omega})'); 

subplot(3,1,2),plot(ham_freq,abs(ham_h)); 
ylim([0.9900,1.010]); 
xlim([0 5000]); 
grid; title('5(c):FIG.-Passband of |H_{HAM}(e^{j\Omega})|'); xlabel('Frequency(Hz)'); ylabel('H_{HAM}(e^{j\Omega})');

subplot(3,1,3),plot(black_freq,abs(black_h)); 
ylim([0.9900,1.010]); 
xlim([0 5000]); 
grid; title('5(c):FIG.-Passband of |H_{BLACK}(e^{j\Omega})|'); xlabel('Frequency(Hz)'); ylabel('H_{BLACK}(e^{j\Omega})');

%plotting the stopband 
figure(); 
subplot(3,1,1), plot(han_freq,abs(han_h)); 
xlim([4900 7000]); 
ylim([0 0.010]);
grid; title('5(c):FIG.-Stopband of |H_{HAN}(e^{j\Omega})|'); xlabel('Frequency(Hz)'); ylabel('H_{HAN}(e^{j\Omega})'); 

subplot(3,1,2), plot(ham_freq,abs(ham_h)); 
xlim([4900 7000]); 
ylim([0 0.010]);
grid; title('5(c):FIG.-Stopband of |H_{HAM}(e^{j\Omega})|'); xlabel('Frequency(Hz)'); ylabel('H_{HAM}(e^{j\Omega})');

subplot(3,1,3), plot(black_freq,abs(black_h)); 
xlim([4900 7000]); 
ylim([0 0.010]);
grid; title('5(c):FIG.-Stopband of |H_{BLACK}(e^{j\Omega})|'); xlabel('Frequency(Hz)'); ylabel('H_{BLACK}(e^{j\Omega})');

%plotting the phase 
figure(); 
subplot(3,2,1), plot(han_freq,angle(han_h)); 
grid; title('5(c):FIG.-Phase |H_{HAN}(e^{j\Omega})|'); xlabel('Frequency(Hz)'); ylabel('Phase H_{HAN}(e^{j\Omega})'); 
subplot(3,2,2), plot(han_freq,unwrap(angle(han_h))); 
grid; title('5(c):FIG.-Unwrapped Phase H_{HAN}(e^{j\Omega})'); xlabel('Frequency(Hz)'); ylabel('|H_{HAN}(e^{j\Omega})|'); 

subplot(3,2,3), plot(ham_freq,angle(ham_h)); 
grid; title('5(c):FIG.-Phase |H_{HAM}(e^{j\Omega})|'); xlabel('Frequency(Hz)'); ylabel('Phase H_{HAM}(e^{j\Omega})');
subplot(3,2,4), plot(ham_freq,unwrap(angle(ham_h))); 
grid; title('5(c):FIG.-Unwrapped Phase H_{HAM}(e^{j\Omega})'); xlabel('Frequency(Hz)'); ylabel('|H_{HAM}(e^{j\Omega})|'); 

subplot(3,2,5), plot(black_freq,angle(black_h)); 
grid; title('5(c):FIG.-Phase |H_{BLACK}(e^{j\Omega})|'); xlabel('Frequency(Hz)'); ylabel('Phase H_{BLACK}(e^{j\Omega})');
subplot(3,2,6), plot(black_freq,unwrap(angle(black_h))); 
grid; title('5(c):FIG.-Unwrapped Phase H_{BLACK}(e^{j\Omega})'); xlabel('Frequency(Hz)'); ylabel('|H_{BLACK}(e^{j\Omega})|'); 

%apply the filters 
y_han=filter(h_han,1,xaudio); 
y_ham=filter(h_ham,1,xaudio); 
y_blackman=filter(h_black,1,xaudio); 

%transform the filtered signal 
[X_han,F_han]=freqz(y_han,1,8196,'whole',fs); 
[X_ham,F_ham]=freqz(y_ham,1,8196,'whole',fs); 
[X_bmw,F_bmw]=freqz(y_blackman,1,8196,'whole',fs); 

%plot transforms 
figure(); 
subplot(3,1,1),plot(F_han,20*log10(abs(X_han))); 
grid; title('5(c)_{iii}20*log_{10}(|H_{XAUDIO_{HAN}}(e^{j\Omega})|)');
xlabel('Frequency(Hz)'); ylabel('H(e^{j\Omega}) dB'); 
subplot(3,1,2),plot(F_ham,20*log10(abs(X_ham))); 
grid; title('5(c)_{iii}20*log_{10}(|H(e^{j\Omega})|)'); 
xlabel('Frequency(Hz)'); ylabel('H(e^{j\Omega}) dB'); 
subplot(3,1,3),plot(F_bmw,20*log10(abs(X_bmw))); 
grid; title('5(c)_{iii}20*log_{10}(|H_{XAUDIO_{BMW}}(e^{j\Omega})|)'); 
xlabel('Frequency(Hz)'); ylabel('H(e^{j\Omega}) dB'); 
 
%(iii)PLOTS 
%PART (c) END - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -