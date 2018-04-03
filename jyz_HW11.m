close all
clear

%Load signals and basic processing ¡ý
load NoisySpeech.txt
load mtlb
Noi = NoisySpeech;
Noif = fft(Noi, 4096);
mtlbf = fft(mtlb, 4096);
wp = (2500/(Fs/2))*pi; fp = wp/pi;%pass_band
ws = (2900/(Fs/2))*pi; fs = ws/pi;%stop_band
wc = (wp + ws) / 2; fc = wc/pi;   %cutoff_band
Rp = 0.5;  %no more than 0.5 dB of ripple in a passband
As1 = 20;%at least 40 dB of attenuation in the stopband
As2 = 40;%at least 50 dB of attenuation in the stopband
As3 = 60;%at least 60 dB of attenuation in the stopband

%Determine the length of the filters¡ý
Nbutt1 = buttord(fp, fs, Rp, As1);
Nbutt2 = buttord(fp, fs, Rp, As2);
Nbutt3 = buttord(fp, fs, Rp, As3);
Ncheb11 = cheb1ord(fp, fs, Rp, As1);
Ncheb12 = cheb1ord(fp, fs, Rp, As2);
Ncheb13 = cheb1ord(fp, fs, Rp, As3);
Ncheb21 = cheb2ord(fp, fs, Rp, As1);
Ncheb22 = cheb2ord(fp, fs, Rp, As2);
Ncheb23 = cheb2ord(fp, fs, Rp, As3);
Nellip1 = ellipord(fp, fs, Rp, As1);
Nellip2 = ellipord(fp, fs, Rp, As2);
Nellip3 = ellipord(fp, fs, Rp, As3);
%Produce the filters¡ý
[Bbutt1, Abutt1] = butter(Nbutt1, fc);
[Bbutt2, Abutt2] = butter(Nbutt2, fc);
[Bbutt3, Abutt3] = butter(Nbutt3, fc);
[Bcheb11, Acheb11] = cheby1(Ncheb11, Rp, fc);
[Bcheb12, Acheb12] = cheby1(Ncheb12, Rp, fc);
[Bcheb13, Acheb13] = cheby1(Ncheb13, Rp, fc);
[Bcheb21, Acheb21] = cheby2(Ncheb21, As1, fc);
[Bcheb22, Acheb22] = cheby2(Ncheb22, As2, fc);
[Bcheb23, Acheb23] = cheby2(Ncheb23, As3, fc);
[Bellip1, Aellip1] = ellip(Nellip1, Rp, As1, fc);
[Bellip2, Aellip2] = ellip(Nellip2, Rp, As2, fc);
[Bellip3, Aellip3] = ellip(Nellip3, Rp, As3, fc);
%Frequency Response¡ý
[Hbutt1, ombutt1] = freqz(Bbutt1, Abutt1);
[Hbutt2, ombutt2] = freqz(Bbutt2, Abutt2);
[Hbutt3, ombutt3] = freqz(Bbutt3, Abutt3);
[Hcheb11, omcheb11] = freqz(Bcheb11, Acheb11);
[Hcheb12, omcheb12] = freqz(Bcheb12, Acheb12);
[Hcheb13, omcheb13] = freqz(Bcheb13, Acheb13);
[Hcheb21, omcheb21] = freqz(Bcheb21, Acheb21);
[Hcheb22, omcheb22] = freqz(Bcheb22, Acheb22);
[Hcheb23, omcheb23] = freqz(Bcheb23, Acheb23);
[Hellip1, omellip1] = freqz(Bellip1, Aellip1);
[Hellip2, omellip2] = freqz(Bellip2, Aellip2);
[Hellip3, omellip3] = freqz(Bellip3, Aellip3);
%Filtering¡ý
ybutt1 = filter(Bbutt1, Abutt1, Noi);
ybutt2 = filter(Bbutt2, Abutt2, Noi);
ybutt3 = filter(Bbutt3, Abutt3, Noi);
ycheb11 = filter(Bcheb11, Acheb11, Noi);
ycheb12 = filter(Bcheb12, Acheb12, Noi);
ycheb13 = filter(Bcheb13, Acheb13, Noi);
ycheb21 = filter(Bcheb21, Acheb21, Noi);
ycheb22 = filter(Bcheb22, Acheb22, Noi);
ycheb23 = filter(Bcheb23, Acheb23, Noi);
yellip1 = filter(Bellip1, Aellip1, Noi);
yellip2 = filter(Bellip2, Aellip2, Noi);
yellip3 = filter(Bellip3, Aellip3, Noi);

