%ECE320 - PROJECT 1 
%AUTHOR - AHAD AL HASSAN 
%DATE - 03/31/17

load orig11k.mat

%UPSAMPLINLG FILTER; APPLIED AFTER UPSAMPLING 
alpha_up=(1/8); 
P=65; 
hlpfu=3*alpha_up*sinc(alpha_up*(-(P-1)/2:(P-1)/2)).*(hamming(P)');

%DOWNSAMPLING FILTER; APPLIED BEFORE DOWNSAMPLING 
alpha_down=(1/10); 
P=65; 
hlpfd=alpha_down*sinc(alpha_down*(-(P-1)/2:(P-1)/2)).*(hamming(P)');

%UPSAMPLING & DOWNSAMPLING HOMER'S VOICE
%UPSAMPLING: UPSAMPLE, THEN FILTER
L_homer=8; 
M_homer=10;

x11ke=zeros(1,L_homer*length(x11k));
x11ke(1:L_homer:length(x11ke))=x11k;

%UPSAMPLE FILTER AFTER UPSAMPLING
x11ki=filter(hlpfu,1,x11ke); 
%x11ki=x11ke;

%DOWNSAMPLING: FILTER, THEN DOWNSAMPLE
x11k_filter_before_downsample=filter(hlpfd,1,x11ki);

x11kd=x11k_filter_before_downsample(1:M_homer:length(x11k_filter_before_downsample));
x8k=x11kd;

soundsc(x8k,8820); 