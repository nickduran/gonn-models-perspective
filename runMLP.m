%% MULTILAYER PERCEPTRON SIMULATION
% code associated with topiCS paper "Towards Integrative Dynamic Models for Adaptive Perspective-taking"
% ...by Nicholas Duran, Rick Dale, and Alexia Galati. 

% MAIN PROGRAM, START HERE: calls programs to generates stimuli (makeStimuli.m), to train with ego then
% ...other-centric and social learning (train_perceptron_fresh.m, train_perceptron_from.m) (Figure 5a), 
% ...and to run the single trial tests (runActivationTrack.m, test_perceptron_from.m) (Figure 5b-c).

%% run training

clear all
makeStimuli % call program to generate stimuli

hids = 10; % hidden layer size
lr = .1; % learning rate

% train to favor egocentric; fresh = initially randomize weight spaces;
% ...note: simple one-item input, unambiguous at orientation 0 AND two-item input, unambiguous at orientation 0, providing axis contrast 
[wih, who, biash, biaso, err, cosne, outacts] = train_perceptron_fresh([selfInput;selfInput2],[selfOutput;selfOutput2],hids,2000,lr);

% train with alternative non-egocentric; from = take weight space from the fresh run above
% ...note: two-item input, unambiguous at orientation 0, providing axis contrast AND the idea of transformation: left is different at degree-90; no social belief information 
[wih, who, biash, biaso, err2, cosne, outacts2] = train_perceptron_from([selfInput2;TransInputO90],[selfOutput2;TransOutputO90],10000,lr,wih,who,biash,biaso);

% selfOutput just a placeholder; no training (ambiguous input)
% [err, cosne, outacts_test] = test_perceptron_from(InputAmb,selfOutput,8,wih,who,biash,biaso);

% train with other-centric social belief information
% ...note: all input types now introduced and trained together
[wih, who, biash, biaso, err3, cosne, outacts3] = train_perceptron_from([selfInput;selfInput2;TransInputO90;OtherIn],[selfOutput;selfOutput2;TransOutputO90;OtherOut],10000,lr,wih,who,biash,biaso);

%% generate Figure 5a error rate across output nodes

errs = slidefun(@mean,10,[err err2 err3]);
subplot(1,3,1),hold off,plot(errs,'k.') 
set(gca, 'FontSize', 15,'ylim',[0 .35]); 
xlabel('Timestep'),ylabel('Error');
title('Training the network'),text(1000,0.33,'(a)','fontsize',15);

%% run "single trial" tests, generate Figures 5b-c activation on candidate objects (egocentric or other-centric choice)

% UPDATE the input (candidate objects) as a function of what the system initially thinks ("ins")... then we will iterate to see where it goes
ins = [none LfLang (TpLfO+BtRtO)/2 (d0*.9+d90R*.1)]; % what the system initially thinks: left-instructions, no social belief informationg given, initial ego activation at 90%
runActivationTrack; % calls "single trial" test code
subplot(1,3,2),hold off,plot(1:10,track(:,2),'k-',1:10,track(:,4),'k--','linewidth',2)
set(gca, 'FontSize', 15,'ylim',[0 1]); 
xlabel('Timestep'),ylabel('Activation on object');
title('No interactivity, initial ego activation 90%'),text(.5,0.95,'(b)','fontsize',15);

ins = [(notsee) LfLang (TpLfO+BtRtO)/2 (d0*.9+d90R*.1)]; % hat the system initially thinks: left-instructions, social belief informationg now given (cannot see), initial ego activation at 90, network can flip!
runActivationTrack;
subplot(1,3,3),hold off,plot(1:10,track(:,2),'k-',1:10,track(:,4),'k--','linewidth',2)
set(gca, 'FontSize', 15,'ylim',[0 1]); 
xlabel('Timestep'),ylabel('Activation on object');
title('"Other cannot see", initial ego activation 90%'),text(.5,0.95,'(c)','fontsize',15);

%% UNCOMMENT BELOW TO PRINT FIGURE

% set(gcf, 'InvertHardCopy', 'off');
% set(gcf, 'PaperPositionMode', 'manual');
% set(gcf, 'PaperUnits', 'points');
% set(gcf,'color','white','PaperPosition',[1 1000 1200 300]);
% saveas(gcf,'MLPresults.eps','epsc')



