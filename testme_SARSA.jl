# setup the problem
include("problemsetup.jl");

# -- Solve the problem BELOW ------------------------------------------------------------------------------------ #
startstate = (1,1); # start position
number_of_episodes = 1000; # how many times do we repeat the task?
number_of_iterations = 20; # problem horizon (how many moves)

# simulate -
my_π = let

    # setup up the SARSA agent model -
    agent_model_SARSA = let

        # load -
        saved_data = load("QQL.jld2");
    
        α = 0.7;  # learning rate
        γ = 0.95; # discount rate
        nstates = (number_of_rows*number_of_columns);
        Q = zeros(number_of_states,number_of_actions) # Hmmm. Could we do something better than this?
        #Q = saved_data["QQL"]; # use the Q-learning Q as a starting point

        agent_model = build(MySARSAAgentModel, (
            states = 𝒮, # states (coordinates)
            actions = 𝒜, # actions 
            α = α, # learning rate
            γ = γ, # discount rate
            Q = Q,# Hmmm. Could we do something better than this?
            my_π = policy(Q) # policy
        ));

        agent_model
    end

    # Train the SARSA agent model -
    coordinate = startstate;
    T = 1.0;
    for i ∈ 1:number_of_episodes

        T = (0.99)*T; # decrease the temperature ... we get less random, each time we repeat the task
        
        # run an episode, and grab the Q
        result = simulate(agent_model_SARSA, world_model, coordinate, number_of_iterations, 
            ϵ = T);
    
        # update the agent with the Q from the last episode, and try to refine this Q
        agent_model_SARSA.Q = result.Q;  # Analogy: practice make perfect ...
        agent_model_SARSA.my_π = policy(agent_model_SARSA.Q); # update the policy
    end
    my_π = agent_model_SARSA.my_π; # return the policy
end;
# -- Solve the problem ABOVE ------------------------------------------------------------------------------------ #