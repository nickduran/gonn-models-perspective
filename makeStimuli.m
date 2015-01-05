%% MULTILAYER PERCEPTRON SIMULATION
% code associated with topiCS paper "Towards Integrative Dynamic Models for Adaptive Perspective-taking"
% ...by Nicholas Duran, Rick Dale, and Alexia Galati. 

% generate initial stimuli to train model (see Figure 4b and Figure 5a) 

%%

% social belief input (see Figure 4b for code correspondence)
none = [1 0 0 0 0]; %n/a (none)
siml = [0 1 0 0 0]; %Re (believe partner to be real)
actl = [0 0 1 0 0]; %~Re (belive partner to be simulated)
see = [0 0 0 1 0]; %Se (believe partner can see)
notsee = [0 0 0 0 1]; %~Se (believe partner cannot see)

% instruction input
LfLang = [1 0 0 0]; %L (left-language)
TpLang = [0 1 0 0]; %A (above-language)
RtLang = [0 0 1 0]; %R (right-language)
BtLang = [0 0 0 1]; %B (below-language)

% object position input
TpRtO = [1 0 0 0]; %position 1
BtRtO = [0 1 0 0]; %position 2
BtLfO = [0 0 1 0]; %position 3
TpLfO = [0 0 0 1]; %position 4

% orientation input
d0 = [1 0 0 0]; %0 
d90L = [0 1 0 0]; %90a
d90R = [0 0 1 0]; %90b
d180 = [0 0 0 1]; %180

% below produces table setups with (in some cases) correct outputs
% ...some do not have correct outputs, as they are ambiguous

% simple one-item input, unambiguous at orientation 0 
selfLeftInput = [none LfLang BtLfO d0; none LfLang TpLfO d0]; % e.g., input: [no social belief input, left-language, position 3, orientation at 0; no social belief input, left-language, position 4, orientation at 0]  
selfLeftOutpt = [BtLfO; TpLfO]; % e.g., expected output: [position 3, position 4]
selfRightInput = [none RtLang BtRtO d0; none RtLang TpRtO d0];
selfRightOutpt = [BtRtO; TpRtO];
selfTopInput = [none TpLang TpLfO d0; none TpLang TpRtO d0];
selfTopOutpt = [TpLfO; TpRtO];
selfBottomInput = [none BtLang BtRtO d0; none BtLang BtLfO d0];
selfBottomOutpt = [BtRtO; BtLfO];

selfInput = [selfLeftInput ; selfRightInput ; selfTopInput ; selfBottomInput];
selfOutput = [selfLeftOutpt ; selfRightOutpt ; selfTopOutpt ; selfBottomOutpt];

% two-item input, unambiguous at orientation 0, providing axis contrast
selfLeftInput2 = [none LfLang (BtLfO+BtRtO)/2 d0; none LfLang (TpLfO+TpRtO)/2 d0]; % e.g., input: [no social belief input, left-language, position 2 and 3, orientation at 0; no social belief input, left-language, position 4 and 1, orientation at 0] 
selfLeftOutpt2 = [BtLfO; TpLfO]; % e.g., expected output: [position 3, position 4]
selfRightInput2 = [none RtLang (BtRtO+BtLfO)/2 d0; none RtLang (TpRtO+TpLfO)/2 d0];
selfRightOutpt2 = [BtRtO; TpRtO];
selfTopInput2 = [none TpLang (TpLfO+BtLfO)/2 d0; none TpLang (TpRtO+BtRtO)/2 d0];
selfTopOutpt2 = [TpLfO; TpRtO];
selfBottomInput2 = [none BtLang (BtRtO+TpRtO)/2 d0; none BtLang (BtLfO+TpLfO)/2 d0];
selfBottomOutpt2 = [BtRtO; BtLfO];

selfInput2 = [selfLeftInput2 ; selfRightInput2 ; selfTopInput2 ; selfBottomInput2];
selfOutput2 = [selfLeftOutpt2 ; selfRightOutpt2 ; selfTopOutpt2 ; selfBottomOutpt2];

