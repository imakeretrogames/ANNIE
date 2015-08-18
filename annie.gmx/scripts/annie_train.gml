//annie_train(ann_id, actual ds_list, expected ds_list)
//trains network by contrasting ds_list of expected results and actual results.
//uses back propagation technique for training
var ann_id, act_list, exp_list, error, neuron, sum, learning_constant,
act_value, exp_value, net_error;
ann_id = argument0;
act_list = argument1;
exp_list = argument2;
neuron[0,0] = 0;//neuron[ann_id,layer] = instance_id
sum = 0;
error[0,0] = 0;//error[layer,neuron] = error of actual vs. expected data
learning_constant = 0.05;//regulates learning speed by underlearning (<0.05) or overlearning (>0.05)
act_value = 0;
exp_value = 0;
net_error = 0;//the total network error of actual vs. expected from output layer

//Train Using Back Propagation//
for (i = _ANN_LAYER_COUNT[ann_id] - 1; i >= 0; i -= 1)
{
    for (j = 0; j < _ANN_NEURON_COUNT[ann_id,i]; j += 1)
    {
        //load neurons//
        neuron[i,j] = _ANN_NEURON[ann_id + i* _ANN_COUNT,j];
        
        //train weights//
        if (i == _ANN_LAYER_COUNT[ann_id] - 1)//if checking output layer
        {
            //get values//        
            act_value = ds_list_find_value(act_list,j);
            exp_value = ds_list_find_value(exp_list,j);
            
            //find error//
            error[i,j] = (exp_value - act_value);
            //neuron[i,j].threshold -= learning_constant * error[i,j] * act_value;
            net_error += error[i,j];
            
            //teach weight//
            for (k = 0; k < neuron[i,j].inputCount; k += 1)
            {
                neuron[i,j].weight[k] += learning_constant * error[i,j];
            }
        }
        else if (i > 0)//if checking a hidden layer
        {
            //get values//
            act_value = neuron[i,j].output;
            exp_value = 0;
            
            for (k = 0; k < _ANN_NEURON_COUNT[ann_id,i + 1]; k += 1)
            {
                exp_value += error[i + 1,k];
            }
            
            //find error//
            error[i,j] = exp_value;
            //neuron[i,j].threshold -= learning_constant * error[i,j] * act_value;
            
            //teach weight//
            for (k = 0; k < neuron[i,j].inputCount; k += 1)
            {
                neuron[i,j].weight[k] += learning_constant * error[i,j];
            }
        }
        else//if checking input layer
        {
            //get values//
            act_value = neuron[i,j].output;
            exp_value = 0;
            
            for (k = 0; k < _ANN_NEURON_COUNT[ann_id,i + 1]; k += 1)
            {
                exp_value += error[i + 1,k]
            }
            
            //find error//
            error[i,j] = exp_value;
            //neuron[i,j].threshold -= learning_constant * error[i,j] * act_value;
            
            //teach weight//
            neuron[i,j].weight[0] += error[i,j];
        }
    }
}
return net_error;
