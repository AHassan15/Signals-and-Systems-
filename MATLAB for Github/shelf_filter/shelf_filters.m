%------------------------------------------------------------------------
%2: DESIGN OF A SECOND ORDER LOW-SHELF FILTER
%------------------------------------------------------------------------

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%PART A START ///////////////////////////////////////////////////////////
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
%The purpose of this part of the lab was to design the low-shelf filter. To
%see the specifics of this portion of the lab, refer to the design_shelf
%function associated with this lab. 
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%PART A END /////////////////////////////////////////////////////////////
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%PART B START ///////////////////////////////////////////////////////////
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  

%gain = 10, omega_c = 2*pi*(300); 
omega_c = 2*pi*300; 
gain_1 = 10; 

[B1,A1] = design_shelf(gain_1,omega_c,0); 
figure(1); 
pzmap(A1,B1);
title('Pole-Zero Map of Low-Shelf Filter: g=10, \omega_c=2\pi(300)'); 
grid on; 

%gain = 1, omega_c = 2*pi*(300); 
omega_c = omega_c; 
gain_2 = 0.1;

[B2,A2] = design_shelf(gain_2,omega_c,0); 
figure(2); 
pzmap(A2,B2); 
title('Pole-Zero Map of Low-Shelf Filter: g=0.1, \omega_c=2\pi(300)'); 
grid on; 

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%PART B END ///////////////////////////////////////////////////////////////
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%PART C START /////////////////////////////////////////////////////////////
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

omega = linspace(0,10000,10000); 
H1 = freqs(B1,A1,omega); 
H2 = freqs(B2,A2,omega); 

figure(3)
subplot(2,1,1), plot(omega,20*log10(abs(H1))); 
xlabel('Frequency (rad/s)');
ylabel('|H(j\omega)|');
title('Frequency Response of Low-Shelf Filter H1(j\omega) with g=10 Measured in dB', 'FontSize',9); 
grid on; 

subplot(2,1,2), plot(omega,20*log10(abs(H2))); 
xlabel('Frequency (rad/s)');
ylabel('|H(j\omega)|');
title('Frequency Response of Low-Shelf Filter H2(j\omega) with g=0.1 Measured in dB', 'FontSize',9); 
grid on; 

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%PART C END ///////////////////////////////////////////////////////////////
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%PART D START /////////////////////////////////////////////////////////////
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

%Creating 3 sinusoids  
t1 = linspace(0,.50,1000); 
sinusoid_1 = cos(2*pi*30*t1);
figure(4); 
subplot(3,1,1), plot(t1, sinusoid_1, 'r^'); 
title('sinusoid with f=30Hz'); 
xlabel('time-axis'); 
ylabel('amplitude'); 

t2 = linspace(0,0.050, 1000); 
sinusoid_2 = cos(2*pi*300*t2); 
subplot(3,1,2), plot(t2,sinusoid_2,'y^'); 
title('sinusoid with f=300Hz'); 
xlabel('time-axis'); 
ylabel('amplitude');

t3 = linspace(0,0.0050,1000); 
sinusoid_3 = cos(2*pi*3000*t3); 
subplot(3,1,3), plot(t3,sinusoid_3, 'm^'); 
title('sinusoid with f=3000Hz'); 
xlabel('time-axis'); 
ylabel('amplitude'); 

%delcaring the figure to plot the system responses 
figure(5);

%gain of 10, low-shelf filter
sys_1 = tf(B1,A1);

%gain of 0.1, low-shelf filter  
sys_2 = tf(B2,A2);

%Simulating multiple systems with different inputs and different shelf
%design parameters 
%--------------------------------------------------------------------------
%Sinusoid 1 f=30Hz 
%System reponse with a gain of 10, low-shelf filter
y_1 = lsim(sys_1,sinusoid_1,t1);  
subplot(3,2,1),plot(t1,y_1);
grid on; 
title('Filtered Sinusoidal f=30Hz with Low-Shelf g=10','FontSize',7); 
xlabel('Time-Axis', 'FontSize',7); 
ylabel('Amplitude','FontSize',7);

