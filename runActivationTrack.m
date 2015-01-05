%% MULTILAYER PERCEPTRON SIMULATION
% code associated with topiCS paper "Towards Integrative Dynamic Models for Adaptive Perspective-taking"
% ...by Nicholas Duran, Rick Dale, and Alexia Galati. 

% "single trial" test, pass activation one time through network ("test_perceptron_from.m"), then use output
% activations to update the input activations to network, do this for 10
% iterations to see how model converges with max activation for one of the output nodes

%%

track = [ins(10:13)];
i = 1;
while i<10,
    [err, cosne, outacts_test] = test_perceptron_from(ins,selfOutput(2,:),1,wih,who,biash,biaso);
    outacts_test = (outacts_test);
    outacts_test = outacts_test / sum(outacts_test);
    ins(10:13) = (outacts_test.^2)/sum((outacts_test.^2));
    track = [track ; outacts_test];
    i = i + 1;
end