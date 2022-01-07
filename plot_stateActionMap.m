%-----------------------------------------------------------%
% Script to plot state-action map for reinforcement         %
% learning for the VWM and LLWM (Bae & Koumoutsakos 2022)   %
%                                                           %
% Written by Jane Bae (2021)                                %
%-----------------------------------------------------------%

folder = './channel_VWM/';
file = 'agent_00_rank_000_obs.raw'; 
sizes = load([folder,'problem_size.log']);

NS = sizes(1);
NA = sizes(2);
NP = sizes(3);
NL = floor((NA*NA+NA)/2);
IREW = 3+NS+NA;
NCOL = 3+NS+NA+3;

% time steps, agent status, time in eps, states, action(1), reward, X, X
fid  = fopen([folder,file],'r');
DATA = fread(fid,Inf,'float');
NROW = floor(length(DATA)/NCOL);
DATA = reshape(DATA,NCOL,NROW);

DATA = DATA(:,DATA(8,:)~=0);

action = IREW;
reward = IREW+1;
state1 = 4; 
state2 = 6;

ind_p = (DATA(action,:) > 1.05) & (DATA(reward,:) > 12) & (DATA(reward,:) < 100) & (DATA(11,:) < 0.15) & (DATA(11,:) > 0.075) ;
ind_n = (DATA(action,:) < 0.95) & (DATA(reward,:) > 12) & (DATA(reward,:) < 100) & (DATA(11,:) < 0.15) & (DATA(11,:) > 0.075) ;

figure(1), hold on, box on
set(gca,'linewidth',1,'fontsize',18,'fontname','times')
set(gca,'xscale','log')


bin1 = 10.^linspace(2,3.2,40);
bin2 = linspace(10,30,40);
D1 = hist3([DATA(state2,ind_n)',DATA(state1,ind_n)'],'Ctrs',{bin1 bin2});

for i = 1:length(bin1)
    if max(D1(i,:)) < 12
        D1(i,:) = 0;
    else
        D1(i,:) = D1(i,:)/max(D1(i,:));
    end
end

D2 = hist3([DATA(state2,ind_p)',DATA(state1,ind_p)'],'Ctrs',{bin1 bin2});

for i = 1:length(bin1)
    if max(D2(i,:)) < 12
        D2(i,:) = 0;
    else
        D2(i,:) = D2(i,:)/max(D2(i,:));
    end
end
D = D2 - D1;
D = smoothdata(D,'gaussian',9);

contourf(bin1,bin2,D',[-1 -0.8 -0.6 -0.4 -0.1 0 0.1 0.4 0.6 0.82 1],'linewidth',1,'linecolor','none')
mycolormap = customcolormap([0 0.5 1], {'#E53E30'; '#FFFFFF'; '#2171B5'} , 9 );
colormap(mycolormap)
caxis([-1 0.9])

plot(10.^(1.5:0.1:3.5),1/0.41*log(10.^(1.5:0.1:3.5))+5,'k-','linewidth',2)

xlabel('$y^*$','interpreter','latex')
ylabel('$u^*$','interpreter','latex')

xlim(10.^[2,3.2])
ylim([10 30])


%%

folder = './channel_LLWM/';
file = 'agent_00_rank_000_obs.raw'; 
sizes = load([folder,'problem_size.log']);

NS = sizes(1);
NA = sizes(2);
NP = sizes(3);
NL = floor((NA*NA+NA)/2);
IREW = 3+NS+NA;
NCOL = 3+NS+NA+3;

% time steps, agent status, time in eps, states, action(1), reward, X, X
fid  = fopen([folder,file],'r');
DATA = fread(fid,Inf,'float');
NROW = floor(length(DATA)/NCOL);
DATA = reshape(DATA,NCOL,NROW);

DATA = DATA(:,DATA(8,:)~=0);

action = IREW;
reward = IREW+1;
state1 = 4; 
state2 = 5;

kappa = 0.41; B = 5.2;

ind_p = (DATA(action,:) > 1.05) & (DATA(reward,:) > 30);% & (DATA2(9,:) < 1.1e-3);
ind_n = (DATA(action,:) < 0.95) & (DATA(reward,:) > 30);% & (DATA2(9,:) < 1.1e-3);


figure(2), hold on, box on
set(gca,'linewidth',1,'fontsize',18,'fontname','times')

bin1 = linspace(-40,40,50);
bin2 = linspace(-5,10,50);
D1 = hist3([DATA(state2,ind_n)',DATA(state1,ind_n)'],'Ctrs',{bin1 bin2});
D1 = D1/max(D1(:));

D2 = hist3([DATA(state2,ind_p)',DATA(state1,ind_p)'],'Ctrs',{bin1 bin2});
D2 = D2/max(D2(:));
D = D2 - D1;
D = smoothdata(D);

contourf(bin1,bin2,D',[-1 -0.7 -0.5 -0.3 -0.1 0 0.1 0.3 0.5 0.7 1],'linewidth',1,'linecolor','none')
mycolormap = customcolormap([0 0.5 1], {'#E53E30'; '#FFFFFF'; '#2171B5'} , 11 );
colormap(mycolormap)
caxis([-1 0.9])

plot([-100 100],1./[kappa kappa],'k--','linewidth',1)
plot([B B],[-15 20],'k--','linewidth',1)

plot([-100 100],1./[kappa kappa],'k--','linewidth',1)
plot([B B],[-15 20],'k--','linewidth',1)
plot([-100 100], -1/log(100)*([-100 100]-B)+1/kappa,'k:','linewidth',2)
plot([-100 100], -1/log(600)*([-100 100]-B)+1/kappa,'k-','linewidth',2)
plot([-100 100], -1/log(10000)*([-100 100]-B)+1/kappa,'k-.','linewidth',2)
xlim([-40 40])
ylim([-5 10])

xlabel('$B^m$','interpreter','latex')
ylabel('$1/\kappa^m$','interpreter','latex')


