%-----------------------------------------------------------%
% Script to plot statistics (error and mean velocity        %
% profile) for turbulent channel flow using VWM and LLWM    %
% (Bae & Koumoutsakos 2022)                                 %
%                                                           %
% Written by Jane Bae (2021)                                %
%-----------------------------------------------------------%


close all
figure(1), hold on, box on
set(gca,'linewidth',1,'fontsize',18,'fontname','times')

colors = [[0, 0.4470, 0.7410];...
    [0.8500, 0.3250, 0.0980];...
    [0.9290, 0.6940, 0.1250];...
    [0.4660, 0.6740, 0.1880];...
    [0.4940, 0.1840, 0.5560];...
    [0.6350, 0.0780, 0.1840]];


Res = {'5000','1e4','2e4','2e4_g2','5e4','5e4_g2','1e5','1e6'};
colori = [1 2 3 3 4 4 5 6];
marker = {'o', 'o', 'o', 'x', 'o', 'x','o','o'};

for iRe = 1:8
    
    load(['./mat/channel',Res{iRe},'_AMD_RL_case2.mat']);
    
    nyg = length(yg);
    plot(yg(1:nyg/2)*utau_o/nu,Umean(1:nyg/2)/utau,marker{iRe},...
        'color',colors(colori(iRe),:),'linewidth',2,'markersize',8,...
        'markerfacecolor','w')
    
end

ylim([15,45])
xlim([100 1.2e6])
set(gca,'xscale','log')
plot(10.^(1:0.1:6.2),1/0.41*log(10.^(1:0.1:6.2))+5.2,'k--','linewidth',2)

xlabel('$y^*$','interpreter','latex')
ylabel('$\langle u \rangle^*$','interpreter','latex')


%%
figure(2), hold on, box on
set(gca,'linewidth',1,'fontsize',18,'fontname','times')

Res = {'5000','1e4','2e4','2e4_g2','5e4','5e4_g2','1e5','1e6'};
colori = [1 2 3 3 4 4 5 6];
marker = {'o', 'o', 'o', 'x', 'o', 'x','o','o'};

for iRe = 1:8
    
    load(['./mat/channel',Res{iRe},'_AMD_RL_case2.mat']);  
   
    plot(utau_o/nu,(utau/utau_o),marker{iRe},...
        'color',colors(colori(iRe),:),'linewidth',2,'markersize',10)
    
end

plot([4000 1.2e6], [1 1], 'k--','linewidth',2)

set(gca,'xscale','log')
xlim([4000 1.2e6])
ylim([0.9 1.1])
xlabel('$Re_\tau$','interpreter','latex')
ylabel('$\langle u_\tau^m\rangle /u_\tau$','interpreter','latex')


%%

figure(3), hold on, box on
set(gca,'linewidth',1,'fontsize',18,'fontname','times')

colors = [[0, 0.4470, 0.7410];...
    [0.8500, 0.3250, 0.0980];...
    [0.9290, 0.6940, 0.1250];...
    [0.4660, 0.6740, 0.1880];...
    [0.4940, 0.1840, 0.5560];...
    [0.6350, 0.0780, 0.1840]];

Res    = {'5000','1e4','2e4','2e4_g2','5e4','5e4_g2','1e5','1e6'};
colori = [1 2 3 3 4 4 5 6];
marker = {'o', 'o', 'o', 'x', 'o', 'x','o','o'};

for iRe = 1:8
    fname = ['channel',Res{iRe},'_AMD_RL_case1.mat'];
    load(['./mat/',fname]);
    
    plot(utau_o/nu,utau/utau_o,marker{iRe},'color',colors(colori(iRe),:),'linewidth',2,'markersize',10)
end

plot([4000 1.2e6], [1 1], 'k--','linewidth',2)

set(gca,'xscale','log')
xlim([4000 1.2e6])
xlabel('$Re_\tau$','interpreter','latex')
ylabel('$\langle{u_\tau^m}\rangle/u_\tau$','interpreter','latex')


