function[h,n]=firwinlpf(wc,M,winfxn)
    n=-M:1:M; 
    y=feval(winfxn,2*M+1); 
    hlpf=sin(wc.*n)./(pi.*n); 
    hlpf(M+1)=wc/pi; 
    h=y.*transpose(hlpf); 
   
end