%Sinusoid 1 f=30Hz 
%System response with a gain of 0.1, low-shelf filter 
y_2 = lsim(sys_2,sinusoid_1,t1); 
subplot(3,2,2),plot(t1,y_2);
grid on; 
title('Filtered Sinusoidal f=30Hz 1 with Low-Shelf g=0.1','FontSize',7);
xlabel('Time-Axis','FontSize',7); 
ylabel('Amplitude','FontSize',7); 
%--------------------------------------------------------------------------
%Sinusoid 2 f=300Hz
%System response with a gain of 10, low-shelf filter 
y_3 = lsim(sys_1,sinusoid_2,t2); 
subplot(3,2,3),plot(t2,y_3);
grid on; 
title('Filtered Sinusoidal f=300Hz with Low-Shelf g=10','FontSize',7); 
xlabel('Time-Axis', 'FontSize',7); 
ylabel('Amplitude','FontSize',7); 

%Sinusoid 2 f=300Hz
%System response with a gain of 0.1, low-shelf filter 
y_4 = lsim(sys_2,sinusoid_2,t2); 
subplot(3,2,4),plot(t2,y_4);
grid on; 
title('Filtered Sinusoidal f=300Hz with Low-Shelf g=0.1','FontSize',7); 
xlabel('Time-Axis', 'FontSize',7); 
ylabel('Amplitude','FontSize',7); 

%--------------------------------------------------------------------------
%Sinusoid 3 f = 300Hz
%System response with a gain of g=10, low-shelf filter
y_5 = lsim(sys_1,sinusoid_3,t3); 
subplot(3,2,5),plot(t3,y_5);
grid on; 
title('Filtered Sinusoidal f=3000Hz with Low-Shelf g=10','FontSize',7); 
xlabel('Time-Axis', 'FontSize',7); 
ylabel('Amplitude','FontSize',7); 

%Sinusoid 3 f=300Hz
%System response with a gain of g=0.1, low-shelf filter 
y_6 = lsim(sys_2,sinusoid_3,t3); 
subplot(3,2,6),plot(t3,y_6);
grid on; 
title('Filtered Sinusoidal f=3000Hz with Low-Shelf g=0.1','FontSize',7); 
xlabel('Time-Axis', 'FontSize',7); 
ylabel('Amplitude','FontSize',7); 
%--------------------------------------------------------------------------

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%PART D END ///////////////////////////////////////////////////////////////
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

%------------------------------------------------------------------------
%3: DESIGN OF A SECOND ORDER-SHELF FILTER
%------------------------------------------------------------------------

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%PART A START ///////////////////////////////////////////////////////////
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
%This part of the lab was to design the high-shelf filter inside of the
%design shelf function; refer to that .m file to see the code/and comments 
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%PART A END /////////////////////////////////////////////////////////////
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%PART B START ///////////////////////////////////////////////////////////
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
omega_c = 2*pi*300; 
gain_1 = 10; 
gain_2 = 0.1; 

[B3,A3] = design_shelf(gain_1,omega_c,1); 
[B4,A4] = design_shelf(gain_2,omega_c,1); 

figure(6); 
pzmap(A3,B3); 
title('Pole-Zero Map of High-Shelf Filter: g=10, \omega_c=2\pi(300)'); 
grid on; 

figure(7); 
pzmap(A4,B4); 
title('Pole-Zero Map of High-Shelf Filter: g=0.1, \omega_c=2\pi(300)'); 
grid on; 

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%PART B END /////////////////////////////////////////////////////////////
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%PART C START ///////////////////////////////////////////////////////////
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
omega = linspace(0,10000,10000); 
H3 = freqs(B3,A3,omega); 
H4 = freqs(B4,A4,omega); 

figure(8);
subplot(2,1,1), plot(omega,20*log10(abs(H3))); 
xlabel('Frequency (rad/s)');
ylabel('|H(j\omega)|');
title('Frequency Response of High-Shelf Filter H3(j\omega) with g=10 Measured in dB', 'FontSize',9); 
grid on; 

