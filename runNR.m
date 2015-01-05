%% NORMALIZED RECURRENCE SIMULATION
% code associated with topiCS paper "Towards Integrative Dynamic Models for Adaptive Perspective-taking"
% ...by Nicholas Duran, Rick Dale, and Alexia Galati. 

% run simulation with social and task parameters set in "NR.m"

i = 1;
outs = [];
ego_bias = [1.5 1 1.5 1]; % provides initial egocentric bias from orientation layer
% ... to integration layer and from instruction layer to integration layer

while i<epochs,% && max(output_LR)<.95,
    
    output_LR = input_LR;    
    output_LR(output_LR<0) = 0; 
    output_LR = output_LR/sum(output_LR); % entire vector of activations is normalized to 0 to 1 before the next pass of activations           
    
    % update the input layers; iterated feedback, with modification
    output_LR = ego_bias.*input_LR + ego_bias.*zero_180 + see_notsee; % output layer adjusted based on new activations of instruction layer (input_LR),
    % ...instruction layer (zero_180), and social belief layer
    % ...(see_notsee). Note interaction with ego_bias
    output_LR = output_LR/sum(output_LR); % entire vector of activations is normalized to 0 to 1 before the next pass of activations

    input_LR = input_LR + ego_bias.*input_LR.*output_LR; % instruction input layer adjusted with interactive feedback from output layer changes
    input_LR = input_LR/sum(input_LR); % entire vector of activations is normalized to 0 to 1 before the next pass of activations   
    
    zero_180 = zero_180 + ego_bias.*input_LR.*zero_180; % orientation input layer adjusted with interactive feedback from output layer changes
    zero_180 = zero_180/sum(zero_180); % entire vector of activations is normalized to 0 to 1 before the next pass of activations   

    see_notsee = see_notsee + zero_180.*see_notsee; % belief input layer adjusted with interactive feedback from output layer changes
    see_notsee = see_notsee/sum(see_notsee); % entire vector of activations is normalized to 0 to 1 before the next pass of activations
            
    outs = [outs ; output_LR]; % outcome activations across epochs for all outcome nodes in integration layer
    i = i + 1;    
end