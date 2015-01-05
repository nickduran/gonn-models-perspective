%% MULTILAYER PERCEPTRON SIMULATION
% code associated with topiCS paper "Towards Integrative Dynamic Models for Adaptive Perspective-taking"
% ...by Nicholas Duran, Rick Dale, and Alexia Galati. 

% no training (backprop), network used with runActivationTrack.m to generate "single trial" tests (see Figure 5b-c) 

%%

%
% train_perceptron(sents,targs,hids,numpres,lr,mom)
% . sents => distributed input corpus
% . targs => distributed output corpus for training/prediction
% . hids => num hidden units 
% . lr => learning rate
% . mom => momentum
%
% outputs [wih who biash biaso err cosne]
% . wih => weights from input to hidden
% . who => " hidden to output 
% . biash => " bias to hidden
% . biaso => " bias to output
% . err => error from each presentation (not trial)
% . cosne => cosine from each presentation
% . outacts => the shit it predicted over training

%%
   
function [err, cosne, outacts] = test_perceptron_from(sents,targs,numpres,wih,who,biash,biaso)

% get the stuff
outs = size(targs,2);
ins = size(sents,2);

% initialize weights from [-.5 to .5] % instead, inherit from input arguments
%wih = rand(ins,hids) - .5;
%who = rand(hids,outs) - .5;
%biash = zeros(1,hids);
%biaso = zeros(1,outs);

i = 1;
hits = [];
err = [];
cosne = [];
outacts = [];

for epochs=1:numpres,
        
    % take the current sentence, and generate output
    inact = sents(i,:);
    net = inact * wih + biash;
    hidact = 1./(1+exp(-net));
    net = hidact * who + biaso;
    outact = 1./(1+exp(-net));

    % retrieve target
    targ = targs(i,:);

    outacts = [outacts ; outact];
    err = [err mean((targ - outact).^2)];   
    cosne = [cosne (targ*outact')/(norm(targ)*norm(outact))];
    
    % apply standard backprop; only testing
    %deltao = outact .* (1 - outact) .* (targ - outact);
    %dwho = lr * hidact' * deltao;
    %sumterm = deltao * who';
    %deltah = hidact .* (1 - hidact) .* sumterm;
    %dwih = lr * inact' * deltah;    

    %who = who + dwho;
    %wih = wih + dwih;

    %biash = biash + lr * deltah;
    %biaso = biaso + lr * deltao;
    %
        
    % make sure we don't exceed available in corpus
    i = i + 1;
    if i==size(sents,1)+1,
        i = 1; % if so, let's start over
    end    
    
end