subplot(2,1,2), plot(omega,20*log10(abs(H4))); 
xlabel('Frequency (rad/s)');
ylabel('|H(j\omega)|');
title('Frequency Response of High-Shelf Filter H4(j\omega) with g=0.1 Measured in dB','FontSize',9); 
grid on; 
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%PART C END /////////////////////////////////////////////////////////////
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%PART D START ///////////////////////////////////////////////////////////
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
%Systems built for high-self filter 
sys_3 = tf(B3,A3); 
sys_4 = tf(B4,A4);

figure(9); 

%Simulating multiple systems with different inputs and different shelf
%design parameters 
%------------------------------------------------------------------------
%Sinusoid 1 
%System response for high-shelf filter with gain g=10
y_7 = lsim(sys_3,sinusoid_1,t1); 
subplot(3,2,1),plot(t1,y_7); 
grid on; 
title('Filtered Sinusoidal f=30Hz with High-Shelf g=10','FontSize',6.5); 
xlabel('Time-Axis', 'FontSize',7); 
ylabel('Amplitude','FontSize',7);

%Sinusoid 1 
%System response for high-shelf filter with gain g=0.1
y_8 = lsim(sys_4,sinusoid_1,t1); 
subplot(3,2,2),plot(t1,y_8); 
grid on; 
title('Filtered Sinusoidal f=30Hz with High-Shelf g=0.1','FontSize',6.5); 
xlabel('Time-Axis', 'FontSize',7); 
ylabel('Amplitude','FontSize',7);
%------------------------------------------------------------------------
%Sinusoid 2 
%System response for high-shelf filter with gain g=10; 
y_9 = lsim(sys_3,sinusoid_2,t2); 
subplot(3,2,3),plot(t2,y_9); 
grid on; 
title('Filtered Sinusoidal f=300Hz with High-Shelf g=10','FontSize',6.5); 
xlabel('Time-Axis', 'FontSize',7); 
ylabel('Amplitude','FontSize',7);

%Sinusoid 2 
%System response for high-shelf filter with gain g=0.1; 
y_10 = lsim(sys_4, sinusoid_2,t2); 
subplot(3,2,4),plot(t2,y_10); 
grid on; 
title('Filtered Sinusoidal f=300Hz with High-Shelf g=0.1','FontSize',6.5); 
xlabel('Time-Axis', 'FontSize',7); 
ylabel('Amplitude','FontSize',7);
%------------------------------------------------------------------------
%Sinusoid 3 
%System response for high-shelf filter with gain g=10;
y_11 = lsim(sys_3,sinusoid_3,t3); 
subplot(3,2,5),plot(t3,y_11); 
grid on; 
title('Filtered Sinusoidal f=3000Hz with High-Shelf g=10','FontSize',6.5); 
xlabel('Time-Axis', 'FontSize',7); 
ylabel('Amplitude','FontSize',7);

%Sinusoid 3 
%System response for high-shelf filter with gain g=0.1;
y_12 = lsim(sys_4,sinusoid_3,t3); 
subplot(3,2,6),plot(t3,y_12); 
grid on; 
title('Filtered Sinusoidal f=3000Hz with High-Shelf g=0.1','FontSize',6.5); 
xlabel('Time-Axis', 'FontSize',7); 
ylabel('Amplitude','FontSize',7);
%------------------------------------------------------------------------

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%PART D END /////////////////////////////////////////////////////////////
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  

%------------------------------------------------------------------------
%4: MUSIC EQUALIZATION - BASS/TREBLE BOOST AND CUT 
%------------------------------------------------------------------------

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%PART A START////////////////////////////////////////////////////////////
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
load('lab6_2016.mat'); 
soundsc(bass,fs); 
soundsc(piano,fs); 
soundsc(mixture2,fs); 
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%PART A END /////////////////////////////////////////////////////////////
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%PART B START////////////////////////////////////////////////////////////
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%{
Discussion question: compare the sound of the bass with the piano and the
bass and how they sound mixed together. 
%} 
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%PART B END /////////////////////////////////////////////////////////////
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%PART C START////////////////////////////////////////////////////////////
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
win = 512; noverlap = 256; nfft = 512;
figure(10);
spectrogram(bass,win,noverlap,nfft,fs,'yaxis'); 
title('bass spectrogram'); 
%colorbar; 