make_plot(ombutt1, Hbutt1, Abutt1, Bbutt1, 1);
disp('Check The Title To See The Property of Filter')
disp('Press Enter To See Next Plot, And Listen To Signal Filtered by It')
disp(' ')
soundsc(ybutt1, Fs)
pause
clf
make_plot(ombutt2, Hbutt2, Abutt2, Bbutt2, 2)
disp('Check The Title To See The Property of Filter')
disp('Press Enter To See Next Plot, And Listen To Signal Filtered by It')
disp(' ')
soundsc(ybutt2, Fs)
pause
clf
make_plot(ombutt3, Hbutt3, Abutt3, Bbutt3, 3)
disp('Check The Title To See The Property of Filter')
disp('Press Enter To See Next Plot, And Listen To Signal Filtered by It')
disp(' ')
soundsc(ybutt3, Fs)
pause
clf
make_plot(omcheb11, Hcheb11, Acheb11, Bcheb11, 4)
disp('Check The Title To See The Property of Filter')
disp('Press Enter To See Next Plot, And Listen To Signal Filtered by It')
disp(' ')
soundsc(ycheb11, Fs)
pause
clf
make_plot(omcheb12, Hcheb12, Acheb12, Bcheb12, 5)
disp('Check The Title To See The Property of Filter')
disp('Press Enter To See Next Plot, And Listen To Signal Filtered by It')
disp(' ')
soundsc(ycheb12, Fs)
pause
clf
make_plot(omcheb13, Hcheb13, Acheb13, Bcheb13, 6)
disp('Check The Title To See The Property of Filter')
disp('Press Enter To See Next Plot, And Listen To Signal Filtered by It')
disp(' ')
soundsc(ycheb13, Fs)
pause
clf
make_plot(omcheb21, Hcheb21, Acheb21, Bcheb11, 7)
disp('Check The Title To See The Property of Filter')
disp('Press Enter To See Next Plot, And Listen To Signal Filtered by It')
disp(' ')
soundsc(ycheb21, Fs)
pause
clf
make_plot(omcheb22, Hcheb22, Acheb22, Bcheb12, 8)
disp('Check The Title To See The Property of Filter')
disp('Press Enter To See Next Plot, And Listen To Signal Filtered by It')
disp(' ')
soundsc(ycheb22, Fs)
pause
clf
make_plot(omcheb23, Hcheb23, Acheb23, Bcheb23, 9)
disp('Check The Title To See The Property of Filter')
disp('Press Enter To See Next Plot, And Listen To Signal Filtered by It')
disp(' ')
soundsc(ycheb23, Fs)
pause
clf
make_plot(omellip1, Hellip1, Aellip1, Bellip1, 10)
disp('Check The Title To See The Property of Filter')
disp('Press Enter To See Next Plot, And Listen To Signal Filtered by It')
disp(' ')
soundsc(yellip1, Fs)
pause
clf
make_plot(omellip2, Hellip2, Aellip2, Bellip2, 11)
disp('Check The Title To See The Property of Filter')
disp('Press Enter To See Next Plot, And Listen To Signal Filtered by It')
disp(' ')
soundsc(yellip2, Fs)
pause
clf
make_plot(omellip3, Hellip3, Aellip3, Bellip3, 12)
soundsc(yellip3, Fs)
disp('Check The Title To See The Property of Filter')
pause
disp('The Program Is Over!')