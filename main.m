load('spikeTime_inputs.mat');
input_fire_times = peakLocs;
load('spikeTimings_desired.mat');
desired_output_fire_times = peakLocs;

inputNeuron;
%20 connections -one from each input to each hidden
%20 connections - one from each output to the output

%need to keep for each neuron:
%1. a list of times they have fired
%2. a list of the weights coming towards them
nodeCount = 8;
input_hidden_weights = randn(node_count,1);
hidden1_fire_times = zeros(node_count,20);

hidden1_hidden2_weights = randn(node_count,node_count);
hidden2_fire_times = randn(20,20);

hidden2_output_weights = randn(20,1);
output_fire_times = zeros(20,20);
threshold = 1;

%run the network
pointer = 0;
for i = 1:0.0001:20
    %check if input neuron has fired
    if i >= input_fire_times(pointer)
        pointer = pointer + 1;
    end
    
    %check if the hidden neurons have fired
    for j = 1:nodeCount
        potential = hiddenPotential(j, i, input_hidden_weights, input_fire_times(j,:));
        
        %if passes the threshold, add a firing time to that neuron
        if potential >= threshold
            hidden1_fire_times(nnz(hidden1_fire_times)+1) = i;     
        end
        
    end
    
    %check if the 2nd layer hidden neurons have fired
     for j = 1:nodeCount
        potential = hiddenPotential(j, i, hidden1_hidden2_weights, hidden1_fire_times(j,:));
        
        %if passes the threshold, add a firing time to that neuron
        if potential >= threshold
            hidden2_fire_times(nnz(hidden2_fire_times)+1) = i;     
        end
        
    end
    
    %check if the output neuron has fired
    %NEED TO CHANGE SO THAT THERE ARE 8 OUTPUT NEURONS, AS SPIKEPROP ONLY
    %ALLOWS FOR A SINGLE SPIKE
    
    %IDEALLY HAVE 2 HIDDEN LAYERS, BUT MAKE WORK WITH 1 HIDDEN LAYER FOR
    %NOW
    for j = 1:nodeCount
        potential = hiddenPotential(j, i, hidden2_output_weights);
        if potential >= threshold
            output_fire_times(nnz(hidden_fire_times) + 1) = i;

        end
    end
    
    
    
end

