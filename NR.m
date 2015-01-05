%% NORMALIZED RECURRENCE SIMULATION
% code associated with topiCS paper "Towards Integrative Dynamic Models for Adaptive Perspective-taking"
% ...by Nicholas Duran, Rick Dale, and Alexia Galati. 

% set parameters and call run command file (runNR.m)

%% corresponds to Figure 3a
 
output_LR = [.25 .25 .25 .25]; % object integration layer (L,R), uniform initial activation
input_LR = [.5 .5 0 0]; % instruction input layer (L,R), left-instruction nodes activated
see_notsee = [.25 .25 .25 .25]; % belief input layer (see, not see), uniform initial activation
zero_180 = [.5 0 .5 0]; % orientation input layer (0, 180), 0-degree nodes activated
epochs = 20; % iteration cycles

runNR % run simulation to retrieve output "outs" from "runNR.m"
% ego wins at whatever 0-degree direction is given

subplot(1,3,1),plot(2:epochs,outs(:,[1 3]),'k-',2:epochs,outs(:,[2 4]),'k--');
xlabel('Time steps','fontsize',15),ylabel('Activation','fontsize',15),set(gca,'fontsize',15);
title('0-degree, L instruct, no social'),text(0.5,.96,'(a)','fontsize',15);

%% corresponds to Figure 3b 

output_LR = [.25 .25 .25 .25]; % uniform initial activation
input_LR = [.5 .5 0 0]; % left-instruction nodes activated
see_notsee = [.5 0 .5 0]; % belief information activated (i.e., partner "can see")
zero_180 = [0 .5 0 .5]; % 180-degree nodes activated

runNR
% if other is at 180, but beliefs partner can see, tends to settle on
% ...ego-centric option in integration layer

% (similar to Duran et al., 2011)

subplot(1,3,2),plot(2:epochs,outs(:,[1 3]),'k-',2:epochs,outs(:,[2 4]),'k--');
xlabel('Time steps','fontsize',15),ylabel('Activation','fontsize',15),set(gca,'fontsize',15);;
title('180-degree, L instruct, other can see'),text(0.5,.675,'(b)','fontsize',15);

%% corresponds to Figure 3c

output_LR = [.25 .25 .25 .25]; % uniform initial activation
input_LR = [.5 .5 0 0]; % left-instruction nodes activated
see_notsee = [0 .5 0 .5]; % belief information activated (i.e., partner "cannot see")
zero_180 = [0 .5 0 .5]; % 180-degree nodes activated  

runNR
% if other is at 180, but beliefs partner cannot see, tends to settle on
% ...other-centric option in integration layer

subplot(1,3,3),plot(2:epochs,outs(:,[1 3]),'k-',2:epochs,outs(:,[2 4]),'k--');
xlabel('Time steps','fontsize',15),ylabel('Activation','fontsize',15),set(gca,'fontsize',15);;
title('180-degree, L instruct, other cannot see'),text(0.5,.96,'(c)','fontsize',15);

%% print figure

set(gcf, 'InvertHardCopy', 'off');
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'points');
set(gcf,'color','white','PaperPosition',[1 1000 1200 300]);

saveas(gcf,'NRmodel.eps','epsc')

