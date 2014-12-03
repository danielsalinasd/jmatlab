function timesteps = tsteps(loading)
if loading == 0
    timesteps = [1,3;6,9;15,18];
elseif loading == 1
    timesteps = [4,5;10,14;19,23];
end