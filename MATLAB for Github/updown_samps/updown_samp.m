%--------------------------------------------------------------------------
%//////////////////////////////////////////////////////////////////////////
%_________________________PART 3 - UPSAMPLING______________________________
%//////////////////////////////////////////////////////////////////////////
%--------------------------------------------------------------------------
%PART (a)
n = 0:127; 
x_1 = (sinc(0.4.*(n-64))).^2; 

figure(1); 
stem(n,x_1,'filled'); 
grid; 
title('Fig 1;UPSAMPLING,(a):Plot of x_{1}[n]');
xlabel('n-axis'); 
ylabel('output'); 
xlim([54 74]);

x_2 = (sinc(0.2*(n-64))).^2; 
figure(2); 
stem(n,x_2,'filled');
grid; 
title('Fig 2;UPSAMPLING,(a):Plot of x_{2}[n]'); 
xlabel('n-axis'); 
ylabel('output');
xlim([44 84]);

%--------------------------------------------------------------------------
%//////////////////////////////////////////////////////////////////////////
%--------------------------------------------------------------------------
%PART (b)
k = 0:2047; 
wk = 2*pi*k/2048; 

X_1_K = fft(x_1,2048);
figure(3); 
plot(wk/pi,abs(X_1_K));
grid; 
title('Fig 3;UPSAMPLING,(b):FFT of x_{1}[n] for X_{1}[K]'); 
xlabel('\Omega/\pi (DT frequency normalized by \pi)'); 
ylabel('|X_{1}(e^{j\Omega})|'); 

X_2_K = fft(x_2,2048);
figure(4); 
plot(wk/pi,abs(X_2_K)); 
title('Fig 4;UPSAMPLING,(b)FFT of x_{2}[n] for X_{2}[K]');
xlabel('\Omega/\pi (DT frequency normalized by \pi)'); 
ylabel('|X_{2}(e^{j\Omega})|'); 
grid; 

%--------------------------------------------------------------------------
%//////////////////////////////////////////////////////////////////////////
%--------------------------------------------------------------------------
%PART (c)
L=3; 
xe_1=zeros(1,L*length(x_1)); 
xe_1(1:L:length(xe_1))=x_1; 

XE_1_K=fft(xe_1,2048); 
figure(5); 
plot(wk/pi,abs(XE_1_K));
grid; 
title('Fig 5;UPSAMPLING,(c)Upsampled X_{1}[K], X_{E_{1}}[K]'); 
xlabel('\Omega/\pi (DT frequency normalized by \pi)'); 
ylabel('|X_{E_1}(e^{j\Omega})|'); 

xe_2=zeros(1,L*length(x_2)); 
xe_2(1:L:length(xe_2))=x_2; 

XE_2_K=fft(xe_2,2048); 
figure(6);
plot(wk/pi,abs(XE_2_K));
grid; 
title('Fig 6;UPSAMPLING,(c):Upsampled X_{2}[k], X_{E_{2}}[K]');
xlabel('\Omega/\pi (DT frequency normalized by \pi)'); 
ylabel('|X_{E_2}(e^{j\Omega})|'); 

