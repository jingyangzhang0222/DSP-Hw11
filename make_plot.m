function[] = make_plot(om, H, A, B, i)
As = [20,40,60,20,40,60,20,40,60,20,40,60];
subplot(3,1,1)
plot(om/pi, abs(H))
if 1<=i && i <=3
    title(['Frequency Response of The Butter Filter, As = ',num2str(As(i)),'dB']);
elseif 4<=i && i <=6
    title(['Frequency Response of The Chebyshev I Filter, As = ',num2str(As(i)),'dB']);
elseif 7<=i && i <=9
    title(['Frequency Response of The Chebyshev II Filter, As = ',num2str(As(i)),'dB']);
elseif 10<=i && i <=12
    title(['Frequency Response of The Elliptic Filter, As = ',num2str(As(i)),'dB']);
end
grid on;ylim([-0.1 1.1])
xlabel('\omega/\pi');ylabel('|A(\omega)|')
subplot(3,1,2)
zplane(B, A)
title('Pole-Zero Diagram');
subplot(3,1,3)
stem(0:19, abs(filter(B, A,[1,zeros(1,19)])), '.')
title('Impulse Response')
xlabel('n');ylabel('h(n)');xlim([-0.5, 19.5]);