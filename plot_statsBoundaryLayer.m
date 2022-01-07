%-----------------------------------------------------------%
% Script to plot skin friction (Cf) for boundary layer flow %
% Using LLWM (Bae & Koumoutsakos 2022)                      %
%                                                           %
% Written by Jane Bae (2021)                                %
%-----------------------------------------------------------%

% Load data
load('mat/bl_retheta1000_6000_AMD_RL.mat')

figure(1), hold on, box on
set(gca,'linewidth',0.5,'fontsize',10,'fontname','times')
cc = [0, 0.4470, 0.7410];

% Compute relevant quantities
Rex         = x/nu;
theta_x_a   = 0.016*Rex.^(-1/7);
Retheta_a   = theta_x_a.*x*Uinf/nu;
Cf_a        = 0.059*Rex.^(-1/5); 

% Plot model Cf
plot(Retheta_a(1:40:end),10^3*Cf(1:40:end),'o','color',cc,'linewidth',1)

% Plot empirical Cf
plot(Retheta_a(1:40:end), 10^3*Cf_a(1:40:end),'k--','linewidth',1)

pbaspect([4 1 1])

xlim([1000 7000])
ylim([2.4 5.2])

xlabel('$Re_\theta$','interpreter','latex')
ylabel('$10^3C_f$','interpreter','latex')