% the idea of transformation: left is different at degree-90; no social belief information
TransLeftInputO90 = [none LfLang (TpLfO+BtRtO)/2 d90R; none LfLang (TpRtO+BtLfO)/2 d90L];
TransLeftOutptO90 = [BtRtO; TpRtO];
TransRightInputO90 = [none RtLang (TpLfO+BtRtO)/2 d90R; none RtLang (TpRtO+BtLfO)/2 d90L];
TransRightOutptO90 = [TpLfO; BtLfO];
TransTopInputO90 = [none TpLang (TpRtO+BtLfO)/2 d90R; none TpLang (TpLfO+BtRtO)/2 d90L];
TransTopOutptO90 = [BtLfO; BtRtO];
TransBottomInputO90 = [none BtLang (TpRtO+BtLfO)/2 d90R; none BtLang (TpLfO+BtRtO)/2 d90L];
TransBottomOutptO90 = [TpRtO; TpLfO];

TransInputO90 = [TransLeftInputO90 ; TransRightInputO90 ; TransTopInputO90 ; TransBottomInputO90];
TransOutputO90 = [TransLeftOutptO90 ; TransRightOutptO90 ; TransTopOutptO90 ; TransBottomOutptO90];

% the idea of transformation: left is different at degree-90; but now introducing social belief information for training: partner is there and can't see you
OtherLeftIn = [(actl+notsee) LfLang (TpLfO+BtRtO)/2 (d0+d90R)/2; (actl+notsee) LfLang (TpRtO+BtLfO)/2 (d0+d90L)/2];
OtherLeftOutpt = [BtRtO; TpRtO];
OtherRightInput = [(actl+notsee) RtLang (TpLfO+BtRtO)/2 (d0+d90R)/2; (actl+notsee) RtLang (TpRtO+BtLfO)/2 (d0+d90L)/2];
OtherRightOutpt = [TpLfO; BtLfO];
OtherTopInput = [(actl+notsee) TpLang (TpRtO+BtLfO)/2 (d0+d90R)/2; (actl+notsee) TpLang (TpLfO+BtRtO)/2 (d0+d90L)/2];
OtherTopOutpt = [BtLfO; BtRtO];
OtherBottomInput = [(actl+notsee) BtLang (TpRtO+BtLfO)/2 (d0+d90R)/2; (actl+notsee) BtLang (TpLfO+BtRtO)/2 (d0+d90L)/2];
OtherBottomOutpt = [TpRtO; TpLfO];

OtherIn = [OtherLeftIn ; OtherRightInput ; OtherTopInput ; OtherBottomInput];
OtherOut = [OtherLeftOutpt ; OtherRightOutpt ; OtherTopOutpt ; OtherBottomOutpt];





% % in ambiguity regarding perspective, the self wins when it is learned first?
% % let's build the ambiguous stuff above but mix the perspectives
% LeftInputAmb = [none LfLang (TpLfO+BtRtO)/2 (d0+d90R)/2; none LfLang (TpRtO+BtLfO)/2 (d0+d90L)/2];
% RightInputAmb = [none RtLang (TpLfO+BtRtO)/2 (d0+d90R)/2; none RtLang (TpRtO+BtLfO)/2 (d0+d90L)/2];
% TopInputAmb = [none TpLang (TpRtO+BtLfO)/2 (d0+d90R)/2; none TpLang (TpLfO+BtRtO)/2 (d0+d90L)/2];
% BottomInputAmb = [none BtLang (TpRtO+BtLfO)/2 (d0+d90R)/2; none BtLang (TpLfO+BtRtO)/2 (d0+d90L)/2];
% % just use any output above as placeholder;  no correct answer due to ambiguity
% InputAmb = [LeftInputAmb ; RightInputAmb ; TopInputAmb ; BottomInputAmb];

% % with some other info
% LeftInputAmbOther = [(actl+notsee) LfLang (TpLfO+BtRtO)/2 (d0+d90R)/2; (actl+notsee) LfLang (TpRtO+BtLfO)/2 (d0+d90L)/2];
% RightInputAmbOther = [(actl+notsee) RtLang (TpLfO+BtRtO)/2 (d0+d90R)/2; (actl+notsee) RtLang (TpRtO+BtLfO)/2 (d0+d90L)/2];
% TopInputAmbOther = [(actl+notsee) TpLang (TpRtO+BtLfO)/2 (d0+d90R)/2; (actl+notsee) TpLang (TpLfO+BtRtO)/2 (d0+d90L)/2];
% BottomInputAmbOther = [(actl+notsee) BtLang (TpRtO+BtLfO)/2 (d0+d90R)/2; (actl+notsee) BtLang (TpLfO+BtRtO)/2 (d0+d90L)/2];
% % just use any output above as placeholder;  no correct answer due to ambiguity
% InputAmbOther = [LeftInputAmbOther ; RightInputAmbOther ; TopInputAmbOther ; BottomInputAmbOther];






