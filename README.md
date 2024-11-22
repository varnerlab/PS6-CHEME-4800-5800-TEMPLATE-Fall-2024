# Problem Set 6: Why doesn't our SARSA agent learn?
We've been studying model-free reinforcement learning, particularly the Q-learning and SARSA algorithms. Our Q-learning agent learned to estimate the optimal combination of Apples and Oranges in our grocery bag, but our SARSA agent didn't. Why not?

In this problem set, you'll implement your own SARSA agent and investigate why it doesn't learn in our simple Fruit decision task. 

### The Fruit Decision Task
In the Fruit Decision Task, the agent has a budget of $I$ USD to spend on two fruits: Apples and Oranges. 
The objective is to maximize the agent's utility, a function of the quantity of Apples and Oranges purchased. The agent can buy any amount of Apples and Oranges, but the total cost of the fruits cannot exceed the agent's budget.

The agent can choose to purchase an Apple or an Orange. The state of the environment is the number of Apples and Oranges purchased, i.e., $s = (x_{1},x_{2})$, and the action is to buy an Apple or an Orange. The agent receives a reward for each action. Purchasing an Apple costs $c_{1}$ USD/Apple, and purchasing an Orange costs $c_{2}$ USD/Orange. The agent receives a reward of $r$
$$
r = U(x_{1}, x_{2}) + \lambda \cdot \max\left(0, c_{1}x_{1} + c_{2}x_{2} - I\right)
$$
for each combination of Apples and Oranges purchased,
where $x_{1}$ and $x_{2}$ are the quantities of Apples and Oranges purchased, respectively, $U(x_{1}, x_{2})$ is the agent's utility function, and $\lambda\ll{0}$ is a penalty for exceeding the budget. The parameters associated with the Fruit Decision Task are specified in the `problemsetup.jl` file. (You don't need to modify this file.)

### Tasks
Currently, the simulation and update functions for the SARSA agent are incomplete. Your tasks are to implement these algorithms and test whether the SARSA agent learns the optimal policy for the Fruit Decision Task.

1. Implement the `simulate(agent::MySARSAAgentModel, environment::MyRectangularGridWorldModel, 
    startstate::Tuple{Int, Int}, maxsteps::Int; ϵ::Float64 = 0.2)::MySARSAAgentModel` function in the `Compute.jl` file. This requires implementing the SARSA update algorithm in the corresponding `_update(...)` function. Example implementations of the Q-learning and SARSA update algorithms are provided in the `Compute.jl` file in the `solutions` directory. You can use these implementations as a reference. However, while the reference implementation of the Q-learning algorithm is correct, the reference implementation of the SARSA algorithm is incorrect (the agent doesn't learn properly). 
1. Test your implementation by running the `testme_SARSA.jl` script. This script will create a Fruit Decision Task environment and a SARSA agent and test whether your SARSA agent learns the optimal policy for the Fruit Decision Task. You are free to modify the parameters or structure of this script to test your implementation. 
1. Run the `visualize.jl` script to visualize your policy. This script will create a Fruit Decision Task environment and plot the agent's path through the environment. You can modify the parameters or structure of this script to visualize your policy.

### Expectations
Suppose we supply a correct $Q(s, a)$ function, e.g., one produced by Q-learning. In that case, the SARSA agent should be able to replicate the optimal policy  (or near-optimal replica) for the Fruit Decision Task if the number of iterations is small. However, your SARSA agent should be able to learn the optimal policy without needing to supply the $Q(s, a)$ function.

## Assessment
This is a `fun problem` -- it should be possible to solve the Fruit problem using SARSA, but currently, it's not. 
* Thus, if you develop a SARSA implementation that runs and at least produces some (albeit incorrect) output, you'll get full credit. 
* However, if you implement a SARSA algorithm that produces the correct output starting from $Q(s, a) = 0\,\forall{s, a}$, you'll get a superpower: the ability to drop one of your lowest problem set scores. And you'll be a hero (for just one day) to your classmates.

Let's have some fun!