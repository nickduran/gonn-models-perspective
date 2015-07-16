gonn-models-perspective
=======================

GONN (good ole neural network models) for topiCS paper on perspective-taking (Nick Duran, Rick Dale, and Alexia Galati). Code written for Matlab.

Normalized recurrence network for real-time processing (see Section 4.1; Figures 2 and 3 in manuscript)
=============
Overview of process involved in running model:

Relevant programs:
NR.m, runNR.m

1) In runNR.m: A hypothetical trial from Duran et al., (2014) simulated as an interaction over 20 epochs, whereby the output "left/right" choice integration layer (output_LR) is updated as an interaction between multiple input layers:

1a) Egocentric orientation layer: Initated at: [1.5 1 1.5 1] 
1b) Instruction layer
1c) Orientation input layer
1d) Belief input layer

Each of these input layers is updated at each iteration and new activations normalized from 0 to 1 before the next pass of activations (see code with extensive comments)

2) In NR.m: The above is called after setting the inital activation weights of output, instruction, orientation, and belief input layers. 

To generate Figure 3a in manuscript, these are set at:
output_LR = [.25 .25 .25 .25]; % object integration layer (L,R), uniform initial activation
input_LR = [.5 .5 0 0]; % instruction input layer (L,R), left-instruction nodes activated
see_notsee = [.25 .25 .25 .25]; % belief input layer (see, not see), uniform initial activation
zero_180 = [.5 0 .5 0]; % orientation input layer (0, 180), 0-degree nodes activated

To generate Figure 3b in manuscript, these are set at:
output_LR = [.25 .25 .25 .25]; % uniform initial activation
input_LR = [.5 .5 0 0]; % left-instruction nodes activated
see_notsee = [.5 0 .5 0]; % belief information activated (i.e., partner "can see")
zero_180 = [0 .5 0 .5]; % orientation input layer 180-degree nodes activated

To generate Figure 3c in manuscript, these are set at:
output_LR = [.25 .25 .25 .25]; % uniform initial activation
input_LR = [.5 .5 0 0]; % left-instruction nodes activated
see_notsee = [0 .5 0 .5]; % belief information activated (i.e., partner "cannot see")
zero_180 = [0 .5 0 .5]; % orientation input layer 180-degree nodes activated  

After 20 epochs, object "choice" is selected based on highest activation stabilization.

Multilayer Perceptron that Performs Spatial Transformation and Learning (see Section 4.2; Figures 4 and 5 in manuscript)

Overview of process involved in running models:

Relevant programs:
makeStimuli.m, runActivationTrack.m, runMLP.m, slidefun.m, test_perceptron_from.m, train_perceptron_fresh.m, and train_perceptron_from.m:

1) Call runMLP: Start here. This is the main program to generates stimuli (makeStimuli.m), to train with ego then other-centric and social learning (train_perceptron_fresh.m, train_perceptron_from.m) (Figure 5a), and to run the single trial tests (runActivationTrack.m, test_perceptron_from.m) (Figure 5b-c).

1a) In runMLP: Hidden layer size is set at 10 nodes, the learning rate at 0.1
1b) In runMLP, first call train_perceptron_fresh.m: a model is first trained (2000 iterations) to favor egocentric perspective based on initially random weight space and using standard backpropagation. Stimuli input (from makeStimuli.m), consists of simple one-item input, unambiguous at orientation 0 AND two-item input, unambiguous at orientation 0, providing axis contrast (see code with extensive comments for more information). 
1c) In runMLP, next call train_perceptron_from.m: an updated model is trained (10000 iterations) with alternative non-egocentric perspective, also taking as input the output from train_perceptron_fresh.m (above) and using and using standard backpropagation. Stimuli input (from makeStimuli.m) consists of two-item input, unambiguous at orientation 0, providing axis contrast AND the idea of transformation: left is different at degree-90; no social belief information
1d) In runMLP, model above trained further (10000 iterations) with other-centric social belief information now added (see makeStimuli.m), such that all input types now introduced and trained together.

Figure 5a: depicts error rate of 1b, 1c, and 1d above. 

3) In runMLP: call runActivationTrack.m: "Single trial" test code, generating Figures 5b-c (activation of candidate objects egocentric or other-centric choice). Calls test_perception_from.m based on input from makeStimuli.m. Operates by passing activation one time through network, then use=ing output activations to update the input activations to network, and does this for 10 iterations to see how model converges with max activation for one of the output nodes.

3a) Figure 5b based on initial activation such that model initially "thinks:" left-instructions, no social belief informationg given, initial ego activation at 90% 
3b) Figure 5c based on initial activation such that model initially "thinks:" left-instructions, social belief information now given (cannot see), initial ego activation at 90, network can flip!

