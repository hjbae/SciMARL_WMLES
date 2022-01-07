%-----------------------------------------------------------%
% Script to plot instantaneous velocity and wall-shear      %
% stress for turbulent channel flow                         %
% Comparison between LLWM (Bae & Koumoutsakos 2022)         %
% and EQWM (Kawai & Larsson 2012)                           %
%                                                           %
% Written by Jane Bae (2021)                                %
%-----------------------------------------------------------%

%% Instantaneous snapshot for EQWM

nu = 3.000000000000000e-07;
utau = sqrt(0.00022);

rb = redblue(256);

[x,y,z,xm,ym,zm,U,V,W,nu_t] = read_field('./bin/channel5e4_AMD_EQWM.dat');

figure(1), hold on, box on
set(gca,'linewidth',1,'fontsize',18,'fontname','times')
Uplane = squeeze(0.5*(U(:,3,2:end-1)+U(:,4,2:end-1)));
Umean  = mean(mean(Uplane));
pcolor(x,zm,squeeze(Uplane-Umean)'/utau)
shading interp
axis tight
axis equal

colormap(rb)
caxis([-5 5])
colorbar

xlabel('$x/\delta$','interpreter','latex')
ylabel('$z/\delta$','interpreter','latex')

set(gca,'xtick',[0 pi 2*pi], 'xticklabel',{'$0$','$\pi$','$2\pi$'})
set(gca,'ytick',[0 pi/2 pi], 'yticklabel',{'$0$','$\pi/2$','$\pi$'})
set(gca,'TickLabelInterpreter','latex')

tauw = (nu + 0.25*(nu_t(1:end-1,1,:) + nu_t(2:end,1,:) + ...
                   nu_t(1:end-1,2,:) + nu_t(2:end,2,:) ) ) .* ...
       (U(:,2,:) - U(:,1,:)) / (2*ym(1));

figure(2), hold on, box on
set(gca,'linewidth',1,'fontsize',18,'fontname','times')
pcolor(x,zm,squeeze(tauw(:,1,2:end-1))'/utau^2)
shading interp
axis tight
axis equal

colormap(rb)
caxis([0.6 1.4])
colorbar

set(gca,'xtick',[0 pi 2*pi], 'xticklabel',{'$0$','$\pi$','$2\pi$'})
set(gca,'ytick',[0 pi/2 pi], 'yticklabel',{'$0$','$\pi/2$','$\pi$'})
set(gca,'TickLabelInterpreter','latex')

xlabel('$x/\delta$','interpreter','latex')
ylabel('$z/\delta$','interpreter','latex')


%% Instantaneous snapshot for LLWM 

nu = 3.000000000000000e-07;
utau = sqrt(0.00022);

rb = redblue(256);

[x,y,z,xm,ym,zm,U,V,W,nu_t] = read_field('./bin/channel5e4_AMD_LLWM.dat');

figure(3), hold on, box on
set(gca,'linewidth',1,'fontsize',18,'fontname','times')
Uplane = squeeze(0.5*(U(:,3,2:end-1)+U(:,4,2:end-1)));
Umean  = mean(mean(Uplane));
pcolor(x,zm,squeeze(Uplane-Umean)'/utau)
shading interp
axis tight
axis equal

colormap(rb)
caxis([-5 5])
colorbar

xlabel('$x/\delta$','interpreter','latex')
ylabel('$z/\delta$','interpreter','latex')

set(gca,'xtick',[0 pi 2*pi], 'xticklabel',{'$0$','$\pi$','$2\pi$'})
set(gca,'ytick',[0 pi/2 pi], 'yticklabel',{'$0$','$\pi/2$','$\pi$'})
set(gca,'TickLabelInterpreter','latex')

tauw = (nu + 0.25*(nu_t(1:end-1,1,:) + nu_t(2:end,1,:) + ...
                   nu_t(1:end-1,2,:) + nu_t(2:end,2,:) ) ) .* ...
       (U(:,2,:) - U(:,1,:)) / (2*ym(1));

figure(4), hold on, box on
set(gca,'linewidth',1,'fontsize',18,'fontname','times')
pcolor(x,zm,squeeze(tauw(:,1,2:end-1))'/utau^2)
shading interp
axis tight
axis equal

colormap(rb)
caxis([0.6 1.4])
colorbar

set(gca,'xtick',[0 pi 2*pi], 'xticklabel',{'$0$','$\pi$','$2\pi$'})
set(gca,'ytick',[0 pi/2 pi], 'yticklabel',{'$0$','$\pi/2$','$\pi$'})
set(gca,'TickLabelInterpreter','latex')

xlabel('$x/\delta$','interpreter','latex')
ylabel('$z/\delta$','interpreter','latex')


%% Correlation

figure(5), hold on, box on
set(gca,'linewidth',1,'fontsize',18,'fontname','times')

load mat/corr_channel5e4_AMD_eqwm_WM3_grid1.mat
x = linspace(-2*pi,2*pi,255);
plot(-x,u_tau_corr(:,64)/64/32/4,'k--','linewidth',2)

load mat/corr_channel5e4_AMD_RL_case2.mat
x = linspace(-2*pi,2*pi,255);
plot(-x,u_tau_corr(:,64)/64/32/4,'-r','linewidth',2)


xlim([-1.5 1])

xlabel('$\Delta x/\delta$','interpreter','latex')
ylabel('$R_{\tau_w^{m\prime*},u^{\prime*}}$','interpreter','latex')