figure(11); 
spectrogram(piano,win,noverlap,nfft,fs,'yaxis'); 
title('piano spectrogram'); 

figure(12); 
spectrogram(mixture2,win,noverlap,nfft,fs,'yaxis'); 
title('mixture2 spectrogram'); 

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%PART C END /////////////////////////////////////////////////////////////
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%PART D START////////////////////////////////////////////////////////////
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 
time = 1:length(mixture2);
time= time*(1/fs);

%This seems to be just right, more bass dominant
example_1 = lsim(sys_4,mixture2,time); 
soundsc(example_1,fs); 
figure(13); 
spectrogram(example_1,win,noverlap,nfft,fs,'yaxis');
title('bass slightly more dominant'); 

%{
    for the code above, we used a high shelf filter with a frequency of
    300Hz; so anything above 300Hz was attenuated by a gain factor of 0.10
%}

%For this, the piano is far too dominant 
example_2 = lsim(sys_3,mixture2,time); 
soundsc(example_2,fs);
figure(14); 
spectrogram(example_2,win,noverlap,nfft,fs,'yaxis');
title('piano too dominant'); 

%{ 
    for the code above; we applied a high-shelf filter with a frequency of
    300Hz; so this time, the gain was 10 and amplified making the piano
    very loud with intense power. 
%}

%Bass heavy  
example_3 = lsim(sys_1,mixture2,time); 
soundsc(example_3,fs);
figure(15);  
spectrogram(example_3,win,noverlap,nfft,fs,'yaxis');
title('Bass heavy'); 

%weak bass 
example_4 = lsim(sys_2,mixture2,time); 
soundsc(example_4,fs);
figure(16); 
spectrogram(example_4,win,noverlap,nfft,fs,'yaxis');
title('Weak bass'); 
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%PART D END /////////////////////////////////////////////////////////////
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%PART E START////////////////////////////////////////////////////////////
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%PART E END /////////////////////////////////////////////////////////////
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%PART F START////////////////////////////////////////////////////////////
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%soundsc(music,fs); 
figure(17); 
spectrogram(music,win,noverlap,nfft,fs,'yaxis'); 
title('Music spectrogram'); 
%colormap bone

%--------------------------------------------------------------------------
%First filter, a high pass filter to enhance the third tone 
time_music = 1:length(music);
time_music = time_music *(1/fs);  

omega_music = 2*pi*(400);  
gain_music = 10;   

[B_music,A_music] = design_shelf(gain_music,omega_music,1);
sys_music = tf(B_music,A_music);

y_music = lsim(sys_music,music,time_music); 
%soundsc(y_music,fs); 
figure(18); 
spectrogram(y_music,win,noverlap,nfft,fs,'yaxis');
%colormap bone; 
title('filtered music'); 
%--------------------------------------------------------------------------
%Second filter, a low pass filter to attenuate the other tones 
omega_music_2 = 2*pi*(420); 
gain_music_2 = 0.1; 

[B_music_2,A_music_2] = design_shelf(gain_music_2,omega_music_2,0); 
sys_music_2 = tf(B_music_2,A_music_2); 

y_music_2 = lsim(sys_music_2,y_music,time_music); 
%soundsc(y_music_2);
figure(19); 
spectrogram(y_music_2,win,noverlap,nfft,fs,'yaxis'); 
title('2nd music filter'); 
%--------------------------------------------------------------------------
% %Third filter, another low pass filter 
% omega_3 = 2*pi*(400); 
% gain_3 = 10; 
% 
% [B_3,A_3] = design_shelf(gain_3,omega_3,1); 
% sys_music_3 = tf(B_3,A_3); 
% 
% y_music_3 = lsim(sys_music_3,sys_music_2,time_music); 
% soundsc(y_music_3); 
% figure(20); 
% spectrogram(y_music_3,win,noverlap,nfft,fs,'yaxis'); 
% title('3rd music filter'); 

% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
%PART F END /////////////////////////////////////////////////////////////
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

