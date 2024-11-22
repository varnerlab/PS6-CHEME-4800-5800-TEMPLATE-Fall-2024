# setup the problem
include("problemsetup.jl");

# -- Solve the problem BELOW ------------------------------------------------------------------------------------ #
startstate = (1,1); # start position
number_of_episodes = 200; # how many times do we repeat the task?
number_of_iterations = 1000; # problem horizon (how many moves)

# simulate -
my_π = let

    # setup up the Q-learning agent model -
    agent_model = let
    
        α = 0.7;  # learning rate
        γ = 0.95; # discount rate
        nstates = (number_of_rows*number_of_columns);

        agent_model = build(MyQLearningAgentModel, (
            states = 𝒮, # states (coordinates)
            actions = 𝒜, # actions 
            α = α, # learning rate
            γ = γ, # discount rate
            Q = zeros(number_of_states,number_of_actions) # Hmmm. Could we do something better than this?
        ));

        agent_model
    end

    # train the Q-learning agent model -
    coordinate = startstate;
    for i ∈ 1:number_of_episodes
        
        # run an episode, and grab the Q
        result = simulate(agent_model, world_model, coordinate, number_of_iterations, 
            ϵ = 0.7);
    
        # update the agent with the Q from the last episode, and try to refine this Q
        agent_model.Q = result.Q;  # Analogy: practice make perfect ...
    end

    # dump the policy, and Q to disk -
    QQL = agent_model.Q;
    my_π = policy(QQL);
    save("QQL.jld2", Dict("QQL" => QQL, "policy" => my_π));
    
    # return the policy -
    my_π
end;
# -- Solve the problem ABOVE ------------------------------------------------------------------------------------ #