%--------------------------------------------------------------------------
%//////////////////////////////////////////////////////////////////////////
%--------------------------------------------------------------------------
%PART (d)
%FILTER CREATION FOR UPSAMPLING
alpha=(1/3); 
P=65; 
hlpf=3*alpha*sinc(alpha*(-(P-1)/2:(P-1)/2)).*(hamming(P)'); 


%filter impulse response for upsampling
hlpf_impulse = impz(hlpf,1); 
figure(7);
stem(hlpf_impulse,'filled','o'); 
grid;
title('Fig 7;UPSAMPLING,(d):Filter Impulse Response');
xlabel('n-axis'); 
ylabel('output'); 

%filter frequency response for upsampling
figure(8); 
HLPF_IMPULSE_K=fft(hlpf_impulse,2048);
plot(wk/pi,abs(HLPF_IMPULSE_K)); 
title('Fig 8;UPSAMPLING,(d):Frequency Response of HLPF');
xlabel('\Omega/\pi (DT frequency normalized by \pi)'); 
ylabel('|H_{filter}(e^{j\Omega})|'); 
grid; 

%--------------------------------------------------------------------------
%//////////////////////////////////////////////////////////////////////////
%--------------------------------------------------------------------------
%PART (e)
%upsample, then apply the upsampling filter for anti-aliasing
xi_1 = filter(hlpf,1,xe_1); 
XI_1_K = fft(xi_1,2048); 
figure(9); 
plot(wk/pi,abs(XI_1_K)); 
grid;
title('Fig 9;UPSAMPLING,(e):Filtered x_{e_{1}}[n] for Interpolated x_{i_{1}}[n] FFT X_{i_1}[K]');
xlabel('\Omega/\pi (DT frequency normalized by \pi)'); 
ylabel('|X_{i_1}(e^{j\Omega})|'); 

%don't need to do this part, but it's ok
xi_2 = filter(hlpf,1,xe_2);
XI_2_K=fft(xi_2,2048); 
figure(10); 
plot(wk/pi,abs(XI_2_K));
grid; 
title('Fig 10;UPSAMPLING,(e):Filtered x_{e_{2}}[n] for Interpolated x_{i_{2}}[n] FFT X_{i_2}[K]'); 
xlabel('\Omega/\pi (DT frequency normalized by \pi)'); 
ylabel('|X_{i_2}(e^{j\Omega})|'); 
%--------------------------------------------------------------------------
%//////////////////////////////////////////////////////////////////////////
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%//////////////////////////////////////////////////////////////////////////
%________________________PART 4 - DOWNSAMPLING_____________________________
%//////////////////////////////////////////////////////////////////////////
%--------------------------------------------------------------------------
%PART(a)

%refer to analytical calculations 

%--------------------------------------------------------------------------
%//////////////////////////////////////////////////////////////////////////
%--------------------------------------------------------------------------
%PART(b)
M=2; 
xd_1=x_1(1:M:length(x_1)); 
xd_2=x_2(1:M:length(x_2)); 

XD_1_K=fft(xd_1,2048);
figure(11); 
plot(wk/pi,abs(XD_1_K));
grid; 
title('Fig 11;DOWNSAMPLING,(b):Downsampled x_{1}[n] by M=2 FFT X_{d_1}[K]');
xlabel('\Omega/\pi (DT frequency normalized by \pi)'); 
ylabel('|X_{d_1}(e^{j\Omega})|'); 

XD_2_K=fft(xd_2,2048);
figure(12); 
plot(wk/pi,abs(XD_2_K));
grid; 
title('Fig 12;DOWNSAMPLING,(b):Downsampled x_{2}[n] by M=2 FFT X_{d_2}[K]');
xlabel('\Omega/\pi (DT frequency normalized by \pi)'); 
ylabel('|X_{d_2}(e^{j\Omega})|'); 
%--------------------------------------------------------------------------
%//////////////////////////////////////////////////////////////////////////
%--------------------------------------------------------------------------
%PART(c)
alpha_2=(1/2); 
P=65; 
hlpf_2=alpha_2*sinc(alpha_2*(-(P-1)/2:(P-1)/2)).*(hamming(P)'); 

fx_1=filter(hlpf_2,1,x_1); 
dfx_1=fx_1(1:M:length(fx_1));
DFX_1_K=fft(dfx_1,2048);
figure(13); 
plot(wk/pi,abs(DFX_1_K)); 
grid; 
title('Fig 13;DOWNSAMPLING,(c):Anti-Alias Filter to x_1[n] then Downsampled then abs(X_1[K])','FontSize',9.5);
xlabel('\Omega/\pi (DT frequency normalized by \pi)'); 
ylabel('|X_{d_1_{anti-alias filter}}(e^{j\Omega})|'); 

%--------------------------------------------------------------------------
%//////////////////////////////////////////////////////////////////////////
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%//////////////////////////////////////////////////////////////////////////
%_________PART 5 - CHANGING THE SAMPLE RATE OF AN AUDIO SIGNAL_____________
%//////////////////////////////////////////////////////////////////////////
%--------------------------------------------------------------------------
%PART(a)

%take 11025 and multiply it by upsample it by 8
%then take that, and downsample by 10
%the final result will take you from 11025 to 8820

%--------------------------------------------------------------------------
%//////////////////////////////////////////////////////////////////////////
%--------------------------------------------------------------------------
%PART(b)

%{
        No, the order doesn't matter. It doesn't matter if you upsample or
    downsample first. Taking 11025 and upsampling by 8, then downsampling
    by 10 produces the same result as downsampling by 10, then upsampling
    by 8. 
 %} 

%--------------------------------------------------------------------------
%//////////////////////////////////////////////////////////////////////////
%--------------------------------------------------------------------------
%PART(c)

%--------------------------------------------------------------------------
%//////////////////////////////////////////////////////////////////////////
%--------------------------------------------------------------------------
%PART(d)
%UPSAMPLINLG FILTER; APPLIED AFTER UPSAMPLING 
alpha_up=(1/8); 
P_up=65; 
hlpfu=alpha_up*sinc(alpha_up*(-(P-1)/2:(P-1)/2)).*(hamming(P)');

%IMPULSE RESPONSE 
hlpfu_impulse=impz(hlpfu,1);
figure(14); 
stem(hlpfu_impulse,'filled','o'); 
title('Fig 14;AUDIO,(d):Impulse Response of HLPF_{upsampling}'); 
xlabel('n-axis'); 
ylabel('output'); 
grid;

%FREQUENCY RESPONSE
HLPFU_K=fft(hlpfu_impulse,2048);
figure(15); 
plot(wk/pi,abs(HLPFU_K));
title('Fig 15;AUDIO,(d):Frequency Response of HLPF_{upsample}');
xlabel('\Omega/\pi (DT frequency normalized by \pi)'); 
ylabel('|H_{upsampling}(e^{j\Omega})|'); 
grid; 

%DOWNSAMPLING FILTER; APPLIED BEFORE DOWNSAMPLING 
alpha_down=(1/10); 
P_down=65; 
hlpfd=alpha_down*sinc(alpha_down*(-(P-1)/2:(P-1)/2)).*(hamming(P)');

%IMPULSE RESPONSE
hlpfd_impulse=impz(hlpfd,1); 
figure(16); 
stem(hlpf_impulse,'filled','o');
grid; 
title('Fig 16;AUDIO,(d):Impulse Response of HLPF_{downsampling}');
xlabel('n-axis'); 
ylabel('output'); 

%FREQUENCY RESPONSE
HLPFD_K=fft(hlpfd_impulse,2048);
figure(17); 
plot(wk/pi,abs(HLPFD_K));
title('AUDIO,(d):Frequency Response of HLPF_{downsampling}');
xlabel('\Omega/\pi (DT frequency normalized by \pi)'); 
ylabel('|H_{downsampling}(e^{j\Omega})|'); 
grid; 

%UPSAMPLING & DOWNSAMPLING HOMER'S VOICE
%UPSAMPLING: UPSAMPLE, THEN FILTER
L_homer=8; 
M_homer=10;

x11ke=zeros(1,L_homer*length(x11k));
x11ke(1:L_homer:length(x11ke))=x11k;

x11ki=filter(hlpfu,1,x11ke); 

%DOWNSAMPLING: FILTER, THEN DOWNSAMPLE
x11k_filter_before_downsample=filter(hlpfd,1,x11ki);

x11kd=x11k_filter_before_downsample(1:M_homer:length(x11k_filter_before_downsample));
x8k=x11kd;

%--------------------------------------------------------------------------